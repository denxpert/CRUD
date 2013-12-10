//
//  DatabaseController.m
//  Movies
//
//  Created by Don Miller on 4/2/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import "DatabaseController.h"
#import "Movie.h"

@implementation DatabaseController

sqlite3 *sqlDatabase;

-(id) init
{   //  Call super init to invoke superclass initiation code
    if ((self = [super init]))
    {   //  set the reference to the database
        dbName = @"movies.sqlite3";
        [self initializeDatabase];
    }
    return self;
}

- (void) initializeDatabase
{
    [self CopyDbToDocumentsFolder];
    
    //Get list of directories in Document path
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Define new path for database
    NSString *path = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:dbName];
    
    // Get the database from the application bundle.
    NSLog(@"%@", path);
    // Open the database.
    if (sqlite3_open([path UTF8String], &sqlDatabase) == SQLITE_OK)
    {
        NSLog(@"Opening Database");
    }
    else
    {   // Call close to properly clean up
        sqlite3_close(sqlDatabase);
        NSAssert1(0, @"Failed to open database: '%s'.",
                  sqlite3_errmsg(sqlDatabase));
    }
}

-(void) CopyDbToDocumentsFolder
{
    NSError *err=nil;
    
    _fileMgr = [NSFileManager defaultManager];
    
    NSString *dbpath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
    
    NSString *copydbpath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    // lets only copy the db if it does not exist
    if (![_fileMgr fileExistsAtPath:copydbpath])
    {
        if(![_fileMgr copyItemAtPath:dbpath toPath:copydbpath error:&err])
        {
            UIAlertView *tellErr = [[UIAlertView alloc] initWithTitle:_title message:@"Unable to copy database." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [tellErr show];
        }
    }
}

-(NSString *) GetDocumentDirectory
{
    _fileMgr = [NSFileManager defaultManager];
    _homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    
    return _homeDir;
}

-(void) closeDatabase
{
    // Close the database.
    if (sqlite3_close(sqlDatabase) != SQLITE_OK) {
        NSAssert1(0, @"Error: failed to close database: '%s'.",
                  sqlite3_errmsg(sqlDatabase));
    }
}

-(NSMutableArray*) getAllMovies
{
    NSMutableArray *arrayMovies = [[NSMutableArray alloc] init];
    
    const char *mySql = "SELECT id, title, year, rating, length FROM movies";
    const int movieId = 0;
    const int movieTitle = 1;
    const int movieYear = 2;
    const int movieRating = 3;
    const int movieLength = 4;
    
    //  Declare the SQLite statement object that will hold our result set
    sqlite3_stmt *myStatement;
    
    int sqlResult = sqlite3_prepare_v2(sqlDatabase, mySql, -1, &myStatement, NULL);
	if ( sqlResult== SQLITE_OK)
    {
        while (sqlite3_step(myStatement) == SQLITE_ROW)
        {
            char *name = (char *)sqlite3_column_text(myStatement, movieTitle);
            char *rating = (char *)sqlite3_column_text(myStatement, movieRating);
            char *length = (char *)sqlite3_column_text(myStatement, movieLength);
            
            Movie *movies = [[Movie alloc]
                 initWithMovieId:sqlite3_column_int(myStatement, movieId)
                       WithTitle:(name) ? [NSString stringWithUTF8String:name] : @""
                        WithYear:sqlite3_column_double(myStatement, movieYear)
                      WithRating:(rating) ? [NSString stringWithUTF8String:rating] : @""
                      WithLength:(length) ? [NSString stringWithUTF8String:length] : @""];
            [arrayMovies addObject:movies];
            movies = nil;
        }
        sqlite3_finalize(myStatement);
    }
    else {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }
    return arrayMovies;
}

-(void) insertMovie:(NSString *) fldTitle
               Year:(int) fldYear
             Rating:(NSString *) fldRating
             Length:(NSString *) fldLength
{
    NSString *documentPath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    if(!(sqlite3_open([documentPath UTF8String], &sqlDatabase) == SQLITE_OK))
    {
        NSLog(@"An error has occured.");
        return;
    }
    else
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Movies (title, year, rating, length) VALUES ('%@',%i, '%@', '%@')", fldTitle, fldYear, fldRating, fldLength];
        
        const char *sql = [insertSQL UTF8String];
        
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare_v2(sqlDatabase, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
            return;
        }
        else
        {
            if(sqlite3_step(sqlStatement)==SQLITE_DONE)
            {
                sqlite3_finalize(sqlStatement);
                sqlite3_close(sqlDatabase);
            }
        }
    }
}

-(void) updateMovie:(int) fldMovieId
              Title:(NSString *) fldTitle
               Year:(int) fldYear
             Rating:(NSString *) fldRating
             Length:(NSString *) fldLength
{
    NSString *documentPath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    if(!(sqlite3_open([documentPath UTF8String], &sqlDatabase) == SQLITE_OK))
    {
        NSLog(@"An error has occured.");
        return;
    }
    else
    {
        NSString *updateSQL = [NSString stringWithFormat:
                               @"UPDATE movies SET Title='%@', year=%i, rating='%@', length='%@' WHERE id=%i", fldTitle, fldYear, fldRating, fldLength, fldMovieId];
        
        const char *sql = [updateSQL UTF8String];
        
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare_v2(sqlDatabase, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
            return;
        }
        else
        {
            if(sqlite3_step(sqlStatement)==SQLITE_DONE)
            {
                sqlite3_finalize(sqlStatement);
                sqlite3_close(sqlDatabase);
            }
        }
    }
}

-(void) deleteMovie:(int) fldMovieId
{
    NSString *documentPath = [self.GetDocumentDirectory stringByAppendingPathComponent:dbName];
    
    if(!(sqlite3_open([documentPath UTF8String], &sqlDatabase) == SQLITE_OK))
    {
        NSLog(@"An error has occured.");
        return;
    }
    else
    {
        NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM movies WHERE id = '%i'", fldMovieId];
        const char *sql = [deleteSQL UTF8String];
        
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare_v2(sqlDatabase, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Problem with prepare statement");
            return;
        }
        else
        {
            if(sqlite3_step(sqlStatement)==SQLITE_DONE)
            {
                sqlite3_finalize(sqlStatement);
                sqlite3_close(sqlDatabase);
            }
        }
    }
}

@end



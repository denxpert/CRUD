//
//  DatabaseController.h
//  Movies
//
//  Created by Don Miller on 4/2/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>  // Observe this import
#import "Movie.h"    // Observe this import too

@interface DatabaseController : NSObject
{
    NSString *dbName;
}

@property (nonatomic,retain) NSFileManager *fileMgr;
@property (nonatomic,retain) NSString *homeDir;
@property (nonatomic,retain) NSString *title;

-(void) initializeDatabase;
-(void) closeDatabase;
-(void) CopyDbToDocumentsFolder;
-(NSString *) GetDocumentDirectory;

-(NSMutableArray*) getAllMovies;

-(void) insertMovie:(NSString *) fldTitle
               Year:(int) fldYear
             Rating:(NSString *) fldRating
             Length:(NSString *) fldLength;

-(void) updateMovie:(int) fldMovieId
              Title:(NSString *) fldTitle
               Year:(int) fldYear
             Rating:(NSString *) fldRating
             Length:(NSString *) fldLength;

-(void) deleteMovie:(int) fldMovieId;
@end

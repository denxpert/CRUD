//
//  Movie.m
//  Movies
//
//  Created by Don Miller on 4/2/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(id)  initWithMovieId: (int) pMovieId
             WithTitle:(NSString *) pTitle
              WithYear: (int) pYear
            WithRating: (NSString *) pRating
            WithLength: (NSString *) pLength
{
    if ((self=[super init]))
    {
        self.intMovieId = pMovieId;
        self.strTitle = pTitle;
        self.intYear = pYear;
        self.strRating = pRating;
        self.strLength = pLength;
        return self;
    }
    else
    {
        return nil;
    }
}

@end

//
//  Movie.h
//  Movies
//
//  Created by Don Miller on 4/2/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property(nonatomic) int      intMovieId;
@property(nonatomic, strong)  NSString *strTitle;
@property(nonatomic) int      intYear;
@property(nonatomic, strong)  NSString *strRating;
@property(nonatomic, strong)  NSString *strLength;

-(id)  initWithMovieId: (int) pMovieId
             WithTitle:(NSString *) pTitle
              WithYear: (int) pYear
            WithRating: (NSString *) pRating
            WithLength: (NSString *) pLength;

@end

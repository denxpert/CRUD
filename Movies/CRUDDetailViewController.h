//
//  CRUDDetailViewController.h
//  Movies
//
//  Created by Don Miller on 4/2/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "DatabaseController.h"

@interface CRUDDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, strong) IBOutlet UITextField *txtMovieID;
@property (nonatomic, strong) IBOutlet UITextField *txtTitle;
@property (nonatomic, strong) IBOutlet UITextField *txtYear;
@property (nonatomic, strong) IBOutlet UITextField *txtRating;
@property (nonatomic, strong) IBOutlet UITextField *txtLength;
@property (nonatomic, strong) Movie *theMovie;

-(void)setLabelsForMovie;
-(void)updateMovie:(id)sender;


@end

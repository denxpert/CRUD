//
//  CRUDNewViewController.h
//  Movies
//
//  Created by Don Miller on 4/4/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseController.h"

@interface CRUDNewViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *txtTitle;
@property (nonatomic, strong) IBOutlet UITextField *txtYear;
@property (nonatomic, strong) IBOutlet UITextField *txtRating;
@property (nonatomic, strong) IBOutlet UITextField *txtLength;

-(void)saveMovie:(id)sender;

@end

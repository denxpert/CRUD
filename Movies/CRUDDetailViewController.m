//
//  CRUDDetailViewController.m
//  Movies
//
//  Created by Don Miller on 4/2/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import "CRUDDetailViewController.h"

@interface CRUDDetailViewController ()
- (void)configureView;
@end

@implementation CRUDDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(updateMovie:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [self setLabelsForMovie];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Movie Details", @"Movie Details");
    }
    return self;
}

#pragma mark User Methods

-(void) setLabelsForMovie
{
    //  Set the labels to the values passed of the passed customer object
    
    _txtMovieID.text=[NSString stringWithFormat:@"%i", self.theMovie.intMovieId];
    _txtTitle.text=self.theMovie.strTitle;
    _txtYear.text=[NSString stringWithFormat:@"%i", self.theMovie.intYear];
    _txtRating.text=self.theMovie.strRating;
    _txtLength.text=self.theMovie.strLength;
}

-(void) updateMovie:(id)sender
{
    //  Create an instance of DBServer class.
    DatabaseController *dbController = [[DatabaseController alloc] init];
    
    [dbController updateMovie:[_txtMovieID.text intValue]
                        Title:_txtTitle.text
                         Year:[_txtYear.text intValue]
                       Rating:_txtRating.text
                       Length:_txtLength.text];

    //  Release the dbAccess object to free its memory
    dbController=nil;
}
							
@end

//
//  CRUDNewViewController.m
//  Movies
//
//  Created by Don Miller on 4/4/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import "CRUDNewViewController.h"

@interface CRUDNewViewController ()

@end

@implementation CRUDNewViewController
@synthesize txtTitle, txtYear, txtRating, txtLength;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveMovie:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

-(void)saveMovie:(id)sender
{
    //  Create an instance of DBServer class.
    DatabaseController *myDB = [[DatabaseController alloc] init];
    
    [myDB insertMovie:txtTitle.text
                 Year:[txtYear.text integerValue]
               Rating:txtRating.text
               Length:txtLength.text];
    
    //  Release the dbAccess object to free its memory
    myDB=nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

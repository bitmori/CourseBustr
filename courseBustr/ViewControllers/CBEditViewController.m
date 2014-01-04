//
//  CBEditViewController.m
//  courseBustr
//
//  Created by Ke Yang on 12/29/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBEditViewController.h"
#import "CBCourseModel.h"
#import "CBDataSingleton.h"

@interface CBEditViewController ()

@end

@implementation CBEditViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    CBCourseModel* course = sharedData.courseList[self.row];
    [self.fieldName setText:course.name];
    [self.fieldCID setText:course.CID];
    [self.fieldCRN setText:[NSString stringWithFormat:@"%d", course.CRN]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonDone:(id)sender
{
    CBCourseModel* course = [[CBCourseModel alloc] initWithCRN:[self.fieldCRN.text integerValue] CID:self.fieldCID.text Name:self.fieldName.text];
    [self.delegate editViewControllerDidDone:self withCourseModel:course];
}

- (IBAction)onButtonCancel:(id)sender
{
    [self.delegate editViewControllerDidCancel:self];
}
@end

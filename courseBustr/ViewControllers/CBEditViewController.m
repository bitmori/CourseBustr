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

- (IBAction)onColorSelButton:(id)sender;

@property (assign, nonatomic) NSInteger colorID;

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
    [self.fieldCID setDelegate:self];
    [self.fieldCRN setDelegate:self];
    [self.fieldName setDelegate:self];
    [self.fieldName setText:course.name];
    [self.fieldCID setText:course.CID];
    [self.fieldCRN setText:[NSString stringWithFormat:@"%d", course.CRN]];
    self.colorID = course.color;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (int i=200; i<208; i++) {
        [(UIButton*)[self.view viewWithTag:i] setEnabled:(i!=(self.colorID+200))];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonDone:(id)sender
{
    CBCourseModel* course = [[CBCourseModel alloc] initWithCRN:[self.fieldCRN.text integerValue] CID:self.fieldCID.text Name:self.fieldName.text ColorID:self.colorID];
    [self.delegate editViewControllerDidDone:self withCourseModel:course];
}

- (IBAction)onButtonCancel:(id)sender
{
    [self.delegate editViewControllerDidCancel:self];
}

- (IBAction)onColorSelButton:(id)sender {
    NSInteger t = [(UIButton*)sender tag];
    for (int i=200; i<208; i++) {
        [(UIButton*)[self.view viewWithTag:i] setEnabled:(i!=t)];
    }
    self.colorID = t-200;
//    UIColor *color = [(UIButton*)sender titleColorForState:UIControlStateNormal];
//    const CGFloat *components = CGColorGetComponents(color.CGColor);
//    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
//    NSLog(@"%d, %@", t, colorAsString);
}

@end

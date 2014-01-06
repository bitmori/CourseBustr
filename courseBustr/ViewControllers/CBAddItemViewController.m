//
//  CBAddItemViewController.m
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBAddItemViewController.h"
#import "CBCourseModel.h"

@interface CBAddItemViewController ()

@property (assign, nonatomic) NSInteger colorID;

@end

@implementation CBAddItemViewController

@synthesize delegate;

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
    self.colorID = 0;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (int i=200; i<208; i++) {
        [(UIButton*)[self.view viewWithTag:i] setEnabled:(i!=(self.colorID+200))];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonDone:(id)sender
{
    CBCourseModel* course = [[CBCourseModel alloc] initWithCRN:[self.fieldCRN.text integerValue] CID:self.fieldCID.text Name:self.fieldName.text ColorID:self.colorID];
    [self.delegate addItemViewControllerDidDone:self withCourseModel:course];
}

- (IBAction)onButtonCancel:(id)sender {
    [self.delegate addItemViewControllerDidCancel:self];
}

- (IBAction)onColorSelButton:(id)sender {
    NSInteger t = [(UIButton*)sender tag];
    for (int i=200; i<208; i++) {
        [(UIButton*)[self.view viewWithTag:i] setEnabled:(i!=t)];
    }
    self.colorID = t-200;
//    switch (t) {
//        case 201:
//            NSLog(@"%@", @"orange");
//            break;
//        default:
//            NSLog(@"%@", colorAsString);
//            break;
//    }
}
@end

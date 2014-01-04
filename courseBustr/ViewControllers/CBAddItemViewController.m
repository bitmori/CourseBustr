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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonDone:(id)sender
{
    CBCourseModel* course = [[CBCourseModel alloc] initWithCRN:[self.fieldCRN.text integerValue] CID:self.fieldCID.text Name:self.fieldName.text];
    [self.delegate addItemViewControllerDidDone:self withCourseModel:course];
}

- (IBAction)onButtonCancel:(id)sender {
    [self.delegate addItemViewControllerDidCancel:self];
}

- (IBAction)onColorSelButton:(id)sender {
    NSInteger t = [(UIButton*)sender tag];
    UIColor *color = [(UIButton*)sender titleColorForState:UIControlStateNormal];
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    switch (t) {
        case 201:
            NSLog(@"%@", @"orange");
            break;
        default:
            NSLog(@"%@", colorAsString);
            break;
    }
}
@end

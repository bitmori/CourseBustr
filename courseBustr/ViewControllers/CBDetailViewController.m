//
//  CBDetailViewController.m
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBDetailViewController.h"

@interface CBDetailViewController ()

@end

@implementation CBDetailViewController

@synthesize courseName;

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
    [self.labelName setText:self.courseName];
    [self.labelCID setText:self.courseCID];
    [self.labelCRN setText:[NSString stringWithFormat:@"%d", self.courseCRN]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonEdit:(id)sender
{
    NSLog(@"%@", self.courseCID);
}

@end

//
//  CBProfileViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/4/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBProfileViewController.h"
#import "SWRevealViewController.h"

@interface CBProfileViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealMenuButton;

@end

@implementation CBProfileViewController

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
    [self.revealMenuButton setTarget: self.revealViewController];
    [self.revealMenuButton setAction: @selector( revealToggle: )];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

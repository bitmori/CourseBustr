//
//  CBLoginViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/8/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBLoginViewController.h"
#import "CBDataSingleton.h"

@interface CBLoginViewController ()

@end

@implementation CBLoginViewController

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        CBDataSingleton* sharedData = [CBDataSingleton sharedData];
        if (sharedData.userData==nil) {
            FBRequest* req = [FBRequest requestForMe];
            [req startWithCompletionHandler:^(FBRequestConnection* connection, id result, NSError* error){
                if (!error) {
                    sharedData.userData = [[NSDictionary alloc] initWithDictionary:(NSDictionary*)result];
                }
            }];
        }
        [self performSegueWithIdentifier:@"afterLogin" sender:self];
    } else {
        if ([self.fbLoginButton isHidden]) {
            [self.fbLoginActivityIndicator stopAnimating];
            [self.fbLoginButton setHidden:NO];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commsDidLogin:(BOOL)loggedIn
{
    [self.fbLoginButton setEnabled:YES];
    [self.fbLoginActivityIndicator stopAnimating];
    if (loggedIn) {
        CBDataSingleton* sharedData = [CBDataSingleton sharedData];
        if (sharedData.userData==nil) {
            FBRequest* req = [FBRequest requestForMe];
            [req startWithCompletionHandler:^(FBRequestConnection* connection, id result, NSError* error){
                if (!error) {
                    sharedData.userData = [[NSDictionary alloc] initWithDictionary:(NSDictionary*)result];
                }
            }];
        }
        [self performSegueWithIdentifier:@"afterLogin" sender:self];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Login Failed"
                                    message:@"Facebook Login failed. Please try again"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    }
}

- (IBAction)onFBLoginButton:(id)sender {
    [self.fbLoginButton setEnabled:NO];
    [self.fbLoginActivityIndicator startAnimating];
    [CBCommonUtils login:self];
}

@end

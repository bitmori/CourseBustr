//
//  CBSettingViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/4/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBSettingViewController.h"
#import "SWRevealViewController.h"

@interface CBSettingViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealMenuButton;
- (IBAction)onTestButton:(id)sender;

@end

@implementation CBSettingViewController

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

- (IBAction)onTestButton:(id)sender {
    /*PFObject* testObject = [PFObject objectWithClassName:@"CBTestObject2"];
    [testObject setObject:[PFUser currentUser] forKey:@"user"];
    [testObject setObject:@"Teemo" forKey:@"Name"];
    [testObject setObject:@"Male" forKey:@"Gender"];
    [testObject setObject:@"Mushroom" forKey:@"Fave"];
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError* error) {
        if (succeeded) {
            [[[UIAlertView alloc] initWithTitle:@"Upload succeeded!"
                                        message:@"Test Object has been uploaded!"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        } else {
            NSString* errString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error!! %@", errString);
        }
    }];*/
    /*PFQuery* q = [PFQuery queryWithClassName:@"CBTestObject"];
    [q whereKey:@"Name" equalTo:@"Teemo"];
    [q findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error) {
        if (!error) {
            [[[UIAlertView alloc] initWithTitle:@"Got the right object"
                                        message:objects[0][@"Fave"]
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        } else {
            NSString* errString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error!! %@", errString);
        }
    }];*/
}
@end

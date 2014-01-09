//
//  CBProfileViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/4/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBProfileViewController.h"
#import "SWRevealViewController.h"
#import "CBDataSingleton.h"

@interface CBProfileViewController ()
{
    UIActionSheet* m_sheet;
    UIActionSheet* m_logout_sheet;
    NSMutableData* m_image;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealMenuButton;
- (IBAction)onLogoutButton:(id)sender;

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
    
    m_logout_sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Logout" otherButtonTitles:nil, nil];
    m_logout_sheet.tag = 10000;
    
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    if (sharedData.userData==nil) {
        FBRequest* req = [FBRequest requestForMe];
        [req startWithCompletionHandler:^(FBRequestConnection* connection, id result, NSError* error){
            if (!error) {
                sharedData.userData = [[NSDictionary alloc] initWithDictionary:(NSDictionary*)result];
            }
        }];
    }
    m_logout_sheet.title = [NSString stringWithFormat:@"Currently logged in as %@", sharedData.userData[@"name"]];
    
    NSURL* pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", sharedData.userData[@"id"]]];
    m_image = [[NSMutableData alloc] init];
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:2.0f];
    
    NSURLConnection* urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    if (!urlConnection) {
        NSLog(@"__failed to create urlConnection.");
    }

    m_sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Update Profile", @"Change Password", nil];
    m_sheet.tag = 9999;
    
    self.profileImageView.imgOffset = 2.5;
    [self.labelUsername setText:sharedData.userData[@"name"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10000) {
        if (buttonIndex==0) {
            [PFUser logOut];
            [self performSegueWithIdentifier:@"afterLogout" sender:self];
        }
    } else if (actionSheet.tag == 9999) {
        switch (buttonIndex) {
            case 0:
                NSLog(@"__update__");
                break;
            case 1:
                NSLog(@"__password__");
                break;
            case 2:
                break;
            default:
                break;
        }
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [m_image appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    self.profileImageView.image = [UIImage imageWithData:m_image];
}

- (IBAction)onLogoutButton:(id)sender {
    [m_logout_sheet showInView:self.view];
}

@end

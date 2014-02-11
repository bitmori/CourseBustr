//
//  CBViewController.m
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBViewController.h"
#import "CBCourseModel.h"
#import "CBDataSingleton.h"
#import "CBDetailViewController.h"
#import "SWRevealViewController.h"

@interface CBViewController ()
{
    UIActionSheet* m_sheet;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealMenuButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;
- (IBAction)actionSheetButton:(id)sender;

@end

@implementation CBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    m_sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Course", @"Edit Courses", nil];
    
    [self.revealMenuButton setTarget: self.revealViewController];
    [self.revealMenuButton setAction: @selector(revealToggle:)];
    //[self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    PFQuery* q = [PFQuery queryWithClassName:@"CBUserCourse"];
    [q whereKey:@"user" equalTo:[PFUser currentUser]];
    [q findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error) {
        if (!error) {
            CBDataSingleton* sharedData = [CBDataSingleton sharedData];
            if (sharedData.courseList) {
                [sharedData.courseList removeAllObjects];
            }
            [sharedData.courseList addObjectsFromArray:objects];
            [self.tableCourse reloadData];
        } else {
            NSString* errString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error!! %@", errString);
        }
    }];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    return [sharedData.courseList count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1 - cell identifier, to reuse it.
    static NSString* courseCell = @"courseCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:courseCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCell];
    }

    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    PFObject* course = sharedData.courseList[indexPath.row];
    UILabel* labelCID = (UILabel *)[cell viewWithTag:101];
    [labelCID setText:[NSString stringWithFormat:@"%@ %@", course[@"course_dept"], course[@"course_number"]]];
    UILabel* labelScore = (UILabel *)[cell viewWithTag:102];
    [labelScore setText:@"77% Now"];
    UILabel* labelName = (UILabel *)[cell viewWithTag:103];
    [labelName setText:course[@"course_name"]];
    UILabel* labelColor = (UILabel *)[cell viewWithTag:104];
    [labelColor setBackgroundColor:sharedData.colorList[[(NSNumber*)course[@"Color"] integerValue]]];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *) indexPath {
    return YES;
}

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)
//sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    NSUInteger fromRow = [sourceIndexPath row];
//    NSUInteger toRow = [destinationIndexPath row];
//    
//    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
//    id object = [sharedData.courseList objectAtIndex:fromRow];
//    [sharedData.courseList removeObjectAtIndex:fromRow];
//    [sharedData.courseList insertObject:object atIndex:toRow];
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CBDataSingleton* sharedData = [CBDataSingleton sharedData];
        PFObject* targetObj = sharedData.courseList[row];
        [targetObj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [sharedData.courseList removeObject:targetObj];
                [tableView deleteRowsAtIndexPaths:@[indexPath]
                                 withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                NSString* errString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"Error!! %@", errString);
            }
        }];
    }
}

#pragma mark - CBAddItemViewControllerDelegate

- (void)searchViewControllerDidCancel:(CBSearchViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)editCourseViewControllerDidDone:(CBEditCourseViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)editCourseViewControllerDidCancel:(CBEditCourseViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"searchCourse"]) {
        UINavigationController* navController = segue.destinationViewController;
        CBSearchViewController* searchController = [[navController viewControllers] objectAtIndex:0];
        searchController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"segueToDetailView"]) {
        NSIndexPath *indexPath = [self.tableCourse indexPathForSelectedRow];
        CBDetailViewController *detail = segue.destinationViewController;
        CBDataSingleton* sharedData = [CBDataSingleton sharedData];
        detail.courseObj = sharedData.courseList[indexPath.row];
        detail.delegate2 = self;
    }
}

- (void)updateCellAtRow:(NSInteger)row
{
    [self.tableCourse reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
}

- (IBAction)actionSheetButton:(id)sender
{
    if (self.tableCourse.editing) {
        [self.tableCourse setEditing:NO animated:YES];
        [self.actionButton setTitle:@"Action"];
    } else {
        [m_sheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self performSegueWithIdentifier:@"searchCourse" sender:self];
            break;
        case 1:
            if (!self.tableCourse.editing) {
                [self.tableCourse setEditing:YES animated:YES];
                [self.actionButton setTitle:@"Done"];
            }
            break;
        default:
            break;
    }
}
@end

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
    
    m_sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add Course", @"Edit Courses", @"Sorting", nil];
    
    [self.revealMenuButton setTarget: self.revealViewController];
    [self.revealMenuButton setAction: @selector(revealToggle:)];
    //[self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    NSArray* _dataArray = @[@[@31152, @"CS 125", @"Intro to Computer Science"],
                   //@[@39311, @"CS 173", @"Discrete Structures"],
                   //@[@31208, @"CS 225", @"Data Structures"],
                   //@[@58541, @"CS 233", @"Computer Architecture"],
                   //@[@53753, @"CS 241", @"System Programming"],
                   @[@50142, @"CS 373", @"Theory of Computation"]
                   ];
    //not add!! should refresh!
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    [sharedData.courseList removeAllObjects];
    for (NSArray* item in _dataArray) {
        CBCourseModel* course = [[CBCourseModel alloc] initWithCRN:[item[0] integerValue] CID:item[1] Name:item[2] ColorID:0];
        [sharedData.courseList addObject:course];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    CBCourseModel* course = sharedData.courseList[indexPath.row];
    UILabel* labelCID = (UILabel *)[cell viewWithTag:101];
    [labelCID setText:course.CID];
    UILabel* labelCRN = (UILabel *)[cell viewWithTag:102];
    [labelCRN setText:[NSString stringWithFormat:@"%d", course.CRN]];
    UILabel* labelName = (UILabel *)[cell viewWithTag:103];
    [labelName setText:course.name];
    UILabel* labelColor = (UILabel *)[cell viewWithTag:104];
    [labelColor setBackgroundColor:sharedData.colorList[course.color]];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *) indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)
sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    id object = [sharedData.courseList objectAtIndex:fromRow];
    [sharedData.courseList removeObjectAtIndex:fromRow];
    [sharedData.courseList insertObject:object atIndex:toRow];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CBDataSingleton* sharedData = [CBDataSingleton sharedData];
        [sharedData.courseList removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - CBAddItemViewControllerDelegate

- (void)addItemViewControllerDidCancel:(CBAddItemViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewControllerDidDone:(CBAddItemViewController *)controller withCourseModel:(CBCourseModel *)course
{
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    [sharedData.courseList addObject:course];
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[sharedData.courseList count]-1 inSection:0];
    [self.tableCourse insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addCourse"]) {
        UINavigationController* navController = segue.destinationViewController;
        CBAddItemViewController* addController = [[navController viewControllers] objectAtIndex:0];
        addController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"segueToDetailView"]) {
        NSIndexPath *indexPath = [self.tableCourse indexPathForSelectedRow];
        CBDetailViewController *detail = segue.destinationViewController;
        detail.row = indexPath.row;
        detail.delegate = self;
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
            [self performSegueWithIdentifier:@"addCourse" sender:self];
            break;
        case 1:
            if (!self.tableCourse.editing) {
                [self.tableCourse setEditing:YES animated:YES];
                [self.actionButton setTitle:@"Done"];
            }
            break;
        case 2:
            break;
        default:
            break;
    }
}
@end

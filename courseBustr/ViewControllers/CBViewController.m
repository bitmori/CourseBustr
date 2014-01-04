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

@interface CBViewController ()

@end

@implementation CBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* _dataArray = @[@[@31152, @"CS 125", @"Intro to Computer Science"],
                   //@[@39311, @"CS 173", @"Discrete Structures"],
                   //@[@31208, @"CS 225", @"Data Structures"],
                   //@[@58541, @"CS 233", @"Computer Architecture"],
                   //@[@53753, @"CS 241", @"System Programming"],
                   @[@50142, @"CS 373", @"Theory of Computation"]
                   ];
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    for (NSArray* item in _dataArray) {
        CBCourseModel* course = [[CBCourseModel alloc] initWithCRN:[item[0] integerValue] CID:item[1] Name:item[2]];
        [sharedData.courseList addObject:course];
    }
    //self.navigationItem.rightBarButtonItems
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
    [labelColor setBackgroundColor:[UIColor redColor]];
    
    return cell;
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
    } else if ([segue.identifier isEqualToString:@"segueToDetailView"]) {
        NSIndexPath *indexPath = [self.tableCourse indexPathForSelectedRow];
        UINavigationController* navController = segue.destinationViewController;
        CBDetailViewController *detail = [[navController viewControllers] objectAtIndex:0];
        //CBDataSingleton* sharedData = [CBDataSingleton sharedData];
        //CBCourseModel* course = sharedData.courseList[indexPath.row];
        detail.row = indexPath.row;
        detail.delegate = self;
    }
}

- (void)updateCellAtRow:(NSInteger)row
{
    [self.tableCourse reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
}

@end

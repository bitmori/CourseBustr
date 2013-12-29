//
//  CBViewController.m
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBViewController.h"
#import "CBCourseModel.h"
#import "CBDetailViewController.h"

@interface CBViewController ()
{
    NSArray* _dataArray;
    NSMutableArray* _courseList;
}

- (void)generateData;
@end

@implementation CBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self generateData];
    _dataArray = @[@[@31152, @"CS 125", @"Intro to Computer Science"],
                   @[@39311, @"CS 173", @"Discrete Structures"],
                   @[@31208, @"CS 225", @"Data Structures"],
                   @[@58541, @"CS 233", @"Computer Architecture"],
                   @[@53753, @"CS 241", @"System Programming"],
                   @[@50142, @"CS 373", @"Theory of Computation"]
                   ];
    _courseList = [[NSMutableArray alloc] init];
    for (NSArray* item in _dataArray) {
        CBCourseModel* course = [[CBCourseModel alloc] initWithCRN:[item[0] integerValue] CID:item[1] Name:item[2]];
        [_courseList addObject:course];
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
    return [_courseList count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1 - cell identifier, to reuse it.
    static NSString* courseCell = @"courseCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:courseCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCell];
    }

    CBCourseModel* course = _courseList[indexPath.row];
    UILabel* labelCID = (UILabel *)[cell viewWithTag:101];
    [labelCID setText:course.CID];
    UILabel* labelCRN = (UILabel *)[cell viewWithTag:102];
    [labelCRN setText:[NSString stringWithFormat:@"%d", course.CRN]];
    UILabel* labelName = (UILabel *)[cell viewWithTag:103];
    [labelName setText:course.name];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBCourseModel* course = _courseList[indexPath.row];
//    UIAlertView* message = [[UIAlertView alloc] initWithTitle:@"TableView"
//                                                      message:course.name
//                                                     delegate:nil
//                                            cancelButtonTitle:@"OK"
//                                            otherButtonTitles:nil
//                            ];
//    [message show];
    CBDetailViewController* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:detail action:@selector(onButtonEdit:)];
    detail.navigationItem.rightBarButtonItem = editButton;
    detail.title = @"Detail";
    detail.courseName = course.name;
    detail.courseCID = course.CID;
    detail.courseCRN = course.CRN;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)generateData
{
    _dataArray = @[@[@31152, @"CS 125", @"Intro to Computer Science"],
                   @[@39311, @"CS 173", @"Discrete Structures"],
                   @[@31208, @"CS 225", @"Data Structures"],
                   @[@58541, @"CS 233", @"Computer Architecture"],
                   @[@53753, @"CS 241", @"System Programming"],
                   @[@50142, @"CS 373", @"Theory of Computation"]
                   ];
    _courseList = [[NSMutableArray alloc] init];
    for (NSArray* item in _dataArray) {
        CBCourseModel* course = [[CBCourseModel alloc] initWithCRN:[item[0] integerValue] CID:item[1] Name:item[2]];
        [_courseList addObject:course];
    }
}

#pragma mark - CBAddItemViewControllerDelegate

- (void)addItemViewControllerDidCancel:(CBAddItemViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewControllerDidDone:(CBAddItemViewController *)controller withCourseModel:(CBCourseModel *)course
{
    [_courseList addObject:course];
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[_courseList count]-1 inSection:0];
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
}

@end

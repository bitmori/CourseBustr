//
//  CBDetailViewController.m
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBDetailViewController.h"
#import "CBDataSingleton.h"

@interface CBDetailViewController ()
{
    UIActionSheet* m_sheet;
    UIActionSheet* m_sheet_ex;
}
- (IBAction)onActionButton:(id)sender;

@end

@implementation CBDetailViewController

@synthesize courseObj;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent=NO;

    self.title = [[NSString alloc] initWithFormat:@"%@ %@", self.courseObj[@"course_dept"], self.courseObj[@"course_number"]];
    
    m_sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Edit Course Info", @"Add Course Grades", nil];
    m_sheet.tag = 501;
    
    m_sheet_ex = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Edit Course Info", @"Add Course Grade", @"Edit Grade List", nil];
    m_sheet_ex.tag = 502;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    PFQuery* q = [PFQuery queryWithClassName:@"CBCourseGrade"];
    [q whereKey:@"course_user" equalTo:self.courseObj];
    [q findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error) {
        if (!error) {
            CBDataSingleton* sharedData = [CBDataSingleton sharedData];
            if (sharedData.gradeList) {
                [sharedData.gradeList removeAllObjects];
            }
            [sharedData.gradeList addObjectsFromArray:objects];
            //[self.tableCourse reloadData];
        } else {
            NSString* errString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error!! %@", errString);
        }
    }];

}

- (void)editCourseViewControllerDidCancel:(CBEditCourseViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)editCourseViewControllerDidDone:(CBEditCourseViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)editGradeViewControllerDidCancel:(CBEditGradeViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)editGradeViewControllerDidDone:(CBEditGradeViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editCourse"]) {
        UINavigationController* navController = segue.destinationViewController;
        CBEditCourseViewController* editController = [[navController viewControllers] objectAtIndex:0];
        editController.courseObj = self.courseObj;
        editController.editMode = YES;
        editController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"addGrade"]) {
        UINavigationController* navController = segue.destinationViewController;
        CBEditGradeViewController* editGradeController = [[navController viewControllers] objectAtIndex:0];
        editGradeController.courseObj = self.courseObj;
        editGradeController.gradeObj = nil;
        editGradeController.delegate = self;
    }
}

- (IBAction)onActionButton:(id)sender
{
    if (self.selectedIndex==2) {
        [m_sheet_ex showInView:self.view];
    }else{
        [m_sheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self performSegueWithIdentifier:@"editCourse" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"addGrade" sender:self];
            break;
        case 2:
            if (self.selectedIndex==2) {
                NSLog(@"edit grade list");
            }
            break;
        default:
            break;
    }
}

@end

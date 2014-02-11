//
//  CBListViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/3/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBListViewController.h"
#import "CBDataSingleton.h"
#import "CBEditGradeViewController.h"
#import "CBDetailViewController.h"

@interface CBListViewController ()

@end

@implementation CBListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CBDetailViewController* parent = (CBDetailViewController*)(self.parentViewController);
    self.courseObj = parent.courseObj;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editGrade"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UINavigationController* navController = segue.destinationViewController;
        CBEditGradeViewController* editGradeController = [[navController viewControllers] objectAtIndex:0];
        editGradeController.courseObj = self.courseObj;
        CBDataSingleton* sharedData = [CBDataSingleton sharedData];
        editGradeController.gradeObj = sharedData.gradeList[indexPath.row];
        editGradeController.delegate = (id<CBEditGradeViewControllerDelegate>)self.parentViewController;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    return [sharedData.gradeList count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1 - cell identifier, to reuse it.
    static NSString* gradeCell = @"gradeCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:gradeCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gradeCell];
    }

    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    PFObject* grade = sharedData.gradeList[indexPath.row];
    
    NSString* percent = (NSString*)grade[@"grade_percent"];
    NSInteger percentInt = [[percent substringToIndex:[percent length]-2] integerValue];
    NSInteger score = [grade[@"grade_score"] integerValue];
    NSInteger full = [grade[@"grade_full"] integerValue];
    float realPercent = 100.0 * score / full;
    float realOverallPercent = realPercent * percentInt;
    
    UILabel* labelDesc = (UILabel *)[cell viewWithTag:301];
    [labelDesc setText:grade[@"grade_desc"]];
    UILabel* labelScore = (UILabel *)[cell viewWithTag:302];
    [labelScore setText:[NSString stringWithFormat:@"%d / %d - %.2f %% / %@", score, full, realPercent, percent]];
    UILabel* labelPercent = (UILabel *)[cell viewWithTag:303];
    [labelPercent setText:[NSString stringWithFormat:@"%f %%", realOverallPercent]];
    UIImageView* imgView = (UIImageView*)[cell viewWithTag:304];
    [imgView setImage:[UIImage imageNamed:@"book.png"]];
//    UILabel* labelColor = (UILabel *)[cell viewWithTag:304];
//    [labelColor setBackgroundColor:sharedData.colorList[[(NSNumber*)course[@"Color"] integerValue]]];
    
    return cell;
}

/*- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *) indexPath {
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
}*/

- (void)updateCellAtRow:(NSInteger)row
{
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
}

@end

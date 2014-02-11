//
//  CBInfoViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/3/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBInfoViewController.h"
#import "CBDetailViewController.h"
@interface CBInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *cellDept;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellNumber;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellName;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellGoal;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellCurrent;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellProgress;

@end

@implementation CBInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CBDetailViewController* parent = (CBDetailViewController*)(self.parentViewController);
    self.courseObj = parent.courseObj;
    [self.cellDept.textLabel setText:self.courseObj[@"course_dept"]];
    [self.cellNumber.textLabel setText:[self.courseObj[@"course_number"] stringValue]];
    [self.cellName.textLabel setText:self.courseObj[@"course_name"]];
    [self.cellGoal.textLabel setText:[NSString stringWithFormat:@"%d %%", [self.courseObj[@"goal"] integerValue]]];
    [self.cellCurrent.textLabel setText:[self.courseObj[@"curr"] stringValue]];
    [self.cellProgress.textLabel setText:[self.courseObj[@"prog"] stringValue]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

@end

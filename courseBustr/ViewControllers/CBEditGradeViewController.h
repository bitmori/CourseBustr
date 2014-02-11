//
//  CBEditGradeViewController.h
//  courseBustr
//
//  Created by Ke Yang on 1/10/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBGradeTypeViewController.h"

@class CBEditGradeViewController;

@protocol CBEditGradeViewControllerDelegate <NSObject>

- (void)editGradeViewControllerDidDone:(CBEditGradeViewController *)controller;
- (void)editGradeViewControllerDidCancel:(CBEditGradeViewController *)controller;

@end

@interface CBEditGradeViewController : UITableViewController<CBGradeTypeViewControllerDelegate>

@property (weak, nonatomic) id<CBEditGradeViewControllerDelegate> delegate;

@property (strong, nonatomic) PFObject* courseObj;
@property (strong, nonatomic) PFObject* gradeObj;
@property (assign, nonatomic) NSInteger gradeType;

@end

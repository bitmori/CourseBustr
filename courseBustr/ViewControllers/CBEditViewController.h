//
//  CBEditViewController.h
//  courseBustr
//
//  Created by Ke Yang on 12/29/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBEditViewController;
@class CBCourseModel;

@protocol CBEditViewControllerDelegate <NSObject>

- (void)editViewControllerDidDone:(CBEditViewController *)controller withCourseModel:(CBCourseModel*)course;
- (void)editViewControllerDidCancel:(CBEditViewController *)controller;

@end

@interface CBEditViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<CBEditViewControllerDelegate> delegate;

- (IBAction)onButtonDone:(id)sender;
- (IBAction)onButtonCancel:(id)sender;

@property (assign, nonatomic) NSInteger row;

@property (weak, nonatomic) IBOutlet UITextField *fieldCID;
@property (weak, nonatomic) IBOutlet UITextField *fieldCRN;
@property (weak, nonatomic) IBOutlet UITextField *fieldName;

@end

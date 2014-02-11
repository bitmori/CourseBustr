//
//  CBAddItemViewController.h
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBEditCourseViewController;
@class CBCourseModel;

@protocol CBEditCourseViewControllerDelegate <NSObject>

- (void)editCourseViewControllerDidDone:(CBEditCourseViewController *)controller;
- (void)editCourseViewControllerDidCancel:(CBEditCourseViewController *)controller;

@end

@interface CBEditCourseViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<CBEditCourseViewControllerDelegate> delegate;

@property (nonatomic, strong) PFObject* courseInfo;
@property (nonatomic, strong) PFObject* courseObj;
@property (nonatomic, assign) BOOL editMode;

- (IBAction)onButtonDone:(id)sender;
- (IBAction)onButtonCancel:(id)sender;
- (IBAction)onColorSelButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableViewCell *cellDept;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellNum;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellName;

@end

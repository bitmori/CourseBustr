//
//  CBAddItemViewController.h
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBAddItemViewController;
@class CBCourseModel;

@protocol CBAddItemViewControllerDelegate <NSObject>

- (void)addItemViewControllerDidDone:(CBAddItemViewController *)controller withCourseModel:(CBCourseModel*)course;
- (void)addItemViewControllerDidCancel:(CBAddItemViewController *)controller;

@end

@interface CBAddItemViewController : UITableViewController

@property (nonatomic, weak) id<CBAddItemViewControllerDelegate> delegate;

- (IBAction)onButtonDone:(id)sender;
- (IBAction)onButtonCancel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *fieldCID;
@property (weak, nonatomic) IBOutlet UITextField *fieldCRN;
@property (weak, nonatomic) IBOutlet UITextField *fieldName;

@end

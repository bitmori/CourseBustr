//
//  CBGradeTypeViewController.h
//  courseBustr
//
//  Created by Ke Yang on 1/10/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBGradeTypeViewController;

@protocol CBGradeTypeViewControllerDelegate <NSObject>

- (void)gradeTypeViewControllerDidDone:(CBGradeTypeViewController *)controller;
- (void)gradeTypeViewControllerDidCancel:(CBGradeTypeViewController *)controller;
- (void)selectGradeType:(NSInteger)index;

@end

@interface CBGradeTypeViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id<CBGradeTypeViewControllerDelegate> delegate;
@property (assign, nonatomic) NSInteger gradeType;

@end

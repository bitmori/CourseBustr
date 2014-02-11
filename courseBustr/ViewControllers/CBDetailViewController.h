//
//  CBDetailViewController.h
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBEditGradeViewController.h"
#import "CBEditCourseViewController.h"

@class CBViewController;
@protocol CBDetailViewControllerDelegate <NSObject>

- (void)updateCellAtRow:(NSInteger)row;

@end


@interface CBDetailViewController : UITabBarController<CBEditCourseViewControllerDelegate, CBEditGradeViewControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) id<CBDetailViewControllerDelegate> delegate2;

@property (strong, nonatomic) PFObject* courseObj;

@end

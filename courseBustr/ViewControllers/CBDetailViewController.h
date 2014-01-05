//
//  CBDetailViewController.h
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBEditViewController.h"

@class CBViewController;
@protocol CBDetailViewControllerDelegate <NSObject>

- (void)updateCellAtRow:(NSInteger)row;

@end

@interface CBDetailViewController : UIViewController<CBEditViewControllerDelegate, UIPageViewControllerDataSource>

@property (weak, nonatomic) id<CBDetailViewControllerDelegate> delegate;

@property (assign, nonatomic) NSInteger row;

@property (strong, nonatomic) UIPageViewController* pageViewController;

@property (strong, nonatomic) NSArray* pageContentID;

@end

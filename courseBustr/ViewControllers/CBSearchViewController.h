//
//  CBSearchViewController.h
//  courseBustr
//
//  Created by Ke Yang on 1/9/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Parse/Parse.h>
#import "CBEditCourseViewController.h"

@class CBSearchViewController;

@protocol CBSearchViewControllerDelegate <NSObject>

- (void)searchViewControllerDidCancel:(CBSearchViewController *)controller;

@end

@interface CBSearchViewController : PFQueryTableViewController<UISearchBarDelegate>

@property (nonatomic, weak) id<CBSearchViewControllerDelegate, CBEditCourseViewControllerDelegate> delegate;
@end

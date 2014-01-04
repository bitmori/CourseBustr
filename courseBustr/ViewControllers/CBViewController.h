//
//  CBViewController.h
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAddItemViewController.h"
#import "CBDetailViewController.h"

@interface CBViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CBAddItemViewControllerDelegate, CBDetailViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableCourse;

@end

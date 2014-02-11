//
//  CBListViewController.h
//  courseBustr
//
//  Created by Ke Yang on 1/3/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

@interface CBListViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) PFObject* courseObj;

@end

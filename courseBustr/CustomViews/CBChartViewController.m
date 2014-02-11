//
//  CBChartViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/3/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBChartViewController.h"
#import "CBDetailViewController.h"

@interface CBChartViewController ()

@end

@implementation CBChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CBDetailViewController* parent = (CBDetailViewController*)(self.parentViewController);
    self.courseObj = parent.courseObj;
}

@end

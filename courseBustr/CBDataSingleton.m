//
//  CBDataSingleton.m
//  courseBustr
//
//  Created by Ke Yang on 12/29/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBDataSingleton.h"

@implementation CBDataSingleton

@synthesize courseList;

#pragma mark Singleton Methods

+ (id)sharedData
{
    // this method is implemented by using GCD - grand central dispatch
    static CBDataSingleton* sharedAppData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAppData = [[self alloc] init];
    });
    return sharedAppData;
}

- (id)init
{
    if ((self=[super init])) {
        self.courseList = [[NSMutableArray alloc] init];
        self.colorList =
        @[
          [UIColor blackColor],
          [UIColor colorWithRed:1 green:102/255.0f blue:102/255.0f alpha:1],
          [UIColor colorWithRed:1 green:128/255.0f blue:0 alpha:1],
          [UIColor colorWithRed:1 green:204/255.0f blue:102/255.0f alpha:1],
          [UIColor colorWithRed:128/255.0f green:250/255.0f blue:0 alpha:1],
          [UIColor colorWithRed:102/255.0f green:204/255.0f blue:1 alpha:1],
          [UIColor colorWithRed:1.0f green:111/255.0f blue:207/255.0f alpha:1],
          [UIColor colorWithRed:179/255.0f green:179/255.0f blue:179/255.0f alpha:1]
          ];
        self.userData = nil;
    }
    return self;
}

//+ (id)sharedData {
//    static CBDataSingleton* sharedAppData = nil;
//    @synchronized(self) {
//        if (sharedAppData == nil)
//            sharedAppData = [[self alloc] init];
//    }
//    return sharedAppData;
//}

@end

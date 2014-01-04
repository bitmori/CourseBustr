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
        courseList = [[NSMutableArray alloc] init];
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

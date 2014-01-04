//
//  CBDataSingleton.h
//  courseBustr
//
//  Created by Ke Yang on 12/29/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBDataSingleton : NSObject
{
    NSMutableArray* courseList;
}

@property (nonatomic, strong) NSMutableArray* courseList;

+ (id)sharedData;

@end

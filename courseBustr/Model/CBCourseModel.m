//
//  CBCourseModel.m
//  CourseBustrX
//
//  Created by Ke Yang on 12/27/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBCourseModel.h"

@implementation CBCourseModel

- (id) initWithCRN:(NSInteger)CRN CID:(NSString*)CID Name:(NSString*)name
{
    if ((self=[super init])) {
        self.CRN = CRN;
        self.CID = CID;
        self.name = name;
        self.color = 0;
    }
    return self;
}

- (id) initWithCRN:(NSInteger)CRN CID:(NSString*)CID Name:(NSString*)name ColorID:(NSInteger)color
{
    if ((self=[super init])) {
        self.CRN = CRN;
        self.CID = CID;
        self.name = name;
        self.color = color;
    }
    return self;
}

@end

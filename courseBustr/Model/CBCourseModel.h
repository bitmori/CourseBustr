//
//  CBCourseModel.h
//  CourseBustrX
//
//  Created by Ke Yang on 12/27/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBCourseModel : NSObject

@property (nonatomic, assign) NSInteger CRN;
@property (nonatomic, copy) NSString* CID;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger color;

- (id) initWithCRN:(NSInteger)CRN CID:(NSString*)CID Name:(NSString*)name;
- (id) initWithCRN:(NSInteger)CRN CID:(NSString*)CID Name:(NSString*)name ColorID:(NSInteger)color;
//@property (nonatomic, copy) NSString* dept;
//@property (nonatomic, copy) NSString* desc;


@end

//
//  CBCourseModel.h
//  CourseBustrX
//
//  Created by Ke Yang on 12/27/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBCourseModel : NSObject

@property (nonatomic, strong) NSString* dept;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger color;
@property (nonatomic, assign) double goal;
@property (nonatomic, assign) double ;

@property (nonatomic, strong) NSMutableDictionary* grade;

@property (nonatomic, strong) PFObject* object;

- (id) initWithCRN:(NSInteger)CRN CID:(NSString*)CID Name:(NSString*)name;
- (id) initWithCRN:(NSInteger)CRN CID:(NSString*)CID Name:(NSString*)name ColorID:(NSInteger)color;
- (id) initWith
- (id) initWithParseObject:(PFObject*)obj;
- (PFObject*) convertToParseObject;


@end

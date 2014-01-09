//
//  CBCommonUtils.h
//  courseBustr
//
//  Created by Ke Yang on 1/8/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBCommsDelegate <NSObject>
@optional
- (void) commsDidLogin:(BOOL)loggedIn;

@end

@interface CBCommonUtils : NSObject

+ (void) login:(id<CBCommsDelegate>)delegate;

@end

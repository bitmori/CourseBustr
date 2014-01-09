//
//  CBCommonUtils.m
//  courseBustr
//
//  Created by Ke Yang on 1/8/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBCommonUtils.h"

@implementation CBCommonUtils

+ (void) login:(id<CBCommsDelegate>)delegate
{
    [PFFacebookUtils logInWithPermissions:nil block:^(PFUser* user, NSError* error)
    {
        if (!user) {
            if (!error) {
                NSLog(@"User Cancelled FB login");
            } else {
                NSLog(@"An error occurred: %@", error.localizedDescription);
            }
            
            if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
                [delegate commsDidLogin:NO];
            }
        } else {
            if (user.isNew) {
                NSLog(@"User signed up and logged in through Facebook!");
            } else {
                NSLog(@"User logged in through Facebook!");
            }
            
            if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
                [delegate commsDidLogin:YES];
            }
        }
    }];
}

@end

//
//  CBAppDelegate.m
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBAppDelegate.h"
#import "CBDataSingleton.h"
#import "CBCourseModel.h"

@implementation CBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"gMWKAUUkQCA4GQIf5osPYZxXmPYUGyzLjPHSEt42"
                  clientKey:@"UOdZ6Goh23LeBX4lFOu1GgBjojOxj6568jO4RAYL"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebook];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    // Override point for customization after application launch.

    NSArray* _dataArray = @[@[@31152, @"CS 125", @"Intro to Computer Science"],
                            //@[@39311, @"CS 173", @"Discrete Structures"],
                            //@[@31208, @"CS 225", @"Data Structures"],
                            //@[@58541, @"CS 233", @"Computer Architecture"],
                            //@[@53753, @"CS 241", @"System Programming"],
                            @[@50142, @"CS 373", @"Theory of Computation"]
                            ];
    //not add!! should refresh!
    CBDataSingleton* sharedData = [CBDataSingleton sharedData];
    [sharedData.courseList removeAllObjects];
    for (NSArray* item in _dataArray) {
        CBCourseModel* course = [[CBCourseModel alloc] initWithCRN:[item[0] integerValue] CID:item[1] Name:item[2] ColorID:0];
        [sharedData.courseList addObject:course];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

@end

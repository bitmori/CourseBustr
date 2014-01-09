//
//  CBProfileViewController.h
//  courseBustr
//
//  Created by Ke Yang on 1/4/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBUserRoundImage.h"

@interface CBProfileViewController : UIViewController<UIActionSheetDelegate, NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet CBUserRoundImage *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;

@end

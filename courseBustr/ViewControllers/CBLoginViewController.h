//
//  CBLoginViewController.h
//  courseBustr
//
//  Created by Ke Yang on 1/8/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBLoginViewController : UIViewController<CBCommsDelegate>

@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *fbLoginActivityIndicator;

- (IBAction)onFBLoginButton:(id)sender;

@end

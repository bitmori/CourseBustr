//
//  CBDetailViewController.h
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBDetailViewController : UIViewController

@property (copy, nonatomic) NSString* courseName;
@property (copy, nonatomic) NSString* courseCID;
@property (assign, nonatomic) NSInteger courseCRN;
@property (weak, nonatomic) IBOutlet UILabel *labelCID;
@property (weak, nonatomic) IBOutlet UILabel *labelCRN;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

- (IBAction)onButtonEdit:(id)sender;

@end

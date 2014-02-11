//
//  CBAddItemViewController.m
//  courseBustr
//
//  Created by Ke Yang on 12/28/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBEditCourseViewController.h"
#import "CBCourseModel.h"

@interface CBEditCourseViewController () <UITextFieldDelegate>

@property (assign, nonatomic) NSInteger colorID;
@property (weak, nonatomic) IBOutlet UITextField *textfieldTarget;

@end

@implementation CBEditCourseViewController

@synthesize delegate;
@synthesize courseInfo;
@synthesize courseObj;
@synthesize editMode;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!editMode) {
        [self.cellDept.textLabel setText:self.courseInfo[@"dept"]];
        [self.cellNum.textLabel setText:[(NSNumber*)self.courseInfo[@"number"] stringValue]];
        [self.cellName.textLabel setText:self.courseInfo[@"name"]];
        self.colorID = 0;
    } else {
        [self.cellDept.textLabel setText:self.courseObj[@"course_dept"]];
        [self.cellNum.textLabel setText:[(NSNumber*)self.courseObj[@"course_number"] stringValue]];
        [self.cellName.textLabel setText:self.courseObj[@"course_name"]];
        [self.textfieldTarget setText:[self.courseObj[@"goal"] stringValue]];
        self.colorID = [self.courseObj[@"Color"] integerValue];
    }

    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    keyboardToolbar.layer.borderColor = [[UIColor blackColor] CGColor];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(doneClicked:)];
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [keyboardToolbar setItems:@[flexibleSpace, doneButton]];
    self.textfieldTarget.inputAccessoryView = keyboardToolbar;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (int i=200; i<208; i++) {
        [(UIButton*)[self.view viewWithTag:i] setEnabled:(i!=(self.colorID+200))];
    }
}

- (IBAction)onButtonDone:(id)sender
{
    NSInteger goal = [[self.textfieldTarget.text substringToIndex:[self.textfieldTarget.text length]-2] integerValue];
    if (editMode && self.courseObj) {
        [self.courseObj setObject:[NSNumber numberWithInteger:self.colorID] forKey:@"Color"];
        [self.courseObj setObject:[NSNumber numberWithInteger:goal] forKey:@"goal"];
    } else {
        self.courseObj = [PFObject objectWithClassName:@"CBUserCourse"];
        [self.courseObj setObject:[PFUser currentUser] forKey:@"user"];
        [self.courseObj setObject:self.courseInfo[@"dept"] forKey:@"course_dept"];
        [self.courseObj setObject:self.courseInfo[@"number"] forKey:@"course_number"];
        [self.courseObj setObject:self.courseInfo[@"name"] forKey:@"course_name"];
        [self.courseObj setObject:[NSNumber numberWithInteger:self.colorID] forKey:@"Color"];
        [self.courseObj setObject:[NSNumber numberWithInteger:goal] forKey:@"goal"];
        [self.courseObj setObject:[NSNumber numberWithInteger:0] forKey:@"curr"];
        [self.courseObj setObject:[NSNumber numberWithFloat:0.0] forKey:@"prog"];
    }
    [self.courseObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError* error) {
        if (succeeded) {
            [self.delegate editCourseViewControllerDidDone:self];
        } else {
            NSString* errString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error!! %@", errString);
        }
    }];
}

- (IBAction)onButtonCancel:(id)sender {
    [self.delegate editCourseViewControllerDidCancel:self];
}

- (IBAction)onColorSelButton:(id)sender {
    NSInteger t = [(UIButton*)sender tag];
    for (int i=200; i<208; i++) {
        [(UIButton*)[self.view viewWithTag:i] setEnabled:(i!=t)];
    }
    self.colorID = t-200;
}

- (IBAction)doneClicked:(id)sender
{
    if (self.textfieldTarget.isEditing) {
        [self.textfieldTarget endEditing:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text length]==0) {
        [textField setText:@"100"];
    }
    if ([textField isEqual:self.textfieldTarget]) {
        NSString* newText = [NSString stringWithFormat:@"%@ %%", textField.text];
        [textField setText:newText];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text hasSuffix:@"%"]) {
        if ([textField.text length]>0) {
            NSString* newText = [NSString stringWithString:[textField.text substringToIndex:[textField.text length]-2]];
            [textField setText:newText];
        }
    }
    if ([textField.text isEqualToString:@"0"]) {
        [textField setText:@""];
    }
}

@end

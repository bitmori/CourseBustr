//
//  CBEditGradeViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/10/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBEditGradeViewController.h"

@interface CBEditGradeViewController () <UITextFieldDelegate>
{
    NSInteger m_gradeType;
}

@property (weak, nonatomic) IBOutlet UITableViewCell *cellGradeType;
@property (weak, nonatomic) IBOutlet UITextField *textfieldDesc;
@property (weak, nonatomic) IBOutlet UITextField *textfieldActualScore;
@property (weak, nonatomic) IBOutlet UITextField *textfieldFullScore;
@property (weak, nonatomic) IBOutlet UITextField *textfieldPercentage;

- (IBAction)onCancelButton:(id)sender;
- (IBAction)onDoneButton:(id)sender;

@property (strong, nonatomic) NSArray* gradeTypeName;

@end

@implementation CBEditGradeViewController

@synthesize courseObj;
@synthesize gradeType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Edit Grade"];
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    keyboardToolbar.layer.borderColor = [[UIColor blackColor] CGColor];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(doneClicked:)];
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [keyboardToolbar setItems:@[flexibleSpace, doneButton]];
    self.textfieldActualScore.inputAccessoryView = keyboardToolbar;
    self.textfieldFullScore.inputAccessoryView = keyboardToolbar;
    self.textfieldPercentage.inputAccessoryView = keyboardToolbar;
    self.textfieldDesc.inputAccessoryView = keyboardToolbar;
    self.gradeTypeName = @[@"Homework", @"Lab", @"Project", @"Midterm", @"Final", @"Bonus", @"Other"];
    self.gradeType = 0;
    if (self.gradeObj) {
        self.gradeType = [self.gradeObj[@"grade_type"] integerValue];
        [self.textfieldDesc setText:self.gradeObj[@"grade_desc"]];
        [self.textfieldActualScore setText:[self.gradeObj[@"grade_score"] stringValue]];
        [self.textfieldFullScore setText:[self.gradeObj[@"grade_full"] stringValue]];
        [self.textfieldPercentage setText:[NSString stringWithFormat:@"%@ %%", [self.gradeObj[@"grade_percent"] stringValue]]];
    }
    [self.cellGradeType.textLabel setText:self.gradeTypeName[self.gradeType]];
}

- (IBAction)onCancelButton:(id)sender {
    [self.delegate editGradeViewControllerDidCancel:self];
}

- (IBAction)onDoneButton:(id)sender {
    if (self.gradeObj==nil) {
        self.gradeObj = [PFObject objectWithClassName:@"CBCourseGrade"];
        [self.gradeObj setObject:self.courseObj forKey:@"course_user"];
        //update course object's progress here!
    }
    NSNumber* percentValue = [NSNumber numberWithInteger:[[self.textfieldPercentage.text substringToIndex:[self.textfieldPercentage.text length]-2] integerValue]];
    [self.gradeObj setObject:[NSNumber numberWithInteger:self.gradeType] forKey:@"grade_type"];
    [self.gradeObj setObject:self.textfieldDesc.text forKey:@"grade_desc"];
    [self.gradeObj setObject:[NSNumber numberWithInteger:[self.textfieldActualScore.text integerValue]] forKey:@"grade_score"];
    [self.gradeObj setObject:[NSNumber numberWithInteger:[self.textfieldFullScore.text integerValue]] forKey:@"grade_full"];
    [self.gradeObj setObject:percentValue forKey:@"grade_percent"];
    [self.gradeObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.delegate editGradeViewControllerDidDone:self];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"selectGradeType"]) {
        UINavigationController* navController = segue.destinationViewController;
        CBGradeTypeViewController* gradeController = [[navController viewControllers] objectAtIndex:0];
        gradeController.gradeType = self.gradeType;
        gradeController.delegate = self;
    }
}

- (void)gradeTypeViewControllerDidCancel:(CBGradeTypeViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)gradeTypeViewControllerDidDone:(CBGradeTypeViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectGradeType:(NSInteger)index
{
    self.gradeType = index;
    [self.cellGradeType.textLabel setText:self.gradeTypeName[index]];
}

- (IBAction)doneClicked:(id)sender
{
    if (self.textfieldActualScore.isEditing) {
        [self.textfieldActualScore endEditing:YES];
    }
    if (self.textfieldFullScore.isEditing) {
        [self.textfieldFullScore endEditing:YES];
    }
    if (self.textfieldPercentage.isEditing) {
        [self.textfieldPercentage endEditing:YES];
    }
    if (self.textfieldDesc.isEditing) {
        [self.textfieldDesc endEditing:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.textfieldDesc] && [textField.text length]==0) {
        [textField setText:@"Grade"];
        return;
    }
    if ([textField.text length]==0) {
        [textField setText:@"0"];
    }
    if ([textField isEqual:self.textfieldPercentage]) {
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

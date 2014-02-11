//
//  CBGradeTypeViewController.m
//  courseBustr
//
//  Created by Ke Yang on 1/10/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBGradeTypeViewController.h"

@interface CBGradeTypeViewController ()

@property (strong, nonatomic) NSArray* gradeTypeName;
@property (weak, nonatomic) IBOutlet UITableViewCell *infoCell;
- (IBAction)onCancelButton:(id)sender;
- (IBAction)onDoneButton:(id)sender;

@end

@implementation CBGradeTypeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gradeTypeName = @[@"Homework", @"Lab", @"Project", @"Midterm", @"Final", @"Bonus", @"Other"];
    [self.infoCell.textLabel setText:self.gradeTypeName[self.gradeType]];
}

- (IBAction)onCancelButton:(id)sender {
    [self.delegate gradeTypeViewControllerDidCancel:self];
}

- (IBAction)onDoneButton:(id)sender {
    [self.delegate selectGradeType:self.gradeType];
    [self.delegate gradeTypeViewControllerDidDone:self];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.gradeTypeName count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.gradeTypeName[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.gradeType = row;
    [self.infoCell.textLabel setText:self.gradeTypeName[row]];
}


@end

//
//  VBPersonViewController.m
//  VBXcodeSummary
//
//  Created by Ariel Rodriguez on 09/09/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import "VBPersonViewController.h"
#import "VBPerson.h"

@interface VBPersonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dobDatePicker;

- (IBAction)datePickerValueChanged:(id)sender;
@end

@implementation VBPersonViewController
- (void)awakeFromNib {
    
    VBPerson *person = [[VBPerson alloc] initWithPersonInfo:nil];
    [self setPerson:person];
    
}

- (void)viewDidLoad {
    
    [[self person] setDateOfBirth:[[self dobDatePicker] date]];
    
}

- (IBAction)datePickerValueChanged:(id)sender {
    
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    [[self person] setDateOfBirth:[datePicker date]];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if ( [textField isEqual:[self firstNameTextField]] ) {
        
        [[self person] setFirstName:[textField text]];
        
    }
    
    if ( [textField isEqual:[self lastNameTextField]] ) {
        
        [[self person] setLastName:[textField text]];
        
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ( [textField isEqual:[self firstNameTextField]] ) {
        
        [[self person] setFirstName:[textField text]];
        
        [[self lastNameTextField] becomeFirstResponder];
        
    }
    
    if ( [textField isEqual:[self lastNameTextField]] ) {
        
        [[self person] setLastName:[textField text]];
        
        [textField resignFirstResponder];
        
    }
    
    return YES;
    
}
@end

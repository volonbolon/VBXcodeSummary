//
//  VBPersonViewController.h
//  VBXcodeSummary
//
//  Created by Ariel Rodriguez on 09/09/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VBPerson;
@interface VBPersonViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, strong) VBPerson *person;
@end

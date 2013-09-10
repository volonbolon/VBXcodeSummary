//
//  VBPerson.h
//  VBXcodeSummary
//
//  Created by Ariel Rodriguez on 09/09/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kFirstNameKey;
extern NSString * const kLastNameKey;
extern NSString * const kDOBKey;

@interface VBPerson : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSDate *dateOfBirth;

- (id)initWithPersonInfo:(NSDictionary *)personInfo;
@end

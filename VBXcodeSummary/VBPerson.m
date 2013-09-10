//
//  VBPerson.m
//  VBXcodeSummary
//
//  Created by Ariel Rodriguez on 09/09/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import "VBPerson.h"

NSString * const kFirstNameKey = @"firstName";
NSString * const kLastNameKey = @"lastName";
NSString * const kDOBKey = @"dob";

@implementation VBPerson

- (id)initWithPersonInfo:(NSDictionary *)personInfo {
    
    self = [super init];
    
    if ( self != nil ) {
        
        _firstName = [personInfo objectForKey:kFirstNameKey];
        _lastName = [personInfo objectForKey:kLastNameKey];
        _dateOfBirth = [personInfo objectForKey:kDOBKey];
        
    }
    
    return self;
    
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    
    VBPerson *copiedPerson = [[VBPerson alloc] init];
    [copiedPerson setFirstName:[self firstName]];
    [copiedPerson setLastName:[self lastName]];
    [copiedPerson setDateOfBirth:[self dateOfBirth]];
    
    return copiedPerson;
    
}

#pragma mark - NSCoding 
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if ( self != nil ) {
        
        _firstName = [aDecoder decodeObjectForKey:kFirstNameKey];
        _lastName = [aDecoder decodeObjectForKey:kLastNameKey];
        _dateOfBirth = [aDecoder decodeObjectForKey:kDOBKey];
        
    }
    
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:[self firstName]
                  forKey:kFirstNameKey];
    [aCoder encodeObject:[self lastName]
                  forKey:kLastNameKey];
    [aCoder encodeObject:[self dateOfBirth]
                  forKey:kDOBKey];
    
}

@end

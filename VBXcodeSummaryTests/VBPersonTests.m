//
//  VBPersonTests.m
//  VBXcodeSummary
//
//  Created by Ariel Rodriguez on 09/09/13.
//  Copyright (c) 2013 VolonBolon. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "VBPerson.h"

@interface NSDate (VBPersonTests)
+ (NSDate *)bloomsday;
@end

@implementation NSDate (VBPersonTests)

+ (NSDate *)bloomsday {
    
    NSDateComponents *bloomsdayComponents = [[NSDateComponents alloc] init];
    [bloomsdayComponents setMonth:6];
    [bloomsdayComponents setDay:16];
    [bloomsdayComponents setYear:1904];
    [bloomsdayComponents setHour:12];
    [bloomsdayComponents setMinute:0];
    NSTimeZone *irelandStandardTime = [NSTimeZone timeZoneWithName:@"Europe/Dublin"];
    [bloomsdayComponents setTimeZone:irelandStandardTime];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *bloomsday = [calendar dateFromComponents:bloomsdayComponents];
    
    return bloomsday;
    
}

@end

@interface VBPersonTests : SenTestCase

@end


@implementation VBPersonTests

- (void)testCanCreatePersonWithDesignatedInitializer {
    
    NSDate *dob = [NSDate bloomsday];
    NSDictionary *personInfo = @{kFirstNameKey:@"first", kLastNameKey:@"last", kDOBKey: dob};
    
    VBPerson *person = [[VBPerson alloc] initWithPersonInfo:personInfo];
    STAssertNotNil(person, @"person should not be nil");
    STAssertTrue([[person firstName] isEqualToString:@"first"], @"person first name should be first, is '%@' instead", [person firstName]);
    STAssertTrue([[person lastName] isEqualToString:@"last"], @"person first name should be last, is '%@' instead", [person lastName]);
    STAssertTrue([[person dateOfBirth] compare:dob] == NSOrderedSame, @"person dob (%@) should be equal to %@", [person dateOfBirth], dob);
    
}

- (void)testCanCopy {
    
    NSDate *dob = [NSDate bloomsday];
    NSDictionary *personInfo = @{kFirstNameKey:@"first", kLastNameKey:@"last", kDOBKey: dob};
    
    VBPerson *person = [[VBPerson alloc] initWithPersonInfo:personInfo];
    
    VBPerson *copiedPerson = [person copy];
    
    STAssertNotNil(copiedPerson, @"person should not be nil");
    STAssertTrue([[copiedPerson firstName] isEqualToString:@"first"], @"person first name should be first, is '%@' instead", [copiedPerson firstName]);
    STAssertTrue([[copiedPerson lastName] isEqualToString:@"last"], @"person first name should be last, is '%@' instead", [copiedPerson lastName]);
    STAssertTrue([[copiedPerson dateOfBirth] compare:dob] == NSOrderedSame, @"person dob (%@) should be equal to %@", [copiedPerson dateOfBirth], dob);
    
}

- (void)testCoder {
    
    NSDate *dob = [NSDate bloomsday];
    NSDictionary *personInfo = @{kFirstNameKey:@"first", kLastNameKey:@"last", kDOBKey: dob};
    
    VBPerson *person = [[VBPerson alloc] initWithPersonInfo:personInfo];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [person encodeWithCoder:archiver];
    [archiver finishEncoding];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    VBPerson *archivedPerson = [[VBPerson alloc] initWithCoder:unarchiver];
    STAssertNotNil(archivedPerson, @"person should not be nil");
    STAssertTrue([[archivedPerson firstName] isEqualToString:@"first"], @"person first name should be first, is '%@' instead", [archivedPerson firstName]);
    STAssertTrue([[archivedPerson lastName] isEqualToString:@"last"], @"person first name should be last, is '%@' instead", [archivedPerson lastName]);
    STAssertTrue([[archivedPerson dateOfBirth] compare:dob] == NSOrderedSame, @"person dob (%@) should be equal to %@", [archivedPerson dateOfBirth], dob);
    
}

@end

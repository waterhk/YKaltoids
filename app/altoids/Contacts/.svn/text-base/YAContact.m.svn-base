//
//  YAContact.m
//  altoids
//
//  Created by Derrick Whittle on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContact.h"

@implementation YAContact
@synthesize givenName = givenName_,
            familyName = familyName_,
            compositeName = compositeName_,
            recordID = recordID_,
            phoneNumberAddresses = phoneNumberAddresses_,
            emailAddresses = emailAddresses_;


- (id) initWithRecordID:(YAContactRecordID*)recordID givenName:(NSString*)givenName familyName:(NSString*)familyName compositeName:(NSString*)compositeName phoneNumberAddresses:(NSArray *)phoneNumberAddresses
{
    self = [super init];
    if(self)
    {
        recordID_ = recordID;
        givenName_ = givenName;
        familyName_ = familyName;
        compositeName_ = compositeName;
        phoneNumberAddresses_ = phoneNumberAddresses;
        
        if(![givenName_ length])
        {
            givenName_ = @"";
        }
        if(![familyName_ length])
        {
            familyName_ = @"";
        }
        if(![compositeName_ length])
        {
            compositeName_ = @"";
        }
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Family Name: %@, Given Name: %@, Phone Number Addresses: %@\n", [self familyName], [self givenName], [self phoneNumberAddresses]];
}

@end

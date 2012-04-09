//
//  YAErrorDomainTests.m
//  altoids
//
//  Created by Jon Herron on 11/10/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAErrorDomainTests.h"
#import "Errors.h"

@implementation YAErrorDomainTests

- (void)testErrorDomainsHaveExpectedValue
{
    STAssertTrue([YAConversationErrorDomain isEqualToString:@"com.yahoo.hub.ConversationErrorDomain"], @"Unexpected error domain");
    STAssertTrue([YAMessageErrorDomain isEqualToString:@"com.yahoo.hub.MessageErrorDomain"], @"Unexpected error domain");
    STAssertTrue([YAParticipantErrorDomain isEqualToString:@"com.yahoo.hub.ParticipantErrorDomain"], @"Unexpected error domain");
    STAssertTrue([YAAddressErrorDomain isEqualToString:@"com.yahoo.hub.AddressErrorDomain"], @"Unexpected error domain");
    STAssertTrue([YAProfileErrorDomain isEqualToString:@"com.yahoo.hub.ProfileErrorDomain"], @"Unexpected error domain");
    STAssertTrue([YASettingsErrorDomain isEqualToString:@"com.yahoo.hub.SettingsErrorDomain"], @"Unexpected error domain");
    STAssertTrue([YARegistrationErrorDomain isEqualToString:@"com.yahoo.hub.RegistrationErrorDomain"], @"Unexpected error domain");
    STAssertTrue([YAValidationErrorDomain isEqualToString:@"com.yahoo.hub.ValidationErrorDomain"], @"Unexpected error domain");
}

@end

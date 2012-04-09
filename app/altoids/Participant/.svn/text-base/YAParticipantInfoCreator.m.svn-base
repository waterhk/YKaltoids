//
//  YAParticipantInfoCreator.m
//  altoids
//
//  Created by Derrick Whittle on 4/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAParticipantInfoCreator.h"
#import "YAParticipantInfo.h"
#import "AddressInfoCreator.h"
#import "UserProfileRepository.h"
#import "RegistrationFetcher.h"
#import "YAContact.h"
#import "YAContactEndpoint.h"
#import "YAContactAddress.h"
#import "YAContactPhoneNumberAddress.h"
#import "YARegistrationInfo.h"
#import "YAUser.h"
#import "YAParticipant.h"

@implementation YAParticipantInfoCreator

@synthesize addressInfoCreator = addressInfoCreator_,
            userProfileRepository = userProfileRepository_,
            registrationFetcher = registrationFetcher_;


- (YAParticipantInfo*) participantInfoWithContactEndpoint:(YAContactEndpoint*)contactEndpoint
{
    YAContactAddress* address = [contactEndpoint address];
    YAAddressInfo* addressInfo;
    if([address isKindOfClass:[YAContactPhoneNumberAddress class]])
    {
        addressInfo = [addressInfoCreator_ addressInfoWithRawPhoneNumber:[(YAContactPhoneNumberAddress*)address displayPhoneNumber]];
    }
    // TODO email address support

    if(!addressInfo)
    {
        return nil;
    }

    YAContact* contact = [contactEndpoint contact];
    NSString* givenName = [contact givenName];
    NSString* familyName = [contact familyName];
    if(![givenName length] && ![familyName length])
    {
        givenName = [contact compositeName];
    }

    return [YAParticipantInfo participantInfoWithFirstName:givenName lastName:familyName addressInfo:addressInfo isContact:YES];
}

- (YAParticipantInfo*) participantInfoWithUserInput:(NSString*)userInput
{
    // for now, we assume user input (from the Compose To field) is a phone number
    // TODO when we support email addresses, examine the user input to guess what kind of address it contains

    return [YAParticipantInfo participantInfoWithFirstName:userInput lastName:nil addressInfo:[addressInfoCreator_ addressInfoWithRawPhoneNumber:userInput]];
}

- (YAParticipantInfo*) participantInfoWithParticipant:(YAParticipant*)participant
{
    YAAddressInfo* addressInfo = [addressInfoCreator_ addressInfoWithAddress:[participant address]];
    return [YAParticipantInfo participantInfoWithFirstName:[participant firstName] lastName:[participant lastName] addressInfo:addressInfo];
}

- (YAParticipantInfo*) participantInfoForCurrentUser;
{
    NSError *error = nil;

    YAUser *currentUser = [userProfileRepository_ fetchCurrentUserProfileWithError:&error];
    if(error)
    {
        return nil;
    }

    YARegistrationInfo* registrationInfo = [registrationFetcher_ fetchRegistrationInfoInManagedObjectContext:[currentUser managedObjectContext] error:&error];
    if(error)
    {
        return nil;
    }

    YAAddressInfo *addressInfo = [addressInfoCreator_ addressInfoWithYE164PhoneNumber:[registrationInfo phoneNumber]];

    return [YAParticipantInfo participantInfoWithFirstName:[currentUser firstName] lastName:[currentUser lastName] addressInfo:addressInfo];
}


@end

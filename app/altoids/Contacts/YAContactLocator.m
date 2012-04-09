//
//  YAContactLocator.m
//  altoids
//
//  Created by Jon Herron on 11/3/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAContactLocator.h"
#import "AppFactory.h"
#import "ContactRepository.h"
#import "ContactEndpointLocator.h"
#import "ContactPredicateCreator.h"
#import "MutableArrayCreator.h"
#import "MutableSetCreator.h"
#import "ArrayFilterer.h"
#import "SetFilterer.h"
#import "Timer.h"
#import "YAContact.h"
#import "YAContactEndpoint.h"
#import "YAContactPhoneNumberAddress.h"
#import "YAContactEndpoint.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"
#import "YAAddress.h"
#import "YAAddressInfo.h"

@implementation YAContactLocator

@synthesize contactRepository = contactRepository_,
            contactEndpointLocator = contactEndopintLocator_,
            participantHandler = participantHandler_,
            contactPredicateCreator = contactPredicateCreator_,
            addressHandler = addressHandler_,
            mutableArrayCreator = mutableArrayCreator_,
            mutableSetCreator = mutableSetCreator_,
            arrayFilterer = arrayFilterer_,
            setFilterer = setFilterer_,
            timerInstanceFactory = timerInstanceFactory_;


- (YAContactEndpoint*) contactEndpointMatchingParticipant:(YAParticipant*)participant
{
    if(!participant)
    {
        return nil;
    }
    return [self contactEndpointMatchingAddress:[[participant address] handle] familyName:[participant lastName] givenName:[participant firstName]];
}

- (YAContactEndpoint*) contactEndpointMatchingParticipantInfo:(YAParticipantInfo*)participantInfo
{
    if(!participantInfo)
    {
        return nil;
    }
    return [self contactEndpointMatchingAddress:[[participantInfo addressInfo] handle] familyName:[participantInfo lastName] givenName:[participantInfo firstName]];
}

- (YAContactEndpoint*) contactEndpointMatchingAddress:(NSString*)address familyName:(NSString*)familyName givenName:(NSString*)givenName
{
    NSArray* contacts = [contactRepository_ contacts];
    if(![contacts count])
    {
        return nil;
    }

    NSMutableArray* matchingContactEndpoints = [mutableArrayCreator_ mutableArrayWithCapacity:1];

    // we assume for now that the address is a phone number; in the future we will need to change the call chain above us to give full address objects
    [contactEndopintLocator_ addContactEndpointsFromContacts:contacts matchingPhoneNumber:address toMatchingContactEndpoints:matchingContactEndpoints andMatchingContacts:nil];

    NSUInteger matchingContactEndpointsCount = [matchingContactEndpoints count];
    if(!matchingContactEndpointsCount)
    {
        return nil;
    }
    if(matchingContactEndpointsCount == 1)
    {
        return [matchingContactEndpoints lastObject];
    }

    // choose the best match among several, preferring family and given name match, then just family name, then just given name

    NSArray* matchingSubarray = [arrayFilterer_ filterArray:matchingContactEndpoints usingPredicate:[contactPredicateCreator_ predicateMatchingContactEndpointsWithContactsWithGivenName:givenName andFamilyName:familyName]];
    if([matchingSubarray count] == 1)
    {
        return [matchingSubarray lastObject];
    }
    
    matchingSubarray = [arrayFilterer_ filterArray:matchingContactEndpoints usingPredicate:[contactPredicateCreator_ predicateMatchingContactEndpointsWithContactsWithFamilyName:familyName]];
    if([matchingSubarray count] == 1)
    {
        return [matchingSubarray lastObject];
    }

    matchingSubarray = [arrayFilterer_ filterArray:matchingContactEndpoints usingPredicate:[contactPredicateCreator_ predicateMatchingContactEndpointsWithContactsWithGivenName:givenName]];
    if([matchingSubarray count] == 1)
    {
        return [matchingSubarray lastObject];
    }

    if([matchingSubarray count])
    {
        // we can't do any better than to pick one of the more exact matches
       return [matchingSubarray objectAtIndex:0];
    }

    // we couldn't match participant names to any of the NAB names, so we can't do any better than to pick an arbitrary NAB jentry
    return [matchingContactEndpoints objectAtIndex:0];
}

- (NSArray*) contactEndpointsBeginningWithString:(NSString*)typeaheadQuery
{
    NSMutableArray* matchingContactEndpoints = [mutableArrayCreator_ mutableArrayWithCapacity:8];

    typeaheadQuery = [typeaheadQuery stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(![typeaheadQuery length])
    {
        return matchingContactEndpoints;
    }

    id<Timer> timer = [timerInstanceFactory_ createTimer];
    [timer beginAccumulatingForTag:@"total"];

    NSMutableSet* matchingContacts = [mutableSetCreator_ mutableSetWithCapacity:8];

    [timer beginAccumulatingForTag:@"0 load contacts"];
    NSArray* contacts = [contactRepository_ contacts];
    [timer stopAccumulatingForTag:@"0 load contacts"];

    [timer beginAccumulatingForTag:@"1 match phone numbers"];
    [contactEndopintLocator_ addContactEndpointsFromContacts:contacts havingPhoneNumbersBeginningWithString:typeaheadQuery toMatchingContactEndpoints:matchingContactEndpoints andMatchingContacts:matchingContacts];
    [timer stopAccumulatingForTag:@"1 match phone numbers"];

    [timer beginAccumulatingForTag:@"2 match names"];
    NSArray* contactsNotMatchedYet = [arrayFilterer_ arrayFromArray:contacts excludingObjectsInSet:matchingContacts];
    NSArray* contactsMatchingAnyName = [arrayFilterer_ filterArray:contactsNotMatchedYet usingPredicate:[contactPredicateCreator_ predicateMatchingContactsWithAnyNameBeginningWith:typeaheadQuery]];
    [timer stopAccumulatingForTag:@"2 match names"];

    [timer beginAccumulatingForTag:@"3 merge name matches into phone number matches"];
    // note that by appending our name matches to the array that already contains phone number matches, we are intentionally prioritizing number matches
    for(YAContact* contact in contactsMatchingAnyName)
    {
        if(![matchingContacts containsObject:contact])
        {
            // [matchingContacts addObject:contact];        // disabled because we don't consult matchingContacts again; re-enable in future if post-processing requires name-matched contacts to be included in set
            for(YAContactAddress* address in [contact phoneNumberAddresses])
            {
                [matchingContactEndpoints addObject:[[YAContactEndpoint alloc] initWithContact:contact address:address]];
            }
            for(YAContactAddress* address in [contact emailAddresses])
            {
                [matchingContactEndpoints addObject:[[YAContactEndpoint alloc] initWithContact:contact address:address]];
            }
        }
    }
    [timer stopAccumulatingForTag:@"3 merge name matches into phone number matches"];

    [timer stopAccumulatingForTag:@"total"];

    // TODO log with session logger instead of NSLog
    NSLog(@"%f seconds to find %u matching contact endpoints from %u contacts", [timer accumulatedSecondsForTag:@"total"], [matchingContactEndpoints count], [contacts count]);
    NSLog(@"%@", [timer descriptionOfAccumulatedSecondsForAllTags]);

    return matchingContactEndpoints;
}


@end

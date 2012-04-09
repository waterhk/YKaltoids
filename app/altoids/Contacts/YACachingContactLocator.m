//
//  YACachingContactLocator.m
//  altoids
//
//  Created by Derrick Whittle on 2/29/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YACachingContactLocator.h"
#import "ContactRepository.h"
#import "ParticipantHandler.h"
#import "AddressHandler.h"
#import "YAContact.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"
#import "YAAddress.h"

@implementation YACachingContactLocator

@synthesize nonCachingContactLocator = nonCachingContactLocator_,
            contactRepository = contactRepository_,
            participantHandler = participantHandler_,
            addressHandler = addressHandler_,
            cache = cache_,
            addressesMatchingNoContact = addressesMatchingNoContact_,
            memoryWarningNotificationCenter = memoryWarningNotificationCenter_;


- (void) addContactEndpoint:(YAContactEndpoint*)contactEndpoint toCacheForAddress:(NSString*)address
{    
    if(contactEndpoint)
    {
        [cache_ setObject:contactEndpoint forKey:address];
    }
    else
    {
        [addressesMatchingNoContact_ addObject:address];       // because we can't put nil into an NSMutableDictionary
    }
}

- (void) clearCache
{
    [cache_ removeAllObjects];
    [addressesMatchingNoContact_ removeAllObjects];
}


- (YAContactEndpoint*) contactEndpointMatchingParticipant:(YAParticipant*)participant
{
    NSString* address = [addressHandler_ handleForAddress:[participantHandler_ addressForParticipant:participant]];
    if(!address)
    {
        return nil;     // we must defend against nil because we use address as the key for collections
    }

    YAContactEndpoint* contactEndpoint = [cache_ objectForKey:address];
    if(contactEndpoint)
    {
        return contactEndpoint;
    }
    if([addressesMatchingNoContact_ containsObject:address])
    {
        return nil;
    }

    contactEndpoint = [nonCachingContactLocator_ contactEndpointMatchingParticipant:participant];
    [self addContactEndpoint:contactEndpoint toCacheForAddress:address];

    return contactEndpoint;
}

- (YAContactEndpoint*) contactEndpointMatchingParticipantInfo:(YAParticipantInfo*)participantInfo
{
    NSString* address = [[participantInfo addressInfo] handle];
    if(!address)
    {
        return nil;     // we must defend against nil because we use address as the key for collections
    }

    YAContactEndpoint* contactEndpoint = [cache_ objectForKey:address];
    if(contactEndpoint)
    {
        return contactEndpoint;
    }
    if([addressesMatchingNoContact_ containsObject:address])
    {
        return nil;
    }
    
    contactEndpoint = [nonCachingContactLocator_ contactEndpointMatchingParticipantInfo:participantInfo];
    [self addContactEndpoint:contactEndpoint toCacheForAddress:address];
    
    return contactEndpoint;
}

- (NSArray*) contactEndpointsBeginningWithString:(NSString*)typeaheadQuery
{
    return [nonCachingContactLocator_ contactEndpointsBeginningWithString:typeaheadQuery];  // no benefit to caching this
}

- (void) didReceiveMemoryWarningFromNotificationCenter:(NSNotificationCenter*)notificationCenter
{
    [self clearCache];
}

- (void) setMemoryWarningNotificationCenter:(NSNotificationCenter*)memoryWarningNotificationCenter
{
    memoryWarningNotificationCenter_ = memoryWarningNotificationCenter;
    [memoryWarningNotificationCenter addObserver:self selector:@selector(didReceiveMemoryWarningFromNotificationCenter:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void) setContactRepository:(id<ContactRepository>)contactRepository
{
    if(contactRepository == contactRepository_)
    {
        return;
    }
    [contactRepository_ removeCachingSubscriber:self];

    contactRepository_ = contactRepository;
    [contactRepository_ addCachingSubscriber:self];
}

- (void) dealloc
{
    [memoryWarningNotificationCenter_ removeObserver:self];
    [contactRepository_ removeCachingSubscriber:self];
}


#pragma mark ContactRepositorySubscriber methods

- (void) contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository
{
    [self clearCache];
}


@end

//
//  YARegistrationInfoRequestDataBuilder.m
//  altoids
//
//  Created by Venkatraman Sridharan on 1/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YARegistrationInfoRequestDataBuilder.h"
#import "YAAddressInfo.h"

#define kAddressMetaDataRequestDataCreaterAddressHandle @"numbers"
#define kAddressMetaDataAddressHandle @"number"
#define kAddresMetaDataRequestDataDictionarySize 1

@class YAAddressInfo;

@implementation YARegistrationInfoRequestDataBuilder

@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;

- (NSDictionary *)requestDataForAddress:(YAAddressInfo *)address
{
    NSString *handle = [address handle];
    
    if ([handle length] == 0)
    {
        return nil;
    }
    
    NSMutableArray *numbers;
    NSMutableDictionary *addressHandleDictionary;
    NSMutableDictionary *requestData;
    
    addressHandleDictionary = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:1];
    [addressHandleDictionary setObject:handle forKey:kAddressMetaDataAddressHandle];
    
    numbers = [[self mutableArrayCreator] mutableArrayWithCapacity:1];
    [numbers addObject:addressHandleDictionary];
    
    requestData = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:kAddresMetaDataRequestDataDictionarySize];
    [requestData setObject:numbers forKey:kAddressMetaDataRequestDataCreaterAddressHandle];
   
    return requestData;
}

@end

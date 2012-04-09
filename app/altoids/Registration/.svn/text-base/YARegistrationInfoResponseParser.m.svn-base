//
//  YARegistrationInfoResponseParser.m
//  altoids
//
//  Created by Jon Herron on 1/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YARegistrationInfoResponseParser.h"

@implementation YARegistrationInfoResponseParser

@synthesize mutableDictionaryCreator = mutableDictionaryCreator;

- (NSArray *)numbersInResponse:(NSDictionary *)response
{
    return [response objectForKey:@"numbers"];
}

- (NSString *)handleForNumber:(NSDictionary *)numberResponse
{
    return [numberResponse objectForKey:@"number"];
}

- (NSDictionary *)servicesForNumber:(NSDictionary *)numberResponse
{
    NSArray *services = [numberResponse objectForKey:@"services"];
    NSMutableDictionary *parsedServices = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:[services count]];
    
    for (NSDictionary *service in services) 
    {
        NSString *serviceType = [service objectForKey:@"type"];
        
        [parsedServices setObject:[NSNumber numberWithBool:YES] forKey:serviceType];
    }
    
    return parsedServices;
}

- (BOOL)hasHubService:(NSDictionary *)services
{
    return [[services objectForKey:@"mmc"] boolValue];
}

- (BOOL)hasSMSService:(NSDictionary *)services
{
    return [[services objectForKey:@"sms"] boolValue];
}

@end

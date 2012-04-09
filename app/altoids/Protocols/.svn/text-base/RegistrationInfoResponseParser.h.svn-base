//
//  RegistrationInfoResponseParser.h
//  altoids
//
//  Created by Jon Herron on 1/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationInfoResponseParser <NSObject>

- (NSArray *)numbersInResponse:(NSDictionary *)response;

- (NSString *)handleForNumber:(NSDictionary *)numberResponse;
- (NSDictionary *)servicesForNumber:(NSDictionary *)numberResponse;

- (BOOL)hasHubService:(NSDictionary *)services;
- (BOOL)hasSMSService:(NSDictionary *)services;

@end

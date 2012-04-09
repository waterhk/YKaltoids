//
//  YAContactEndpoint.h
//  altoids
//
//  Created by Derrick Whittle on 2/21/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAContact, YAContactAddress;


// YAContactEndpoint represents a particular address for a particular contact.
// Simply a (contact, address) tuple.

@interface YAContactEndpoint : NSObject

@property (nonatomic, strong, readonly) YAContact* contact;
@property (nonatomic, strong, readonly) YAContactAddress* address;

- (id) initWithContact:(YAContact*)contact address:(YAContactAddress*)address;

@end

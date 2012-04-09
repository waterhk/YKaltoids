//
//  YAMMCRecentMessageFacade.h
//  altoids
//
//  Created by Jon Herron on 9/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import <Foundation/Foundation.h>

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAMMCRecentMessage : NSObject

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithParsedJSONRecentMessageResponse:(NSDictionary *)aParsedJSONRecentMessageResponse;

- (NSString *)messageID;
- (NSString *)subject;
- (NSDate *)sent;
- (NSString *)recipients;
- (NSString *)sender;
- (NSString *)snippet;

@end

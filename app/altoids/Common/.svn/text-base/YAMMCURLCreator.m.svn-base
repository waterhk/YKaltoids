//
//  YAMMCURLCreator.m
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientURLAndURLRequestHandling
//

#import "YAMMCURLCreator.h"

#define kMMCCrumbParamKey @"c"

// Private class extension
@interface YAMMCURLCreator ()

// @property definitions

// methods

@end

@implementation YAMMCURLCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize authInfoProvider = authInfoProvider_;
@synthesize serverConfiguration = serverConfiguration_;
@synthesize urlCreator = urlCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark MMCURLCreator delegate methods

- (NSURL *)createMMCURLWithRelativeURI:(NSString *)aRelativeURI
{
    return [self createMMCURLWithRelativeURI:aRelativeURI params:nil];
}

- (NSURL *)createMMCURLWithRelativeURI:(NSString *)aRelativeURI params:(NSDictionary *)aParams
{
    NSMutableDictionary *mmcParams = [NSMutableDictionary dictionaryWithDictionary:aParams];
    NSString *scheme = @"http";
    NSString *server = [[self serverConfiguration] mmcServerHostname];
    NSString *crumb = [[self authInfoProvider] crumb];
    
    if (crumb) 
    {
        [mmcParams setObject:crumb forKey:kMMCCrumbParamKey];
    }
    
    return [[self urlCreator] createWithScheme:scheme server:server relativeURI:aRelativeURI params:mmcParams];
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMMCURLCreator ()

@end

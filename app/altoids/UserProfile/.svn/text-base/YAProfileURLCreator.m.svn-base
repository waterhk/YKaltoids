//
//  YAProfileURLCreator.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAProfileURLCreator.h"

#define kProfileCrumbParamKey @".crumb"

// Private class extension
@interface YAProfileURLCreator ()

// @property definitions

// methods

@end

@implementation YAProfileURLCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize urlCreator = urlCreator_;
@synthesize profileServerConfiguration = profileServerConfiguration_;
@synthesize authInfoProvider = authInfoProvider_;

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
#pragma mark <Protocol Name> delegate methods

- (NSURL *)createProfileURLWithRelativeURI:(NSString *)aRelativeURI
{
    return [self createProfileURLWithRelativeURI:aRelativeURI params:nil];
}

- (NSURL *)createProfileURLWithRelativeURI:(NSString *)aRelativeURI params:(NSDictionary *)aParams
{
    NSMutableDictionary *profileParams = [NSMutableDictionary dictionaryWithDictionary:aParams];
    NSString *scheme = @"http";
    NSString *server = [[self profileServerConfiguration] serverHostname];
    
    [profileParams setObject:[[self authInfoProvider] crumbFromProfile] forKey:kProfileCrumbParamKey];
    [profileParams setObject:@"json" forKey:@"format"];
    
    return [[self urlCreator] createWithScheme:scheme server:server relativeURI:aRelativeURI params:profileParams];    
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
#pragma mark YAProfileURLCreator ()

@end

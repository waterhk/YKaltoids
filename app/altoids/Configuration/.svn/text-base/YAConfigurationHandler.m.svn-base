//
//  YAConfigurationHandler.m
//  altoids
//
//  Created by Anand Subba Rao on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConfigurationHandler.h"

// Private class extension
@interface YAConfigurationHandler ()

// @property definitions
// methods
@end

@implementation YAConfigurationHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize bundleContainingDefaultSettings = bundleContainingDefaultSettings_;
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
#pragma mark ConfigurationHandler methods
- (NSArray *)arrayForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:key];   
}

- (BOOL)boolForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];   
}

- (NSData *)dataForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] dataForKey:key];   
}

- (NSDictionary *)dictionaryForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];   
}

- (float)floatForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];   
}

- (NSInteger)integerForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];   
}

- (id)objectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];   
}

- (NSArray *)stringArrayForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] stringArrayForKey:key];   
}

- (NSString *)stringForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];   
}

- (double)doubleForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];   
}

- (NSURL *)URLForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] URLForKey:key];   
}

- (NSArray *)environmentSpecificArrayForKey:(NSString *)key
{
    return nil;
}

- (BOOL)environmentSpecificBoolForKey:(NSString *)key
{
    return NO;
}

- (NSData *)environmentSpecificDataForKey:(NSString *)key
{
    return nil;
}

- (NSDictionary *)environmentSpecificDictionaryForKey:(NSString *)key
{
    return nil;
}

- (float)environmentSpecificFloatForKey:(NSString *)key
{
    return 0;
}

- (NSInteger)environmentSpecificIntegerForKey:(NSString *)key
{
    return 0;
}

- (id)environmentSpecificObjectForKey:(NSString *)key
{
    return nil;
}

- (NSArray *)environmentSpecificStringArrayForKey:(NSString *)key
{
    return nil;
}

- (NSString *)environmentSpecificStringForKey:(NSString *)key
{
    return [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"serverEnvironment"] valueForKey:key];
}

- (double)environmentSpecificDoubleForKey:(NSString *)key
{
    return 0;
}

- (NSURL *)environmentSpecificURLForKey:(NSString *)key
{
    return nil;
}



- (void)setBool:(BOOL)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
#pragma mark YAConfigurationHandler ()
- (void)registerDefaults
{
    NSString *settingsFile = [[self bundleContainingDefaultSettings] pathForResource:kConfigFileDefaults ofType:@"plist"];
    NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:settingsFile];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

@end

//
//  ConfigurationHandler.h
//  altoids
//
//  Created by Anand Subba Rao on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConfigurationHandler <NSObject>

#pragma mark -
#pragma mark @required
@required
- (NSArray *)arrayForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (NSData *)dataForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;
- (NSArray *)stringArrayForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (NSURL *)URLForKey:(NSString *)key;

- (NSArray *)environmentSpecificArrayForKey:(NSString *)key;
- (BOOL)environmentSpecificBoolForKey:(NSString *)key;
- (NSData *)environmentSpecificDataForKey:(NSString *)key;
- (NSDictionary *)environmentSpecificDictionaryForKey:(NSString *)key;
- (float)environmentSpecificFloatForKey:(NSString *)key;
- (NSInteger)environmentSpecificIntegerForKey:(NSString *)key;
- (id)environmentSpecificObjectForKey:(NSString *)key;
- (NSArray *)environmentSpecificStringArrayForKey:(NSString *)key;
- (NSString *)environmentSpecificStringForKey:(NSString *)key;
- (double)environmentSpecificDoubleForKey:(NSString *)key;
- (NSURL *)environmentSpecificURLForKey:(NSString *)key;


- (void)setBool:(BOOL)value forKey:(NSString *)key;


- (void)registerDefaults;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end

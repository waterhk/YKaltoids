//
//  YASessionLogger.h
//  altoids
//
//  Created by Xianzhe Ma on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SessionLogLevelDebug
}SessionLogLevel;

#define YASessionLogDebug(...) [[YASessionLogger sharedSessionLogger] logWithLevel:SessionLogLevelDebug functionName:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] format:__VA_ARGS__]


@interface YASessionLogger : NSObject

@property (nonatomic, strong) NSString *logFileName;
@property (nonatomic, assign) SessionLogLevel logLevel;

+ (YASessionLogger *)sharedSessionLogger;

- (void)logWithLevel:(SessionLogLevel)aLevel functionName:(NSString *)aFunctionName format:(NSString *)aFormat, ...;

- (NSData *)sessionLogData;

@end

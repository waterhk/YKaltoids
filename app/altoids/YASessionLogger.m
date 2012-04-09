//
//  YASessionLogger.m
//  altoids
//
//  Created by Xianzhe Ma on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YASessionLogger.h"

static YASessionLogger *sSharedSessionLogger;

@interface YASessionLogger ()

@property (nonatomic, strong) NSFileHandle *fileHandle;
@property (nonatomic, assign) dispatch_queue_t backgroundQueueForLogging;
@property (nonatomic, assign) unsigned long long maxLengthInBytes;
@property (nonatomic, strong) NSString *logFilePath;

@end

@implementation YASessionLogger

@synthesize logFileName = logFileName_;
@synthesize logLevel = logLevel_;

@synthesize fileHandle = fileHandle_;
@synthesize backgroundQueueForLogging = backgroundQueueForLogging_;
@synthesize maxLengthInBytes = maxLengthInBytes_;
@synthesize logFilePath = logFilePath_;

+ (void)initialize {
    sSharedSessionLogger = [[YASessionLogger alloc] init];
}

+ (YASessionLogger *)sharedSessionLogger {
    return sSharedSessionLogger;
}

- (id)init {
    if (self = [super init]) {
        [self setLogFileName:@"session.log"];
        [self setLogLevel:SessionLogLevelDebug];
        
        //log file path: Library/Caches/session.log
        NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent];
        NSString *hubCacheDirectoryPath = [NSString pathWithComponents:[NSArray arrayWithObjects:bundlePath, @"Library", @"Caches", nil]];
        NSString *logFilePath = [hubCacheDirectoryPath stringByAppendingPathComponent:[self logFileName]];
        [self setLogFilePath:logFilePath];
        
        if(![[NSFileManager defaultManager] fileExistsAtPath:logFilePath]) {
            [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
        }
        
        [self setFileHandle:[NSFileHandle fileHandleForUpdatingAtPath:logFilePath]];
        [[self fileHandle] seekToEndOfFile];
        [self setBackgroundQueueForLogging:dispatch_queue_create("YASessionLogger.LoggingBackgroundQueue", DISPATCH_QUEUE_CONCURRENT)];
        [self setMaxLengthInBytes:512 * 1024];
    }
    return self;
}

- (void)logWithLevel:(SessionLogLevel)aLevel functionName:(NSString *)aFunctionName format:(NSString *)aFormat, ... {
    if (aLevel > [self logLevel]) {
        return;
    }
    
    va_list argumentListPointer;
    va_start(argumentListPointer, aFormat);
    NSString *actualMessageFromClient = [[NSString alloc] initWithFormat:aFormat arguments:argumentListPointer];
    va_end(argumentListPointer);
    
    NSString *newLogMessageString = [NSString stringWithFormat:@"%@ [%c:%x] %@ %@\n", [NSDate date], aLevel, pthread_mach_thread_np(pthread_self()), aFunctionName, actualMessageFromClient];
    dispatch_barrier_async([self backgroundQueueForLogging], ^(void){
        NSData *newLogMessageData = [newLogMessageString dataUsingEncoding:NSUTF8StringEncoding];
        unsigned long long newLogFileLength = [[self fileHandle] offsetInFile] + [newLogMessageData length];
        if ( newLogFileLength > [self maxLengthInBytes] ) {
            [[self fileHandle] truncateFileAtOffset:0ull];
        }
        
        [[self fileHandle] writeData:newLogMessageData];
        NSLog(@"%@", newLogMessageString);
    });
}

- (NSData *)sessionLogData {
    __block NSData *sessionLogData;
    dispatch_sync([self backgroundQueueForLogging], ^{
        sessionLogData = [NSData dataWithContentsOfFile:[self logFilePath]];
    });
    return sessionLogData;
}

@end

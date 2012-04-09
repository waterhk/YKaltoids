//
//  AccountInfoRepository.m
//  SessionManager2
//
//  Created by Lei Cai on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMAccountInfoRepositoryWithFilesystem.h"

@implementation YSMAccountInfoRepositoryWithFilesystem(private)

static NSString* const kRepositoryKey = @"accountRepository";

- (NSString*)diskPath
{
    return [filesystemPathGenerator_ getPath:kRepositoryKey];
}

@end

@implementation YSMAccountInfoRepositoryWithFilesystem

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)setAccountInfo:(YSMAccountInfo*)aAccountInfo
{
    self.currentAccount = aAccountInfo;
}

- (BOOL)saveToRepository
{
    if (!self.currentAccount) return NO;
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver encodeObject:self.currentAccount forKey:kRepositoryKey];
    [archiver finishEncoding];
    return [data writeToFile:[self diskPath] atomically:YES];
}

- (BOOL)restoreFromRepository
{
    NSString* path = [self diskPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        self.currentAccount = nil;
        return NO;
    }
    
    NSData *data = [[NSMutableData alloc]
                     initWithContentsOfFile:[self diskPath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                      initForReadingWithData:data];
    self.currentAccount = [unarchiver decodeObjectForKey:kRepositoryKey];
    [unarchiver finishDecoding];
    return YES;
}

- (void)clearRepository
{
    NSString *path = [self diskPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    }
}

@synthesize currentAccount = currentAccount_;
@synthesize filesystemPathGenerator = filesystemPathGenerator_;
@end

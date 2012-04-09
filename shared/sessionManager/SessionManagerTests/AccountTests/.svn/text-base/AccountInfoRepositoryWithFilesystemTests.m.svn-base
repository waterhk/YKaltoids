//
//  AccountInfoRepositoryWithFilesystemTests.m
//  SessionManager3
//
//  Created by Lei  on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "AccountInfoRepositoryWithFilesystemTests.h"

@implementation AccountInfoRepositoryWithFilesystemTests

static NSString* const testPath = @"UnitTests_accountRepository";

- (void)setUp
{
    filesystemPathGeneratorMock = [OCMockObject mockForProtocol:@protocol(FilesystemPathGeneratorProtocol)];
    
    accountInfoRepository = [[YSMAccountInfoRepositoryWithFilesystem alloc] init];
    accountInfoRepository.filesystemPathGenerator = filesystemPathGeneratorMock;
    
    accountInfoRepository2 = [[YSMAccountInfoRepositoryWithFilesystem alloc] init];
    accountInfoRepository2.filesystemPathGenerator = filesystemPathGeneratorMock;

    // We will return a repository file for UT only, so that not to deal with the one using by production
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    // see http://stackoverflow.com/questions/6515979/nssearchpathfordirectoriesindomains-returns-the-wrong-directory
    // for why we need to create the Documents/ in our UT
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    NSString *utfilepath = [path stringByAppendingPathComponent:testPath];
    [[[filesystemPathGeneratorMock stub] andReturn:utfilepath] getPath:OCMOCK_ANY];
}

- (void)tearDown
{
    [accountInfoRepository clearRepository];
}

- (void)testSaveWithoutAccount
{
    accountInfoRepository.currentAccount = nil;
    STAssertFalse([accountInfoRepository saveToRepository], @"Unexpected return value");
}

- (void)testSaveWithAccountABC
{
    YSMAccountInfo *abc = [[YSMAccountInfo alloc] init];
    abc.userID = @"abc";
    accountInfoRepository.currentAccount = abc;
    
    STAssertTrue([accountInfoRepository saveToRepository], @"Unexpected return value");

    NSString * utfilepath = [filesystemPathGeneratorMock getPath:testPath];
    STAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:utfilepath], @"Repo File not exist after save");
}

- (void)testRestore
{
    YSMAccountInfo *abc = [[YSMAccountInfo alloc] init];
    abc.userID = @"abc";
    accountInfoRepository.currentAccount = abc;
    
    STAssertTrue([accountInfoRepository saveToRepository], @"Unexpected return value");
    
    [accountInfoRepository2 restoreFromRepository];
    YSMAccountInfo *abc2 = accountInfoRepository2.currentAccount;
    STAssertTrue([abc2.userID isEqualToString:abc.userID], @"");
}

- (void)testClear
{
    YSMAccountInfo *abc = [[YSMAccountInfo alloc] init];
    abc.userID = @"abc";
    accountInfoRepository.currentAccount = abc;
    
    STAssertTrue([accountInfoRepository saveToRepository], @"Unexpected return value");

    [accountInfoRepository clearRepository];
    NSString * utfilepath = [filesystemPathGeneratorMock getPath:testPath];
    STAssertFalse([[NSFileManager defaultManager] fileExistsAtPath:utfilepath], @"Repo File still exist after clear");
}

@end

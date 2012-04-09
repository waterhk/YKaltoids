//
//  AccountInfoRepositoryFactory.m
//  SessionManager2
//
//  Created by Lei Cai on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMAccountInfoRepositoryFactory.h"
#import "YSMAccountInfoRepositoryWithFilesystem.h"
#import "YSMFilesystemPathGenerator.h"
#import "YSMAccountInfoRepositoryWithKeychain.h"


@implementation YSMAccountInfoRepositoryFactory
@synthesize repositoryTypes = repositoryTypes_;

- (id<AccountInfoRepository>)create
{
    id<AccountInfoRepository> accountInfoRepository = nil;
    
    switch ([self repositoryTypes]) {
        case RepoWithFilesystem: {
            accountInfoRepository = [[YSMAccountInfoRepositoryWithFilesystem alloc] init];
            id<FilesystemPathGenerator> filesystemPathGenerator = [[YSMFilesystemPathGenerator alloc] init];
            ((YSMAccountInfoRepositoryWithFilesystem*)accountInfoRepository).filesystemPathGenerator = filesystemPathGenerator;
            break;
        }
        case RepoWithKeychain:
            accountInfoRepository = [[YSMAccountInfoRepositoryWithKeychain alloc] init];
            break;
        default:
            break;
    }
    
    return accountInfoRepository;
}

@end

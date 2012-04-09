//
//  AccountInfoRepository.h
//  SessionManager2
//
//  Created by Lei Cai on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccountInfoRepository.h"
#import "FilesystemPathGenerator.h"
#import "YSMAccountInfo.h"

@interface YSMAccountInfoRepositoryWithFilesystem : NSObject <AccountInfoRepository> {
 @private
    YSMAccountInfo *currentAccount_;
    id<FilesystemPathGenerator> filesystemPathGenerator_;
}

@property (nonatomic, retain) YSMAccountInfo *currentAccount;
@property (nonatomic, retain) id<FilesystemPathGenerator> filesystemPathGenerator;

@end

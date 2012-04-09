//
//  AccountInfoRepositoryWithFilesystemTests.h
//  SessionManager3
//
//  Created by Lei Cai on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>
#import "YSMAccountInfoRepositoryWithFilesystem.h"
#import "FilesystemPathGeneratorProtocol.h"
#import "YSMAccountInfo.h"

@interface AccountInfoRepositoryWithFilesystemTests : SenTestCase {
    YSMAccountInfoRepositoryWithFilesystem *accountInfoRepository;
    id filesystemPathGeneratorMock;
    YSMAccountInfoRepositoryWithFilesystem *accountInfoRepository2;
}

@end

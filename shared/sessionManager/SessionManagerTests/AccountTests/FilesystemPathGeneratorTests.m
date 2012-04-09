//
//  FilesystemPathGeneratorTests.m
//  SessionManager3
//
//  Created by Lei Cai on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FilesystemPathGeneratorTests.h"

@implementation FilesystemPathGeneratorTests
- (void)setUp
{
    filesystemPathGenerator = [[YSMFilesystemPathGenerator alloc] init];
}

- (void)tearDown
{
}

- (void)testGetWithNil
{
    STAssertNil([filesystemPathGenerator getPath:nil], @"Unexpected return value");
}

- (void)testGetWithFileName
{
    STAssertNotNil([filesystemPathGenerator getPath:@"filename"], @"Unexpected return value");
}

- (void)testGetWithPathAndFileName
{
    STAssertNotNil([filesystemPathGenerator getPath:@"path/filename"], @"Unexpected return value");
}

@end

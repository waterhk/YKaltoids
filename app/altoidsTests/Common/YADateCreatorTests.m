//
//  YADateCreatorTests.m
//  altoids
//
//  Created by Venkatraman Sridharan on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YADateCreatorTests.h"

@interface YADateCreatorTests()  

@property (nonatomic, strong) YADateCreator *dateCreator;

@end

@implementation YADateCreatorTests
@synthesize dateCreator = dateCreator_;

// All code under test must be linked into the Unit Test bundle

- (void)setUp 
{    
    [self setDateCreator:[[YADateCreator alloc] init]];
}


- (void) testCanCreateDateWithCurrentDate
{
    STAssertNotNil([[self dateCreator] dateForNow], @"Expected Not Nil");
}

@end

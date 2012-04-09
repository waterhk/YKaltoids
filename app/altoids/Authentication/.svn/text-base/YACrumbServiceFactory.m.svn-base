//
//  YACrumbServiceFactory.m
//  altoids
//
//  Created by Anand Subba Rao on 9/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YACrumbServiceFactory.h"
#import "YACrumbService.h"

// Private class extension
@interface YACrumbServiceFactory ()

// @property definitions

// methods

@end

@implementation YACrumbServiceFactory
// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize serverConfiguration = serverConfiguration_;
@synthesize profileServerConfiguration = profileServerConfiguration_;
// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <CrumbServiceFactory> methods
- (id<CrumbService>)createWithDelegate:(id<CrumbServiceDelegate>)delegate
{
    return [[YACrumbService alloc] initWithDelegate:delegate serverConfiguration:[self serverConfiguration]
                         profileServerConfiguration:[self profileServerConfiguration]];
}
// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YACrumbServiceFactory ()

@end

//
//  YARegistrationService.h
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationService.h"
#import "RegistrationRepository.h"
#import "RegistrationCommandFactory.h"
#import "RegistrationResponseHandler.h"
#import "CommandQueue.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YARegistrationService : NSObject<RegistrationService, RegistrationResponseHandler>

#pragma mark @property declarations
@property (nonatomic, strong) id<RegistrationCommandFactory> registrationCommandFactory;
@property (nonatomic, strong) id<CommandQueue> mmcCommandQueue;

#pragma mark  Class methods

#pragma mark Instance methods

@end

//
//  YARegistrationRepository.h
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandQueue.h"
#import "ManagedObjectContextFactory.h"
#import "RegistrationErrorCreator.h"
#import "RegistrationFetcher.h"
#import "RegistrationHandler.h"
#import "RegistrationRepository.h"
#import "RegistrationInfoCommandCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YARegistrationRepository : NSObject <RegistrationRepository>

#pragma mark @property declarations
@property (nonatomic, strong) id<CommandQueue> mmcCommandQueue;
@property (nonatomic, strong) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (nonatomic, strong) id<RegistrationFetcher> registrationFetcher;
@property (nonatomic, strong) id<RegistrationErrorCreator> registrationErrorCreator;
@property (nonatomic, strong) id<RegistrationHandler> registrationHandler;
@property (nonatomic, strong) id<RegistrationInfoCommandCreator> registrationInfoCommandCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end

//
//  YAPersonImageRepository.h
//  altoids
//
//  Created by Anand Biligiri on 11/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchRequestCreator.h"
#import "PersonImageHandler.h"
#import "PersonImagePredicateCreator.h"
#import "PersonImageRepository.h"
#import "ParticipantErrorCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAPersonImageRepository : NSObject<PersonImageRepository>

#pragma mark @property declarations
@property (strong, nonatomic) id<PersonImageHandler> personImageHandler;
@property (strong, nonatomic) id<FetchRequestCreator> fetchRequestCreator;
@property (strong, nonatomic) id<PersonImagePredicateCreator> personImagePredicateCreator;
@property (strong, nonatomic) id<ParticipantErrorCreator> participantErrorCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end

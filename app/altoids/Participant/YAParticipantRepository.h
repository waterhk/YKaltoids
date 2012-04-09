//
//  YAParticipantRepository.h
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressRepository.h"
#import "ImageScaler.h"
#import "ParticipantHandler.h"
#import "ParticipantRepository.h"
#import "ParticipantCommandFactory.h"
#import "CommandQueue.h"
#import "ImageTransformer.h"
#import "PersonImageHandler.h"
#import "PersonImageRepository.h"
#import "ParticipantErrorCreator.h"
#import "MutableDictionaryCreator.h"
#import "MutableSetCreator.h"
#import "ParticipantUpdater.h"
#import "ParticipantCreator.h"
#import "UserProfileRepository.h"
#import "UserProfileHandler.h"
#import "AppFactory.h"

@interface YAParticipantRepository : NSObject <ParticipantRepository>

@property (strong, nonatomic) id<AddressRepository> addressRepository;
@property (strong, nonatomic) id<ImageScaler> imageScaler;
@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<ParticipantCommandFactory> participantCommandFactory;
@property (strong, nonatomic) id<CommandQueue> mmcCommandQueue;
@property (strong, nonatomic) id<ParticipantImageLoaderCommandInstanceFactory> participantImageLoaderCommandInstanceFactory;
@property (strong, nonatomic) id<ImageTransformer> imageTransformer;
@property (strong, nonatomic) id<PersonImageRepository> personImageRepository;
@property (strong, nonatomic) id<PersonImageHandler> personImageHandler;
@property (strong, nonatomic) id<ParticipantErrorCreator> participantErrorCreator;
@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;
@property (strong, nonatomic) id<MutableSetCreator> mutableSetCreator;
@property (strong, nonatomic) id<ParticipantUpdater> participantUpdater;
@property (strong, nonatomic) id<ParticipantCreator> participantCreator;
@property (strong, nonatomic) id<UserProfileRepository> userProfileRepository;
@property (strong, nonatomic) id<UserProfileHandler> userProfileHandler;

@end

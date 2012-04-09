//
//  YAParticipantImageLoaderCommand.h
//  altoids
//
//  Created by Jon Herron on 11/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataCreator.h"
#import "ImageCreator.h"
#import "ManagedObjectContextFactory.h"
#import "ParticipantHandler.h"
#import "ParticipantImageLoaderCommand.h"
#import "ParticipantImageLoaderCommandDelegate.h"
#import "URLCreator.h"
#import "YAParticipant.h"
#import "ContactLocator.h"
#import "PersonImageHandler.h"
@protocol ContactRepository;


@interface YAParticipantImageLoaderCommand : NSObject <ParticipantImageLoaderCommand>

- (id)initWithParticipant:(YAParticipant *)participant callbackData:(id)callbackData delegate:(id<ParticipantImageLoaderCommandDelegate>)delegate;

@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<DataCreator> dataCreator;
@property (strong, nonatomic) id<ImageCreator> imageCreator;
@property (strong, nonatomic) id<URLCreator> urlCreator;
@property (strong, nonatomic) id<ContactLocator> contactLocator;
@property (strong, nonatomic) id<ContactRepository> contactRepository;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory; 
@property (strong, nonatomic) id<PersonImageHandler> personImageHandler;

@end

//
//  YAFetchUserProfileCommand.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@protocol TransportFactory, UserProfileHandler, PersonImageHandler, ManagedObjectContextFactory, UserProfileRequestBuilder, UserProfileResponseParser, URLCreator, DataCreator, ImageTransformer;
@class YAUser;

@interface YAFetchUserProfileCommand : NSObject<Command>

// injected dependencies
@property (nonatomic, strong) id<TransportFactory> transportFactory;
@property (nonatomic, strong) id<UserProfileHandler> userProfileHandler;
@property (nonatomic, strong) id<PersonImageHandler> personImageHandler;
@property (nonatomic, strong) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (nonatomic, strong) id<UserProfileRequestBuilder> userProfileRequestBuilder;
@property (nonatomic, strong) id<UserProfileResponseParser> userProfileResponseParser;
@property (nonatomic, strong) id<URLCreator> urlCreator;
@property (nonatomic, strong) id<DataCreator> dataCreator;
@property (nonatomic, strong) id<ImageTransformer> imageTransformer;

// operational parameters
@property (nonatomic, strong) NSManagedObjectID* userObjectID;

- (id) initWithUser:(YAUser*)user;

@end

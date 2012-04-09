//
//  YAUserProfileCommandFactory.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileCommandFactory.h"
@protocol FetchUserProfileCommandInstanceFactory, MMCCommandInstanceFactory, ActivityOverlayCommandInstanceFactory, JSONParser, CompositeCommandInstanceFactory;
@protocol UserProfileErrorHandlerFactory, UserProfileParsedJSONResponseHandlerCreator, UserProfileURLRequestBuilderCreator, UserProfileUpdateNameWithPermissionRequestDataBuilder, UserProfileImageUpdateParsedJSONResponseHandlerCreator, UserProfileImageUpdateRequestDataBuilder, CommandErrorHandlerCreator, ProfileURLParametersCreator;

@interface YAUserProfileCommandFactory : NSObject<UserProfileCommandFactory>

@property (strong, nonatomic) id<FetchUserProfileCommandInstanceFactory> fetchUserProfileCommandInstanceFactory;
@property (strong, nonatomic) id<MMCCommandInstanceFactory> mmcCommandInstanceFactory;
@property (strong, nonatomic) id<ActivityOverlayCommandInstanceFactory> activityOverlayCommandInstanceFactory;
@property (strong, nonatomic) id<JSONParser> jsonParser;
@property (strong, nonatomic) id<UserProfileErrorHandlerFactory> userProfileErrorHandlerFactory;
@property (strong, nonatomic) id<UserProfileParsedJSONResponseHandlerCreator> userProfileResponseHandlerFactory;
@property (strong, nonatomic) id<UserProfileURLRequestBuilderCreator> userProfileURLRequestBuilderCreator;
@property (strong, nonatomic) id<UserProfileUpdateNameWithPermissionRequestDataBuilder> userProfileUpdateNameWithPermissionRequestDataBuilder;
@property (strong, nonatomic) id<UserProfileImageUpdateParsedJSONResponseHandlerCreator> userProfileImageUpdateParsedJSONResponseHandlerCreator;
@property (strong, nonatomic) id<UserProfileImageUpdateRequestDataBuilder> userProfileImageUpdateRequestDataBuilder;
@property (strong, nonatomic) id<CommandErrorHandlerCreator> profileCommandErrorHandlerCreator;
@property (strong, nonatomic) id<ProfileURLParametersCreator> profileURLParametersCreator;
@property (strong, nonatomic) id<CompositeCommandInstanceFactory> compositeCommandInstanceFactory;

@end

//
//  YAUserProfileCommandFactory.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileCommandFactory.h"
#import "AppFactory.h"
#import "UserProfileErrorHandlerFactory.h"
#import "UserProfileParsedJSONResponseHandlerCreator.h"
#import "UserProfileURLRequestBuilderCreator.h"
#import "UserProfileUpdateNameWithPermissionRequestDataBuilder.h"
#import "UserProfileImageUpdateParsedJSONResponseHandlerCreator.h"
#import "UserProfileImageUpdateRequestDataBuilder.h"
#import "CommandErrorHandlerCreator.h"
#import "ProfileURLParametersCreator.h"
#import "Command.h"

@implementation YAUserProfileCommandFactory

@synthesize fetchUserProfileCommandInstanceFactory = fetchUserProfileCommandInstanceFactory_,
            mmcCommandInstanceFactory = mmcCommandInstanceFactory_,
            activityOverlayCommandInstanceFactory = activityOverlayCommandInstanceFactory_;
@synthesize jsonParser = jsonParser_;
@synthesize userProfileErrorHandlerFactory = userProfileErrorHandlerFactory_;
@synthesize userProfileResponseHandlerFactory = userProfileResponseHandlerFactory_;
@synthesize userProfileURLRequestBuilderCreator = userProfileURLRequestBuilderCreator_;
@synthesize userProfileUpdateNameWithPermissionRequestDataBuilder = userProfileUpdateNameWithPermissionRequestDataBuilder_;
@synthesize userProfileImageUpdateParsedJSONResponseHandlerCreator = userProfileImageUpdateParsedJSONResponseHandlerCreator_;
@synthesize userProfileImageUpdateRequestDataBuilder = userProfileImageUpdateRequestDataBuilder_;
@synthesize profileCommandErrorHandlerCreator = profileCommandErrorHandlerCreator_;
@synthesize profileURLParametersCreator = profileURLParametersCreator_;
@synthesize compositeCommandInstanceFactory = compositeCommandInstanceFactory_;

- (id<Command>)createFetchUserProfileCommandWithUser:(YAUser *)user
{
    return [fetchUserProfileCommandInstanceFactory_ createFetchUserProfileCommandWithUser:user];
}

- (id<Command>)createUpdateProfileNameWithPermissionCommandWithUser:(YAUser *)user 
                                                          firstName:(NSString *)theFirstName 
                                                           lastName:(NSString *)theLastName 
                                          updateProfileImageCommand:(id<Command>)theUpdateProfileImageCommand 
                                                     viewForOverlay:(UIView *)theView
                                                           delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate
{
    id<ErrorHandler> specificErrorHandler = [[self userProfileErrorHandlerFactory] userProfileUpdateNameWithPermissionErrorHandlerWithUser:user];
    id<CommandErrorHandler> commandErrorHandler = [[self profileCommandErrorHandlerCreator] createWithErrorHandler:specificErrorHandler];
    
    id<UserProfileUpdateNameWithPermissionParsedJSONResponseHandler> userProfileUpdateNameWithPermissionParsedJSONResponseHandler = 
    [[self userProfileResponseHandlerFactory] createWithUser:user 
                                                   firstName:theFirstName 
                                                    lastName:theLastName 
                                   updateProfileImageCommand:theUpdateProfileImageCommand
                                                    delegate:theDelegate];
    
    id<URLRequestBuilder> requestBuilder = [[self userProfileURLRequestBuilderCreator] createUserProfileURLRequestBuilderForUpdatingNameAndPermissionForUser:user];

    NSDictionary *requestData = [[self userProfileUpdateNameWithPermissionRequestDataBuilder] requestDataForUserProfileUpdateWithFirstName:theFirstName lastName:theLastName];

    id<Command> command = [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:requestBuilder
                                                        urlRequestParameters:nil
                                                              urlRequestData:requestData
                                                                  jsonParser:jsonParser_
                                                   parsedJSONResponseHandler:userProfileUpdateNameWithPermissionParsedJSONResponseHandler
                                                         commandErrorHandler:commandErrorHandler];
    
    return [activityOverlayCommandInstanceFactory_ createActivityOverlayCommandWithCommand:command view:theView];
}

- (id<Command>)createUpdateProfileImageCommandWithUser:(YAUser *)user 
                                      profileImageData:(NSData *)theProfileImageData 
                                              delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate
{
    id<ErrorHandler> specificErrorHandler = nil;
    id<CommandErrorHandler> commandErrorHandler = [[self profileCommandErrorHandlerCreator] createWithErrorHandler:specificErrorHandler];
    
    id<UserProfileImageUpdateParsedJSONResponseHandler> userProfileImageUpdateParsedJSONResponseHandler = 
    [[self userProfileImageUpdateParsedJSONResponseHandlerCreator] createWithUser:user profileImageData:theProfileImageData delegate:theDelegate];
    
    id<URLRequestBuilder> requestBuilder = [[self userProfileURLRequestBuilderCreator] createUserProfileURLRequestBuilderForUpdatingImageForUser:user];
  
    NSDictionary *requestData = [[self userProfileImageUpdateRequestDataBuilder] requestDataForProfileImageUpdateWithImageData:theProfileImageData];
    NSDictionary *requestParameters = [[self profileURLParametersCreator] urlParametersToUpdateImage];
     
    id<Command> updateProfileImageCommand = [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:requestBuilder
                                                                                         urlRequestParameters:requestParameters
                                                                                               urlRequestData:requestData
                                                                                                   jsonParser:jsonParser_
                                                                                    parsedJSONResponseHandler:userProfileImageUpdateParsedJSONResponseHandler
                                                                                          commandErrorHandler:commandErrorHandler];

    id<Command> fetchUserProfileCommand = [self createFetchUserProfileCommandWithUser:user];
    
    id<Command> compositeCommand = [[self compositeCommandInstanceFactory] createCompositeCommandWithCommands:[NSArray arrayWithObjects:updateProfileImageCommand, fetchUserProfileCommand, nil]];
    
    return compositeCommand;
}

@end

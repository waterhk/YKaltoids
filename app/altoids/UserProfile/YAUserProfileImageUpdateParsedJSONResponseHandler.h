//
//  YAUserProfileImageUpdateParsedJSONResponseHandler.h
//  altoids
//
//  Created by Anand Biligiri on 12/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagedObjectContextFactory.h"
#import "UserProfileHandler.h"
#import "UserProfileImageUpdateParsedJSONResponseHandler.h"
#import "UserProfileUpdateCommandDelegate.h"

@interface YAUserProfileImageUpdateParsedJSONResponseHandler : NSObject <UserProfileImageUpdateParsedJSONResponseHandler>

- (id)initWithManagedObjectContextFactory:(id<ManagedObjectContextFactory>)managedObjectContextFactory 
                             userObjectID:(NSManagedObjectID *)userObjectID
                       userProfileHandler:(id<UserProfileHandler>)userProfileHandler 
                         profileImageData:(NSData *)theProfileImageData 
                                 delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate;
@end

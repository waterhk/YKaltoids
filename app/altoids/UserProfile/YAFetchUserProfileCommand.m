//
//  YAFetchUserProfileCommand.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAFetchUserProfileCommand.h"
#import "YAFetchUserProfileResponse.h"
#import "YAUser.h"
#import "TransportFactory.h"
#import "UserProfileHandler.h"
#import "ManagedObjectContextFactory.h"
#import "UserProfileRequestBuilder.h"
#import "UserProfileResponseParser.h"
#import "ImageTransformer.h"
#import "YAPersonImage.h"
#import "PersonImageHandler.h"
#import "URLCreator.h"
#import "DataCreator.h"

@implementation YAFetchUserProfileCommand

@synthesize transportFactory = transportFactory_;
@synthesize userProfileHandler = userProfileHandler_;
@synthesize personImageHandler = personImageHandler_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize userProfileRequestBuilder = userProfileRequestBuilder_;
@synthesize userProfileResponseParser = userProfileResponseParser_;
@synthesize urlCreator = urlCreator_;
@synthesize dataCreator = dataCreator_;
@synthesize imageTransformer = imageTransformer_;
@synthesize userObjectID = userObjectID_;


- (id) initWithUser:(YAUser*)user
{
    self = [super init];
    if(self)
    {
        userObjectID_ = [user objectID];
    }
    return self;
}

- (NSError*)execute
{
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    YAUser *user = (YAUser *)[managedObjectContext objectWithID:[self userObjectID]];
    
    NSURLRequest *request = [[self userProfileRequestBuilder] buildFetchUserProfileRequestWithUser:user];
    
    NSError *error = nil;
    NSData *data = nil;
    id<HTTPURLResponse> urlResponse = nil;
    
    [[[self transportFactory] serverTransport] sendSynchronousRequest:request returningResponse:&urlResponse data:&data error:&error];
    
    YAFetchUserProfileResponse *parsedResponse = [[self userProfileResponseParser] parseFetchUserProfileResponse:data error:error];
    
    if ([parsedResponse error] || [[parsedResponse body] count] == 0) {
        return error;
    }
    
    NSString* photoURL = [[parsedResponse body] valueForKeyPath:@"profile.image.imageUrl"];
    
    if(![[self userProfileHandler] hasResidentPhotoWithURL:photoURL forUser:user])
    {
        YAPersonImage* personImage = [[self personImageHandler] createPersonImageEntityInManagedObjectContext:managedObjectContext];
        [personImage setPhotoURL:photoURL];
        
        NSURL* imageURL = [[self urlCreator] createWithString:photoURL];
        NSData* imageData = [[self dataCreator] createWithContentsOfURL:imageURL];  // synchronous download of image (this command is run on a background thread)

        UIImage *newProfileImage = [[self imageTransformer] imageWithData:imageData];
        NSData *newProfileImageData = [[self imageTransformer] dataWithImage:newProfileImage];
        
        [personImage setImageData:newProfileImageData];
        
        [[self userProfileHandler] setImage:personImage forUser:user];
    }
    
    NSString *firstName = [[parsedResponse body] valueForKeyPath:@"profile.givenName"];
    NSString *lastName = [[parsedResponse body] valueForKeyPath:@"profile.familyName"];
    NSString *guid = [[parsedResponse body] valueForKeyPath:@"profile.guid"];
    
    [[self userProfileHandler] setFirstName:firstName forUser:user];    
    [[self userProfileHandler] setLastName:lastName forUser:user];
    [[self userProfileHandler] setPhotoUrl:photoURL forUser:user];
    [[self userProfileHandler] setGuid:guid forUser:user];

    error = nil;
    
    [[self userProfileHandler] save:user inManagedObjectContext:managedObjectContext error:&error];
    
    return error;
}


@end

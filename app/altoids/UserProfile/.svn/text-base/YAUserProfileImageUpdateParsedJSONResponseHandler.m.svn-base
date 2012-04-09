//
//  YAUserProfileImageUpdateParsedJSONResponseHandler.m
//  altoids
//
//  Created by Anand Biligiri on 12/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileImageUpdateParsedJSONResponseHandler.h"
#undef kYALogComponent
#define kYALogComponent lcl_cProfileCommand

// Private class extension
@interface YAUserProfileImageUpdateParsedJSONResponseHandler ()

// @property definitions
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) NSManagedObjectID *userObjectID;
@property (strong, nonatomic) id<UserProfileHandler> userProfileHandler;
@property (strong, nonatomic) NSData *profileImageData;
@property (strong, nonatomic) id<UserProfileUpdateCommandDelegate> delegate;

// methods

@end

@implementation YAUserProfileImageUpdateParsedJSONResponseHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize userObjectID = userObjectID_;
@synthesize userProfileHandler = userProfileHandler_;
@synthesize profileImageData = profileImageData_;
@synthesize delegate = delegate_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithManagedObjectContextFactory:(id<ManagedObjectContextFactory>)managedObjectContextFactory 
                             userObjectID:(NSManagedObjectID *)userObjectID
                       userProfileHandler:(id<UserProfileHandler>)userProfileHandler 
                         profileImageData:(NSData *)theProfileImageData
                                 delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate
{
  self = [super init];
  if (self) {
      managedObjectContextFactory_ = managedObjectContextFactory;
      userObjectID_ = userObjectID;
      userProfileHandler_ = userProfileHandler;
      profileImageData_ = theProfileImageData;
      delegate_ = theDelegate;
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark UserProfileImageUpdateParsedJSONResponseHandler methods
//    {
//        "imageupload" : {
//            "imageId" : numeric,                  // image Id for the image just uploaded (-1 if tmpUpload param present)
//            "size":  WxH,                         // image size (-1x-1 if tmpUpload param present)
//            "width": numeric,                     // Width of the thumbnail image
//            "height": numeric,                    // Height of the thumbnail image
//            "imageUrl": "link",                   // Link to the ymdb image url (temporary url if tmpUpload param present)
//            "uri" : "link to GET imagepool/{id}"  // optional reference to the actual resource to get images for that image Id (the POST URI (/v1/user/{guid}/profile/imagepool) if tmpUpload param present)
//        }
//    }
- (void)handleParsedJSONResponse:(NSDictionary *)aParsedJSONResponse
{
    NSString *imageURLString = [aParsedJSONResponse valueForKeyPath:@"imageupload.imageUrl"];
    
    if ([imageURLString respondsToSelector:@selector(length)] && [imageURLString length]) 
    {
        [[self delegate] userProfileImageUpdatedForLocalUserWithObjectID:[self userObjectID] imageData:[self profileImageData]];
        
        return;
    }
    
    YALogWarning("Unable to find imageupload.imageUrl in response for image upload");
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAUserProfileImageUpdateParsedJSONResponseHandler ()

@end

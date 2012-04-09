//
//  YAUserProfileRepository.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileRepository.h"

#undef kYALogComponent
#define kYALogComponent lcl_cProfileRepository

// Private class extension
@interface YAUserProfileRepository ()

// @property definitions

// methods

@end

@implementation YAUserProfileRepository

#pragma mark -
#pragma mark @synthesize
@synthesize userProfileHandler=userProfileHandler_;
@synthesize personImageRepository=personImageRepository_;
@synthesize personImageHandler=personImageHandler_;
@synthesize imageTransformer=imageTransformer_;
@synthesize managedObjectContextFactory=managedObjectContextFactory_;
@synthesize userProfileCommandFactory=userProfileCommandFactory_;
@synthesize mmcCommandQueue=mmcCommandQueue_;
@synthesize profileErrorCreator = profileErrorCreator_;

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark UserProfileUpdateCommandDelegate delegate methods

- (void)userProfileNameAndPermissionUpdatedForLocalUserWithObjectID:(NSManagedObjectID *)theObjectID firstName:(NSString *)theFirstName lastName:(NSString *)theLastName
{
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    YAUser *user = (YAUser *)[managedObjectContext objectWithID:theObjectID];
    
    [[self userProfileHandler] setFirstName:theFirstName forUser:user];
    [[self userProfileHandler] setLastName:theLastName forUser:user];
    [[self userProfileHandler] setProfileUpdateStatus:YAProfileUpdateStatusPublic forUser:user];
    [[self userProfileHandler] setLastUpdatedDate:[NSDate date] forUser:user];
    
    NSError *error = nil;
    [[self userProfileHandler] save:user inManagedObjectContext:managedObjectContext error:&error];
    
    if (error) {
        YALogError(@"Error:\n%@\n",
                   [error localizedDescription]);
        
        return;
    }
}

- (void)userProfileImageUpdatedForLocalUserWithObjectID:(NSManagedObjectID *)theObjectID imageData:(NSData *)theImageData
{
    
    NSManagedObjectContext *context = [[self managedObjectContextFactory] create];
    YAUser *user = (YAUser *)[context objectWithID:theObjectID];
    
    [[self userProfileHandler] setImageData:theImageData forUser:user];
    [[self userProfileHandler] setImageUpdateStatus:YAImageUpdateStatusSuccess forUser:user];
    
    NSError *error = nil;
    [[self userProfileHandler] save:user inManagedObjectContext:context error:&error];
    
    if (error) 
    {
        YALogError(@"Unable to save user %@", [error localizedDescription]);
    }
}

// Public methods
#pragma mark -
#pragma mark Public methods
- (YAUser *)createUserWithUserInfo:(YAUserInfo *)aUserInfo error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    NSError *error = nil;
    NSManagedObjectContext * managedObjectContext = [[self managedObjectContextFactory] create];
    
    YAUser * user = [[self userProfileHandler] existingUserEntityInManagedObjectContext:managedObjectContext error:&error];
    
    if (!user) {
        user = [[self userProfileHandler] createUserEntityInManagedObjectContext:managedObjectContext];
        [[self userProfileHandler] setFirstName:[aUserInfo firstName] forUser:user];
        [[self userProfileHandler] setLastName:[aUserInfo lastName] forUser:user];
        [[self userProfileHandler] setPhotoUrl:[aUserInfo photoUrl] forUser:user];
        [[self userProfileHandler] setGuid:[aUserInfo guid] forUser:user];
        [[self userProfileHandler] setProfileUpdateStatus:YAProfileUpdateStatusPrivate forUser:user];
        [[self userProfileHandler] setImageUpdateStatus:YAImageUpdateStatusUnknown forUser:user];
        [[self userProfileHandler] setLastUpdatedDate:[aUserInfo lastUpdated] forUser:user];
        YAPersonImage *personImage = [[self personImageRepository] createPersonImageWithPhotoURL:nil imageData:nil inManagedObjectContext:managedObjectContext];
        [[self userProfileHandler] setImage:personImage forUser:user];

        BOOL didSaveUser;
        
        didSaveUser = [[self userProfileHandler] save:user inManagedObjectContext:managedObjectContext error:&error];
        
        if (!didSaveUser) 
        {
            *anError = [[self profileErrorCreator] errorWithCode:YAProfileErrorCodeFailedToSaveUserProfile underlyingError:error];
            
            return nil;
        }
    }
            
    return user;
}

- (YAUser *)fetchCurrentUserProfileWithError:(NSError **)anError
{
    return [[self userProfileHandler] existingUserEntityInManagedObjectContext:[[self managedObjectContextFactory] create] error:anError];
}

- (void)fetchUserProfileForUserAsync:(YAUser *)user
{
    id<Command> fetchUserProfileCommand = [[self userProfileCommandFactory] createFetchUserProfileCommandWithUser:user];
    
    [[self mmcCommandQueue] append:fetchUserProfileCommand];
}

- (BOOL)saveUser:(YAUser *)user error:(NSError **)anError 
{
    return [[self userProfileHandler] save:user error:anError];
}

- (void)updateUserProfileWithFirstName:(NSString *)newFirstName
                              lastName:(NSString *)newLastName 
                                 image:(UIImage *)newImage
                        viewForOverlay:(UIView *)theView
                               forUser:(YAUser *)user 
                                 error:(NSError **)anError 
                     
{   
    NSData *dataOfOriginalImage  = [[self userProfileHandler] dataOfImageForUser:user];
    NSData *dataOfNewImage = [[self imageTransformer] dataWithImage:newImage];
    
    id<Command> updateProfileImageCommand;
   
    if (![dataOfNewImage isEqualToData:dataOfOriginalImage]) 
    {
        
        updateProfileImageCommand = [[self userProfileCommandFactory] createUpdateProfileImageCommandWithUser:user 
                                                                                             profileImageData:dataOfNewImage 
                                                                                                     delegate:self];
    }
    
    id<Command> updateProfileCommand = [[self userProfileCommandFactory] createUpdateProfileNameWithPermissionCommandWithUser:user 
                                                                                                                    firstName:newFirstName 
                                                                                                                     lastName:newLastName
                                                                                                    updateProfileImageCommand:updateProfileImageCommand
                                                                                                               viewForOverlay:theView
                                                                                                                     delegate:self];
    
    [[self mmcCommandQueue] append:updateProfileCommand];
}

- (YAImageUpdateStatus)imageUpdateStatusForUser:(YAUser *)user
{
    return [[self userProfileHandler] imageUpdateStatusForUser:user];
}

- (YAProfileUpdateStatus)profileUpdateStatusForUser:(YAUser *)user
{
    return [[self userProfileHandler] profileUpdateStatusForUser:user];
}

- (void)setImageUpdateStatus:(YAImageUpdateStatus)theImageUpdateStatus forUser:(YAUser *)aUser
{
    [[self userProfileHandler] setImageUpdateStatus:theImageUpdateStatus forUser:aUser];
}

- (void)setProfileUpdateStatus:(YAProfileUpdateStatus)theProfileUpdateStatus forUser:(YAUser *)aUser
{
    [[self userProfileHandler] setProfileUpdateStatus:theProfileUpdateStatus forUser:aUser];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAUserProfileRepository ()

@end

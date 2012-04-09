
//
//  YAUserProfileHandler.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileHandler.h"
#import <CoreData/CoreData.h>
#import "YAUser.h"
#import "YAPersonImage.h"

// Private class extension
@interface YAUserProfileHandler ()

// @property definitions

// methods

@end

@implementation YAUserProfileHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

@synthesize fetchRequestCreator = fetchRequestCreator_;
@synthesize userEntityDescriptionCreator = userEntityDescriptionCreator_;
@synthesize profileErrorCreator = profileErrorCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods
- (YAUser *)createUserEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    YAUser *user = [NSEntityDescription insertNewObjectForEntityForName:USER_ENTITY_NAME inManagedObjectContext:aManagedObjectContext];
        
    return user;
}

- (YAUser *)existingUserEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    NSEntityDescription *entity = [[self userEntityDescriptionCreator] userEntityDescriptionInManagedObjectContext:aManagedObjectContext];
    NSFetchRequest *fetchRequest = [[self fetchRequestCreator] fetchRequestForEntity:entity];
    
    NSArray *users = [aManagedObjectContext executeFetchRequest:fetchRequest error:anError];

    if (!users) 
    {
        *anError = [[self profileErrorCreator] errorWithCode:YAProfileErrorCodeFailedToFetchUserProfileFromLocalStorage];
        
        return nil;
    }
    
    NSAssert([users count] <= 1, @"We should at most have a single user, but we found %d users",[users count]);
    
    if ([users count]==1) {
        return [users objectAtIndex:0];
    }
    
    return nil;
}

- (BOOL)save:(YAUser *)aUser inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError
{
//    id<UserValidator> validator = [[self userValidatorFactory] createValidatorForUser:aUser];
//    
//    if (validator && [validator userIsValid:aUser error:anError]) 
//    {
    return [aManagedObjectContext save:anError];
//    }
}

- (BOOL) save:(YAUser *)aUser error:(NSError *__autoreleasing *)anError  
{    
    return [self save:aUser inManagedObjectContext:[aUser managedObjectContext] error:anError];
}

- (NSString *)firstNameForUser:(YAUser *)aUser
{
    return [aUser firstName];
}

- (NSString *)lastNameForUser:(YAUser *)aUser
{
    return [aUser lastName];
}

- (NSString *)photoUrlForUser:(YAUser *)aUser
{
    return [aUser photoUrl];
}

- (NSString *)guidForUser:(YAUser *)aUser
{
    return [aUser guid];
}

- (YAProfileUpdateStatus)profileUpdateStatusForUser:(YAUser *)aUser
{
    return [[aUser profileUpdateStatus] intValue];
}

- (YAImageUpdateStatus)imageUpdateStatusForUser:(YAUser *)aUser
{
    return [[aUser imageUpdateStatus] intValue];
}

- (NSDate *)lastUpdatedDateForUser:(YAUser *)aUser
{
    return [aUser lastUpdated];
}

- (BOOL)hasResidentPhotoWithURL:(NSString*)photoURL forUser:(YAUser*)user
{
    YAPersonImage* image = [self imageForUser:user];
    if(![photoURL isEqual:[image photoURL]])
    {
        return NO;
    }
    
    return [[image imageData] length] > 0;
}

- (void)setFirstName:(NSString *)aFirstName forUser:(YAUser *)aUser
{
    [aUser setFirstName:aFirstName];
}

- (void)setLastName:(NSString *)aLastName forUser:(YAUser *)aUser
{
    [aUser setLastName:aLastName];
}

- (void)setPhotoUrl:(NSString *)aPhotoUrl forUser:(YAUser *)aUser
{
    [aUser setPhotoUrl:aPhotoUrl];
}

- (void)setGuid:(NSString *)theGuid forUser:(YAUser *)aUser
{
    [aUser setGuid:theGuid];
}

- (void)setProfileUpdateStatus:(YAProfileUpdateStatus)theProfileUpdateStatus forUser:(YAUser *)aUser
{
    [aUser setProfileUpdateStatus:[NSNumber numberWithInt:theProfileUpdateStatus]];
}

- (void)setImageUpdateStatus:(YAImageUpdateStatus)theImageUpdateStatus forUser:(YAUser *)aUser
{
    [aUser setImageUpdateStatus:[NSNumber numberWithInt:theImageUpdateStatus]];
}

- (void)setLastUpdatedDate:(NSDate *)updatedDate forUser:(YAUser *)aUser
{
    [aUser setLastUpdated:updatedDate];
}

- (void)setImage:(YAPersonImage *)aPersonImage forUser:(YAUser *)aUser
{
    [aUser setImage:aPersonImage];
}

- (YAPersonImage *)imageForUser:(YAUser *)aUser
{
    return [aUser image];
}

- (NSManagedObjectID *)userObjectIDForUser:(YAUser *)theUser
{
    return [theUser objectID];
}

- (NSData *) dataOfImageForUser:(YAUser *) user 
{
    YAPersonImage *personImage = [user image];
    NSData *data  = [personImage imageData];
    return data;
}

- (void)setImageData:(NSData *)theImageData forUser:(YAUser *)theUser
{
    [[theUser image] setImageData:theImageData];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAUserProfileHandler ()

@end

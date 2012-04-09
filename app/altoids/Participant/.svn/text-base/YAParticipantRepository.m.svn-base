//
//  YAParticipantRepository.m
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "ParticipantImageLoaderCommand.h"
#import "ParticipantImageLoaderCommandDelegate.h"
#import "ParticipantRepositoryImageDelegate.h"
#import "YAParticipantRepository.h"
#import "ParticipantHandler.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"
#import "YAAddress.h"
#import "YAValidateParticipantsCommand.h"

// Private class extension
@interface YAParticipantRepository () <ParticipantImageLoaderCommandDelegate>

// @property definitions

// methods

@end

@implementation YAParticipantRepository

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize addressRepository = addressRepository_;
@synthesize imageScaler = imageScaler_; 
@synthesize participantHandler = participantHandler_;
@synthesize participantCommandFactory = participantCommandFactory_;
@synthesize mmcCommandQueue = mmcCommandQueue_;
@synthesize participantImageLoaderCommandInstanceFactory = participantImageLoaderCommandInstanceFactory_;
@synthesize imageTransformer = imageTransformer_;
@synthesize personImageRepository = personImageRepository_;
@synthesize personImageHandler = personImageHandler_;
@synthesize participantErrorCreator = participantErrorCreator_;
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;
@synthesize mutableSetCreator = mutableSetCreator_;
@synthesize participantUpdater = participantUpdater_;
@synthesize participantCreator = participantCreator_;
@synthesize userProfileRepository = userProfileRepository_;
@synthesize userProfileHandler = userProfileHandler_;

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
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

-(YAParticipant *)createParticipantFromParticipantInfo:(YAParticipantInfo *)aParticipantInfo inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError
{
    NSParameterAssert(aParticipantInfo);
    NSParameterAssert(aManagedObjectContext);
    NSParameterAssert(anError);
    
    return [[self participantCreator] participantFromParticipantInfo:aParticipantInfo inManagedObjectContext:aManagedObjectContext error:anError];
}

- (NSSet *)createParticipantsFromArrayOfParticipantInfo:(NSArray *)anArrayOfParticipantInfo inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError
{
    NSParameterAssert(anArrayOfParticipantInfo);
    NSParameterAssert(aManagedObjectContext);
    NSParameterAssert(anError);
    
    NSMutableSet *participantEntities = [[self mutableSetCreator] mutableSetWithCapacity:[anArrayOfParticipantInfo count]];
    YAParticipant *participant = nil;
    
    for (YAParticipantInfo *participantInfo in anArrayOfParticipantInfo) 
    {
        participant = [[self participantCreator] participantFromParticipantInfo:participantInfo inManagedObjectContext:aManagedObjectContext error:anError];
        
        if (!participant) 
        {
            return nil;
        }
        
        [participantEntities addObject:participant];
    }
    
    return participantEntities;
}

- (NSSet *)mergeParticipants:(NSArray *)anArrayOfParticipantInfo withExistingParticipants:(NSSet *)theExistingParticipants usingParticipantIDMap:(NSDictionary *)theParticipantIDMap inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext error:(NSError **)anError
{
    NSParameterAssert(theManagedObjectContext);
    NSParameterAssert(anError);
    
    NSUInteger numberOfParticipants = [anArrayOfParticipantInfo count];
    NSMutableDictionary *participantInfosByParticipantID = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:numberOfParticipants];
    NSMutableSet *mergedParticipants = [[self mutableSetCreator] mutableSetWithCapacity:numberOfParticipants];
    NSString *participantID = nil;
    NSString *updatedParticipantID = nil;
    YAParticipant *participant = nil;
    
    for (YAParticipantInfo *participantInfo in anArrayOfParticipantInfo) 
    {
        [participantInfosByParticipantID setObject:participantInfo forKey:[participantInfo participantID]];
    }
    
    for (YAParticipant *existingParticipant in theExistingParticipants) 
    {
        participantID = [[self participantHandler] participantIDForParticipant:existingParticipant];
        
        if (!(participant = [theParticipantIDMap objectForKey:participantID])) 
        {
            continue;
        }
        
        if (!(updatedParticipantID = [[self participantHandler] participantIDForParticipant:participant]))
        {
            continue;
        }
                
        //todo: other fields from the server we wish to respect over local data
        [[self participantHandler] setParticipantID:[[self participantHandler] participantIDForParticipant:participant] forParticipant:existingParticipant];
        [[self participantHandler] setTimestamp:[[self participantHandler] timestampForParticipant:participant] forParticipant:existingParticipant];
        [[self participantHandler] setIsUser:[[self participantHandler] participantIsUser:participant] forParticipant:existingParticipant];
        
        [mergedParticipants addObject:existingParticipant];
        [participantInfosByParticipantID removeObjectForKey:updatedParticipantID];
    }
    
    for (YAParticipantInfo *unmappedParticipant in [participantInfosByParticipantID allValues]) 
    {
        participant = [[self participantCreator] participantFromParticipantInfo:unmappedParticipant inManagedObjectContext:theManagedObjectContext error:anError];
        
        if (!participant) 
        {
            return nil;
        }
        
        [mergedParticipants addObject:participant];
    }
    
    return mergedParticipants;
}

- (void)validateParticipants:(NSArray *)participants
{
    NSParameterAssert(participants);
    
    YAValidateParticipantsCommand *command = [[self participantCommandFactory] createValidateParticipantsCommandWithParticipants:participants];
    [[self mmcCommandQueue] append:command];
}

- (void)saveParticipant:(YAParticipant *)theParticipant inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    [[self participantHandler] saveParticipant:theParticipant inManagedObjectContext:theManagedObjectContext];
}

- (void)retrieveImageForParticipant:(YAParticipant *)theParticipant
{
    NSError *error;
    NSString *photoURL = [[self participantHandler] photoURLForParticipant:theParticipant];
 
    if (!photoURL) {
        return;
    }
    
    YAPersonImage *personImage = [[self participantHandler] personImageForParticipant:theParticipant];
    
    
    /* check if there exists a corresponding image entity */
    if (personImage)
        return; /* nothing to be done */
    
    /* check if a request was scheduled for the image with same URL */
    personImage = [[self personImageRepository] personImageForPhotoURL:photoURL
                                                inManagedObjectContext:[theParticipant managedObjectContext] 
                                                                 error:&error];
    
    if (personImage) {
        /* insert a reference to the current participant for image data with same URL */
        [[self participantHandler] setPersonImage:personImage forParticipant:theParticipant];
        [[self participantHandler] saveParticipant:theParticipant inManagedObjectContext:[theParticipant managedObjectContext]];
        return;
    }
    else
    {
        // todo: log error during pass at logging
    }

    /* create a new entity to store URL and image
     fetch the image data from the server */
    personImage = [[self personImageRepository] createPersonImageWithPhotoURL:photoURL imageData:nil
                                                       inManagedObjectContext:[theParticipant managedObjectContext]];
    

    [[self participantHandler] setPersonImage:personImage forParticipant:theParticipant];    
    [[self participantHandler] saveParticipant:theParticipant inManagedObjectContext:[theParticipant managedObjectContext]];
    
    id<Command> participantImageLoaderCommand = [participantImageLoaderCommandInstanceFactory_ createParticipantImageLoaderCommandWithParticipant:theParticipant callbackData:nil delegate:self];
        
    [[self mmcCommandQueue] append:participantImageLoaderCommand];
}

- (UIImage *)imageForParticipant:(YAParticipant *)participant
{
    BOOL participantIsUser;
    NSError *error;
    YAPersonImage *personImage;
    YAUser *currentUser;
    
    participantIsUser = [[self participantHandler] participantIsUser:participant];
    
    if (participantIsUser) 
    {
        currentUser = [[self userProfileRepository] fetchCurrentUserProfileWithError:&error];
        
        if (currentUser) 
        {
            personImage = [[self userProfileHandler] imageForUser:currentUser];
        }
    }
    
    if(!personImage)
    {
        personImage = [[self participantHandler] personImageForParticipant:participant];
    }
    
    if (!personImage) {
        personImage = [[self personImageRepository] personImageForPhotoURL:[[self participantHandler] photoURLForParticipant:participant]
                                                    inManagedObjectContext:[participant managedObjectContext] 
                                                                     error:&error];
    }
    
    if (personImage) {
        [[self participantHandler] setPersonImage:personImage forParticipant:participant];
        return [[self imageTransformer] imageWithData:[[self personImageHandler] imageDataForPersonImage:personImage]];
    }
    else
    {
        // todo: log error during pass at logging
    }
    
    return nil;
}

- (void)imageData:(NSData *)theParticipantImageData forParticipant:(YAParticipant *)theParticipant withCallbackData:(id)theCallbackData
{
    UIImage *theParticipantImage = [[self imageTransformer] imageWithData:theParticipantImageData]; 
    UIImage *scaledImage = [[self imageScaler] scaleImage:theParticipantImage toSize:CGSizeMake(32, 32)];
    NSData *scaledImageData = [[self imageTransformer] dataWithImage:scaledImage];

    YAPersonImage *personImage = [[self participantHandler] personImageForParticipant:theParticipant];
    [[self personImageHandler] setImageData:scaledImageData forPersonImage:personImage];
    
    //probably need to inject the managedObjectContext factory
    [[self participantHandler] saveParticipant:theParticipant inManagedObjectContext:[theParticipant managedObjectContext]];
}
// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAParticipantRepository ()
@end

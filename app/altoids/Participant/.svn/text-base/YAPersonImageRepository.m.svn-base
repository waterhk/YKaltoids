//
//  YAPersonImageRepository.m
//  altoids
//
//  Created by Anand Biligiri on 11/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAPersonImageRepository.h"
#import "YAPersonImage.h"

// Private class extension
@interface YAPersonImageRepository ()

// @property definitions

// methods

@end

@implementation YAPersonImageRepository

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize personImageHandler = personImageHandler_;
@synthesize fetchRequestCreator = fetchRequestCreator_;
@synthesize personImagePredicateCreator = personImagePredicateCreator_;
@synthesize participantErrorCreator = participantErrorCreator_;

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
#pragma mark PersonImageRepository methods
- (YAPersonImage *)personImageForPhotoURL:(NSString *)photoURL inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    if (!photoURL) 
    {
        return nil;
    }
    
    NSFetchRequest *fetchRequest = [[self fetchRequestCreator] fetchRequestForEntity:[NSEntityDescription entityForName:@"PersonImage"
                                                                                                 inManagedObjectContext:managedObjectContext]
                                                                       withPredicate:[[self personImagePredicateCreator] photoURLPredicateMatchingURL:photoURL]];
    
    NSError *error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (!results) 
    {
        *anError = [[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToRetrieveImageForParticipant underlyingError:error];
        
        return nil;
    }
    
    if ([results count])
        return [results objectAtIndex:0];
    
    return nil;
}

- (YAPersonImage *)createPersonImageWithPhotoURL:(NSString *)photoURL imageData:(NSData *)imageData
                                    inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    YAPersonImage *personImage = [[self personImageHandler] createPersonImageEntityInManagedObjectContext:managedObjectContext];
    [[self personImageHandler] setPhotoURL:photoURL forPersonImage:personImage];
    [[self personImageHandler] setImageData:imageData forPersonImage:personImage];
    
    return personImage;
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
#pragma mark YAParticipantImageRepository ()

@end

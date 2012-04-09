//
//  YAPersonImageHandler.m
//  altoids
//
//  Created by Anand Biligiri on 11/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAPersonImageHandler.h"

#define PERSON_IMAGE_ENTITY_NAME @"PersonImage"
// Private class extension
@interface YAPersonImageHandler ()

// @property definitions

// methods

@end

@implementation YAPersonImageHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
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
#pragma mark PersonImageHandler methods
- (YAPersonImage *)createPersonImageEntityInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    YAPersonImage *personImage = [NSEntityDescription insertNewObjectForEntityForName:PERSON_IMAGE_ENTITY_NAME inManagedObjectContext:managedObjectContext];

    return personImage;
}

- (NSData *)imageDataForPersonImage:(YAPersonImage *)personImage
{
    return [personImage imageData];
}

- (NSString *)photoURLForPersonImage:(YAPersonImage *)personImage
{
    return [personImage photoURL];
}

- (void)setPhotoURL:(NSString *)photoURL forPersonImage:(YAPersonImage *)personImage
{
    [personImage setPhotoURL:photoURL];
}

- (void)setImageData:(NSData *)imageData forPersonImage:(YAPersonImage *)personImage
{
    [personImage setImageData:imageData];
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
#pragma mark YAPersonImageHandler ()

@end

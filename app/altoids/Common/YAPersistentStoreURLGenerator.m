//
//  YAPersistentStoreURLGenerator.m
//  altoids
//
//  Created by Anand Biligiri on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAPersistentStoreURLGenerator.h"

// Private class extension
@interface YAPersistentStoreURLGenerator ()

// @property definitions

// methods
#define kSQLiteFileName @"altoids.sqlite"
@end

@implementation YAPersistentStoreURLGenerator

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
#pragma mark PersistentStoreURLGenerator methods
- (NSURL *)persistentStoreURLForStoreType:(NSString *)aStoreType
{
    NSURL *applicationDocumentsDirectoryURL = nil;
    NSURL *persistentStoreURL = nil;
    
    if ([aStoreType isEqualToString:NSSQLiteStoreType]) 
    {
        applicationDocumentsDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        persistentStoreURL = [applicationDocumentsDirectoryURL URLByAppendingPathComponent:kSQLiteFileName];
    }
    
    return persistentStoreURL;
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
#pragma mark YAPersistentStoreURLGenerator ()

@end

//
//  YAUserProfileUpdateNameWithPermissionURLWithURLParametersBuilder.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileUpdateNameWithPermissionURLWithURLParametersBuilder.h"

// Private class extension
@interface YAUserProfileUpdateNameWithPermissionURLWithURLParametersBuilder ()

// @property definitions
@property (strong, nonatomic) id<ProfileURLCreator> profileURLCreator;
@property (strong, nonatomic) id<ProfileRelativeURICreator> profileRelativeURICreator;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) NSManagedObjectID *userObjectID;

// methods

@end

@implementation YAUserProfileUpdateNameWithPermissionURLWithURLParametersBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize profileURLCreator = profileURLCreator_;
@synthesize profileRelativeURICreator = profileRelativeURICreator_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize userObjectID = userObjectID_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithProfileURLCreator:(id<ProfileURLCreator>)theProfileURLCreator 
      profileRelativeURICreator:(id<ProfileRelativeURICreator>)theProfileRelativeURICreator
    managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory
                           user:(YAUser *)theUser;
{
  self = [super init];
  if (self) {
      profileURLCreator_ = theProfileURLCreator;
      profileRelativeURICreator_ = theProfileRelativeURICreator;
      managedObjectContextFactory_ = theManagedObjectContextFactory;
      userObjectID_ = [theUser objectID];
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
#pragma mark UserProfileUpdateNameWithPermissionURLWithURLParametersBuilder delegate methods

- (NSMutableURLRequest *)buildRequestURLWithURLParameters:(NSDictionary *)aURLParameters
{
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    YAUser *user = (YAUser *)[managedObjectContext objectWithID:[self userObjectID]];
    return [NSMutableURLRequest requestWithURL:[[self profileURLCreator] 
                                                    createProfileURLWithRelativeURI:[[self profileRelativeURICreator] createRelativeURIToUpdateProfileNameWithPermissionForUser:user] 
                                                                             params:aURLParameters]];
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
#pragma mark YAUserProfileUpdateNameWithPermissionURLWithURLParametersBuilder ()

@end

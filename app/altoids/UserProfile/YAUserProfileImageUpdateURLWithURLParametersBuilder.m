//
//  YAUserProfileImageUpdateURLWithURLParametersBuilder.m
//  altoids
//
//  Created by Anand Subba Rao on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileImageUpdateURLWithURLParametersBuilder.h"

// Private class extension
@interface YAUserProfileImageUpdateURLWithURLParametersBuilder ()

// @property definitions
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<ProfileURLCreator> profileURLCreator;
@property (strong, nonatomic) id<ProfileRelativeURICreator> profileRelativeURLCreator;
@property (strong, nonatomic) NSManagedObjectID *userObjectID;

// methods

@end

@implementation YAUserProfileImageUpdateURLWithURLParametersBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize profileURLCreator = profileURLCreator_;
@synthesize profileRelativeURLCreator = profileRelativeURLCreator_;
@synthesize userObjectID = userObjectID_;


// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithProfileURLCreator:(id<ProfileURLCreator>)theProfileURLCreator profileRelativeURICreator:(id<ProfileRelativeURICreator>)theProfileRelativeURICreator
                   userObjectID:(NSManagedObjectID *)userObjectID managedObjectContextFactory:(id<ManagedObjectContextFactory>)managedObjectContextFactory;

{
  self = [super init];
  if (self) {
      managedObjectContextFactory_ = managedObjectContextFactory;
      profileURLCreator_ = theProfileURLCreator;
      profileRelativeURLCreator_ = theProfileRelativeURICreator;
      userObjectID_ = userObjectID;
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
#pragma mark UserProfileImageUpdateURLWithURLParametersBuilder methods
- (NSMutableURLRequest *)buildRequestURLWithURLParameters:(NSDictionary *)aURLParameters
{
    NSManagedObjectContext *context = [[self managedObjectContextFactory] create];
    YAUser *user = (YAUser *)[context objectWithID:[self userObjectID]];
    
    NSString *relativeURI = [[self profileRelativeURLCreator] createRelativeURIToUpdateProfileImageForUser:user];
    NSURL *imageUpdateURL = [[self profileURLCreator] createProfileURLWithRelativeURI:relativeURI params:aURLParameters];
    return [NSMutableURLRequest requestWithURL:imageUpdateURL];
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
#pragma mark YAUserProfileImageUpdateURLWithURLParametersBuilder ()

@end

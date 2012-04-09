//
//  YAConversationMessageListURLWithURLParametersBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListURLWithURLParametersBuilder.h"

// Private class extension
@interface YAConversationMessageListURLWithURLParametersBuilder ()

// @property definitions
@property (strong, nonatomic) id<MMCURLCreator> mmcURLCreator;
@property (strong, nonatomic) id<MMCRelativeURICreator> mmcRelativeURICreator;
@property (strong, nonatomic) NSManagedObjectID *conversationObjectID;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;

// methods

@end

@implementation YAConversationMessageListURLWithURLParametersBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mmcURLCreator = mmcURLCreator_;
@synthesize mmcRelativeURICreator = mmcRelativeURICreator_;
@synthesize conversationObjectID = conversationObjectID_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithMMCURLCreator:(id<MMCURLCreator>)theMMCURLCreator 
      mmcRelativeURICreator:(id<MMCRelativeURICreator>)theMMCRelativeURICreator 
               conversation:(YAConversation *)theConversation
managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory
{
  self = [super init];
    
  if (self) 
  {
      mmcURLCreator_ = theMMCURLCreator;
      mmcRelativeURICreator_ = theMMCRelativeURICreator;
      conversationObjectID_ = [theConversation objectID];
      managedObjectContextFactory_ = theManagedObjectContextFactory;
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
#pragma mark URLRequestURLWithURLParametersBuilder delegate methods

- (NSMutableURLRequest *)buildRequestURLWithURLParameters:(NSDictionary *)aURLParameters
{
    NSManagedObjectContext *context = [[self managedObjectContextFactory] create];
    YAConversation *conversation = (YAConversation *)[context objectWithID:[self conversationObjectID]];
    return [NSMutableURLRequest requestWithURL:[[self mmcURLCreator] createMMCURLWithRelativeURI:[[self mmcRelativeURICreator] createRelativeURIToRetrieveMessagesInConversation:conversation] params:aURLParameters]];
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
#pragma mark YAConversationMessageListURLWithURLParametersBuilder ()

@end

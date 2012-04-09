//
//  YAConversationHandlerIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 8/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversation.h"
#import "YAConversationHandlerIntegrationTests.h"
#import "YAManagedObjectContextFactory.h"
#import "YAParticipantInfo.h"

@interface YAConversationHandlerIntegrationTests()

@property (strong, nonatomic) YAConversationHandler *conversationHandler;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (YAConversation *)createConversationEntityInManagedObjectContext;

@end

@implementation YAConversationHandlerIntegrationTests

@synthesize conversationHandler = conversationHandler_;
@synthesize managedObjectContext = managedObjectContext_;

- (void)setUp
{
    YAManagedObjectContextFactory *mocFactory = [[YAManagedObjectContextFactory alloc] init];
    [mocFactory setPersistentStoreType:NSInMemoryStoreType];
    [mocFactory setBundleContainingManagedObjectModel:[NSBundle bundleForClass:[self class]]];
    [mocFactory setPersistentStoreURLGenerator:nil];
    
    [self setConversationHandler:[[YAConversationHandler alloc] init]];
    [self setManagedObjectContext:[mocFactory create]];
}

- (void)testCreateConversationEntityReturnsNonNilEntity
{
    STAssertNotNil([self createConversationEntityInManagedObjectContext], @"Unexpected nil conversation entity");
}

- (void)testSetStatusSelectorsSetAppropriateStatus
{
    YAConversation *conversation = [self createConversationEntityInManagedObjectContext];
    
    [[self conversationHandler] setStatusAsNewForConversation:conversation];
    STAssertTrue([[conversation status] intValue] == YAConversationStatusNew, @"Unexpected conversation status");
    
    [[self conversationHandler] setStatusAsDraftForConversation:conversation];
    STAssertTrue([[conversation status] intValue] == YAConversationStatusDraft, @"Unexpected conversation status");
    
    [[self conversationHandler] setStatusAsPendingForConversation:conversation];
    STAssertTrue([[conversation status] intValue] == YAConversationStatusPending, @"Unexpected conversation status");
    
    [[self conversationHandler] setStatusAsPendingWithErrorsForConversation:conversation];
    STAssertTrue([[conversation status] intValue] == YAConversationStatusPendingWithErrors, @"Unexpected conversation status");
    
    [[self conversationHandler] setStatusAsSavedForConversation:conversation];
    STAssertTrue([[conversation status] intValue] == YAConversationStatusSaved, @"Unexpected conversation status");
    
    [[self conversationHandler] setStatusAsGapPlaceholderForConversation:conversation];
    STAssertTrue([[conversation status] intValue] == YAConversationStatusGapPlaceholder, @"Unexpected conversation status");
    
    STAssertTrue([[self conversationHandler] conversationIsGapPlaceholder:conversation], @"Expected conversation to be gap placeholder");
    
    [[self conversationHandler] setStatus:6789 forConversation:conversation];
    STAssertTrue([[conversation status] intValue] == 6789, @"Unexpected conversation status");
}

- (YAConversation *)createConversationEntityInManagedObjectContext
{
    return [[self conversationHandler] createConversationEntityInManagedObjectContext:[self managedObjectContext]];
}

@end

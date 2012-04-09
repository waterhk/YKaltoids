//
//  YAConversationFlagMessagesAsReadErrorHandler.m
//  altoids
//
//  Created by Anand Biligiri on 12/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationFlagMessagesAsReadErrorHandler.h"

#undef kYALogComponent
#define kYALogComponent lcl_cMessageCommand
// Private class extension
@interface YAConversationFlagMessagesAsReadErrorHandler ()

// @property definitions
@property (strong, nonatomic) id<MessageLocator> messageLocator;
@property (strong, nonatomic) id<MessageHandler> messageHandler;
@property (strong, nonatomic) NSArray *messageIDs;
// methods
- (void)markMessagesAsUnread:(NSArray *)messageIDs;
@end

@implementation YAConversationFlagMessagesAsReadErrorHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize messageLocator = messageLocator_;
@synthesize messageHandler = messageHandler_;
@synthesize messageIDs = messageIDs_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer
- (id)initWithManagedObjectContextFactory:(id<ManagedObjectContextFactory>)managedObjectContextFactory messageLocator:(id<MessageLocator>)messageLocator
                           messageHandler:(id<MessageHandler>)messageHandler messageIDs:(NSArray *)messageIDs
{
    self = [super initWithManagedObjectContextFactory:managedObjectContextFactory];
    
    if (self) {
        messageLocator_ = messageLocator;
        messageHandler_ = messageHandler;
        messageIDs_ = messageIDs;
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
#pragma mark ErrorHandler methods
- (void)handleError:(NSError *)theError
{
    BOOL foundMessageIDsInError = NO;
    do {
        NSDictionary *errorDetails = [[theError userInfo] valueForKey:kMMCErrorDetailKey];
        if (errorDetails) {
            NSArray *mids = [errorDetails valueForKey:@"mids"];
            if (mids) {
                [self markMessagesAsUnread:mids];
                foundMessageIDsInError = YES;
                break;
            }
        }
        
        theError = [[theError userInfo] valueForKey:NSUnderlyingErrorKey];
    } while (theError);
    
    if (!foundMessageIDsInError) {
        [self markMessagesAsUnread:[self messageIDs]];   
    }
}

- (void)markMessagesAsUnread:(NSArray *)messageIDs
{
    NSArray *messages = [[self messageLocator] messagesMatchingIDs:messageIDs inManagedObjectContext:[self managedObjectContext]];
    
    [messages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[self messageHandler] setRead:NO forMessage:obj];
    }];
    
    NSError *error = nil;
    [[self managedObjectContext] save:&error];
    
    if (error) {
        YALogError(@"Unable to save after marking messages as unread");
    }
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
#pragma mark YAConversationFlagMessagesAsReadErrorHandler ()

@end

//
//  YAConversationValidatorsIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationValidatorsIntegrationTests.h"
#import "YAConversationDraftValidator.h"
#import "YAConversationPendingValidator.h"
#import "YAConversationSavedValidator.h"
#import "YAValidationErrorBuilder.h"

@interface YAConversationValidatorsIntegrationTests()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) YAConversationHandler *conversationHandler;
@property (strong, nonatomic) YAConversationValidatorFactory *conversationValidatorFactory;
@property (strong, nonatomic) YAConversation *conversationWithDraftStatus;
@property (strong, nonatomic) YAConversation *conversationWithNewStatus;
@property (strong, nonatomic) YAConversation *conversationWithPendingStatus;
@property (strong, nonatomic) YAConversation *conversationWithSavedStatus;

@end

@implementation YAConversationValidatorsIntegrationTests

@synthesize conversationHandler = conversationHandler_;
@synthesize conversationValidatorFactory = conversationValidatorFactory_;
@synthesize conversationWithDraftStatus = conversationWithDraftStatus_;
@synthesize conversationWithNewStatus = conversationWithNewStatus_;
@synthesize conversationWithPendingStatus = conversationWithPendingStatus_;
@synthesize conversationWithSavedStatus = conversationWithSavedStatus_;
@synthesize managedObjectContext = managedObjectContext_;

- (void)setUp
{
    YAManagedObjectContextFactory *managedObjectContextFactory;
    YAValidationErrorBuilder *validationErrorBuilder;
    
    
    managedObjectContextFactory = [[YAManagedObjectContextFactory alloc] init];
    [managedObjectContextFactory setPersistentStoreType:NSInMemoryStoreType];
    [managedObjectContextFactory setBundleContainingManagedObjectModel:[NSBundle bundleForClass:[self class]]];
    [managedObjectContextFactory setPersistentStoreURLGenerator:nil];
    
    validationErrorBuilder = [[YAValidationErrorBuilder alloc] init];
    
    [self setConversationValidatorFactory:[[YAConversationValidatorFactory alloc] init]];
    [[self conversationValidatorFactory] setValidationErrorBuilder:validationErrorBuilder];

    [self setConversationHandler:[[YAConversationHandler alloc] init]];
    [[self conversationHandler] setConversationValidatorFactory:[self conversationValidatorFactory]];

    [self setManagedObjectContext:[managedObjectContextFactory create]];
    
    [self setConversationWithDraftStatus:[[self conversationHandler] createConversationEntityInManagedObjectContext:[self managedObjectContext]]];
    [self setConversationWithNewStatus:[[self conversationHandler] createConversationEntityInManagedObjectContext:[self managedObjectContext]]];
    [self setConversationWithPendingStatus:[[self conversationHandler] createConversationEntityInManagedObjectContext:[self managedObjectContext]]];
    [self setConversationWithSavedStatus:[[self conversationHandler] createConversationEntityInManagedObjectContext:[self managedObjectContext]]];
    
    [[self conversationHandler] setStatusAsDraftForConversation:[self conversationWithDraftStatus]];
    [[self conversationHandler] setStatusAsNewForConversation:[self conversationWithNewStatus]];
    [[self conversationHandler] setStatusAsPendingForConversation:[self conversationWithPendingStatus]];
    [[self conversationHandler] setStatusAsSavedForConversation:[self conversationWithSavedStatus]];
}

- (void)testConversationValidatorFactoryReturnsNilIfConversationIsNil
{
    STAssertNil([[self conversationValidatorFactory] createValidatorForConversation:nil], @"Expected nil validator");
}

- (void)testConversationValidatorFactoryReturnsDraftValidatorIfConversationIsNew
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithDraftStatus]];
    
    STAssertNotNil(validator, @"Validator is nil");
    STAssertTrue([validator isKindOfClass:[YAConversationDraftValidator class]], @"Unexpected conversation validator");

}

- (void)testConversationValidatorFactoryReturnsDraftValidatorIfConversationIsDraft
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithDraftStatus]];
    
    STAssertNotNil(validator, @"Validator is nil");
    STAssertTrue([validator isKindOfClass:[YAConversationDraftValidator class]], @"Unexpected conversation validator");
}

- (void)testConversationValidatorFactoryReturnsPendingValidatorIfConversationIsPending
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithPendingStatus]];
    
    STAssertNotNil(validator, @"Validator is nil");
    STAssertTrue([validator isKindOfClass:[YAConversationPendingValidator class]], @"Unexpected conversation validator");
}

- (void)testConversationValidatorFactoryReturnsSavedValidatorIfConversationIsSaved
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithSavedStatus]];
    
    STAssertNotNil(validator, @"Validator is nil");
    STAssertTrue([validator isKindOfClass:[YAConversationSavedValidator class]], @"Unexpected conversation validator");
}

- (void)testConversationDraftValidationReturnsFalseAndPopulatesErrorObjectIfConversationIsNil
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithDraftStatus]];
    
    BOOL isValid = NO;
    NSError *error = nil;
    
    STAssertNotNil(validator, @"Validator is nil");
    
    isValid = [validator conversationIsValid:nil error:&error];
    
    STAssertTrue(isValid == NO, @"Nil conversation should not be valid");
    STAssertNotNil(error, @"Unexpected nil error");
    
    [self assertError:error hasExpectedCode:YAConversationValidationNilConversationErrorCode 
           andMessage:kConversationValidationNilConversationErrorMsg];
}

- (void)testConversationDraftValidationReturnsTrueAndIgnoresErrorObjectIfConversationIsNotNil
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithDraftStatus]];

    BOOL isValid = NO;
    NSError *error = nil;
    
    STAssertNotNil(validator, @"Validator is nil");
    
    isValid = [validator conversationIsValid:[self conversationWithNewStatus] error:&error];
    
    STAssertTrue(isValid == YES, @"Expected conversation to be valid");
    STAssertNil(error, @"Expected error to be nil");
}

- (void)testConversationPendingValidatorReturnsFalseAndPopulatesErrorObjectIfConversationIsNil
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithPendingStatus]];
    
    BOOL isValid = NO;
    NSError *error = nil;
    
    STAssertNotNil(validator, @"Validator is nil");
    
    isValid = [validator conversationIsValid:nil error:&error];
    
    STAssertTrue(isValid == NO, @"Nil conversation should not be valid");
    STAssertNotNil(error, @"Unexpected nil error");
    
    [self assertError:error hasExpectedCode:YAConversationValidationNilConversationErrorCode 
           andMessage:kConversationValidationNilConversationErrorMsg];

}

- (void)testConversationPendingValidatorReturnsFalseAndPopulatesErrorObjectIfConversationContextIsNil
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithPendingStatus]];
    
    BOOL isValid = NO;
    NSError *error = nil;
    
    STAssertNotNil(validator, @"Validator is nil");
    
    [self makeConversationValidForServerSave:[self conversationWithPendingStatus]];
    
    [[self conversationWithPendingStatus] setConversationContext:nil];
    
    isValid = [validator conversationIsValid:[self conversationWithPendingStatus] error:&error];
    
    STAssertTrue(isValid == NO, @"Nil conversation should not be valid");
    STAssertNotNil(error, @"Unexpected nil error");
    
    [self assertError:error hasExpectedCode:YAConversationValidationNilContextErrorCode
           andMessage:kConversationValidationNilContextErrorMsg];
}

- (void)testConversationPendingValidatorReturnsFalseAndPopulatesErrorObjectIfMessagesAreNil
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithPendingStatus]];
    
    BOOL isValid = NO;
    NSError *error = nil;
    
    STAssertNotNil(validator, @"Validator is nil");
    
    [self makeConversationValidForServerSave:[self conversationWithPendingStatus]];
    
    [[self conversationWithPendingStatus] setMessages:nil];
    
    isValid = [validator conversationIsValid:[self conversationWithPendingStatus] error:&error];
    
    STAssertTrue(isValid == NO, @"Nil conversation should not be valid");
    STAssertNotNil(error, @"Unexpected nil error");
    
    [self assertError:error hasExpectedCode:YAConversationValidationTooFewMessagesErrorCode
           andMessage:kConversationValidationTooFewMessagesErrorMsg];
}

- (void)testConversationPendingValidatorReturnsFalseAndPopulatesErrorObjectIfParticipantsAreNil
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithPendingStatus]];
    
    BOOL isValid = NO;
    NSError *error = nil;
    
    STAssertNotNil(validator, @"Validator is nil");
    
    [self makeConversationValidForServerSave:[self conversationWithPendingStatus]];
    
    [[self conversationWithPendingStatus] setParticipants:nil];
    
    isValid = [validator conversationIsValid:[self conversationWithPendingStatus] error:&error];
    
    STAssertTrue(isValid == NO, @"Nil conversation should not be valid");
    STAssertNotNil(error, @"Unexpected nil error");
    
    [self assertError:error hasExpectedCode:YAConversationValidationTooFewParticipantsErrorCode
           andMessage:kConversationValidationTooFewParticipantsErrorMsg];
}

- (void)testConversationPendingValidatorReturnsTrueAndIgnoresErrorObjectIfConversationHasSenderMessageParticipantAndContext
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithPendingStatus]];
    
    BOOL isValid = NO;
    NSError *error = nil;
    
    STAssertNotNil(validator, @"Validator is nil");
    
    [self makeConversationValidForServerSave:[self conversationWithPendingStatus]];
    
    isValid = [validator conversationIsValid:[self conversationWithPendingStatus] error:&error];
    
    STAssertTrue(isValid == YES, @"Expected conversation to be valid");
    STAssertNil(error, @"Expected nil error");
}

- (void)testConversationSavedValidatorReturnsFalseAndPopulatesErrorObjectIfConversationIsNil
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithSavedStatus]];
    
    BOOL isValid = NO;
    NSError *error = nil;
    
    STAssertNotNil(validator, @"Validator is nil");
    
    isValid = [validator conversationIsValid:nil error:&error];
    
    STAssertTrue(isValid == NO, @"Nil conversation should not be valid");
    STAssertNotNil(error, @"Unexpected nil error");
    
    [self assertError:error hasExpectedCode:YAConversationValidationNilConversationErrorCode 
           andMessage:kConversationValidationNilConversationErrorMsg];
    
}

- (void)testConversationSavedValidatorReturnsFalseAndPopulatesErrorObjectIfConversationIDIsNil
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:[self conversationWithSavedStatus]];
    
    BOOL isValid = NO;
    NSError *error = nil;
    
    STAssertNotNil(validator, @"Validator is nil");
    
    [self makeConversationValidForSavedStatus:[self conversationWithSavedStatus]];
    
    [[self conversationWithSavedStatus] setConversationID:nil];
    
    isValid = [validator conversationIsValid:[self conversationWithSavedStatus] error:&error];
    
    STAssertTrue(isValid == NO, @"Nil conversation should not be valid");
    STAssertNotNil(error, @"Unexpected nil error");
    
    [self assertError:error hasExpectedCode:YAConversationValidationInvalidConversationID
           andMessage:kConversationValidationInvalidConversationID];
}

- (void)assertError:(NSError *)anError hasExpectedCode:(NSUInteger)anErrorCode andMessage:(NSString *)aMessage
{
    NSDictionary *userInfo = nil;
    
    STAssertNotNil(anError, @"Unexpected nil error");
    STAssertTrue([[anError domain] isEqualToString:YAValidationErrorDomain], @"Unexpected error domain: %@", [anError domain]);
    STAssertTrue([anError code] == anErrorCode, @"Unexpected error code");
    
    userInfo = [anError userInfo];
    
    STAssertTrue([aMessage isEqualToString:[userInfo objectForKey:NSLocalizedDescriptionKey]], @"Unexpected error message");
}

- (void)makeConversationValidForServerSave:(YAConversation *)aConversation
{    
    YAMessage *message = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:[self managedObjectContext]];
    YAParticipant *sender = [NSEntityDescription insertNewObjectForEntityForName:@"Participant" inManagedObjectContext:[self managedObjectContext]];
    YAParticipant *participant = [NSEntityDescription insertNewObjectForEntityForName:@"Participant" inManagedObjectContext:[self managedObjectContext]]; 
    
    [aConversation addMessagesObject:message];
    [aConversation addParticipantsObject:participant];
    [aConversation setSender:sender];
}

- (void)makeConversationValidForSavedStatus:(YAConversation *)aConversation
{
    [aConversation setConversationID:@"someid"];
}

@end

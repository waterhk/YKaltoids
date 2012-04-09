//
//  YAConversationValidatorsIntegrationTests.h
//  altoids
//
//  Created by Jon Herron on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <CoreData/CoreData.h>
#import <SenTestingKit/SenTestingKit.h>
#import "ConversationStatus.h"
#import "YAConversationHandler.h"
#import "YAConversationValidatorFactory.h"
#import "YAManagedObjectContextFactory.h"

@interface YAConversationValidatorsIntegrationTests : SenTestCase

- (void)testConversationValidatorFactoryReturnsNilIfConversationIsNil;
- (void)testConversationValidatorFactoryReturnsDraftValidatorIfConversationIsNew;
- (void)testConversationValidatorFactoryReturnsDraftValidatorIfConversationIsDraft;
- (void)testConversationValidatorFactoryReturnsPendingValidatorIfConversationIsPending;
- (void)testConversationValidatorFactoryReturnsSavedValidatorIfConversationIsSaved;

- (void)testConversationDraftValidationReturnsFalseAndPopulatesErrorObjectIfConversationIsNil;
- (void)testConversationDraftValidationReturnsTrueAndIgnoresErrorObjectIfConversationIsNotNil;

- (void)testConversationPendingValidatorReturnsFalseAndPopulatesErrorObjectIfConversationIsNil;
- (void)testConversationPendingValidatorReturnsFalseAndPopulatesErrorObjectIfConversationContextIsNil;
- (void)testConversationPendingValidatorReturnsFalseAndPopulatesErrorObjectIfMessagesAreNil;
- (void)testConversationPendingValidatorReturnsFalseAndPopulatesErrorObjectIfParticipantsAreNil;
- (void)testConversationPendingValidatorReturnsTrueAndIgnoresErrorObjectIfConversationHasSenderMessageParticipantAndContext;

- (void)testConversationSavedValidatorReturnsFalseAndPopulatesErrorObjectIfConversationIsNil;
- (void)testConversationSavedValidatorReturnsFalseAndPopulatesErrorObjectIfConversationIDIsNil;

- (void)assertError:(NSError *)anError hasExpectedCode:(NSUInteger)anErrorCode andMessage:(NSString *)aMessage;
- (void)makeConversationValidForServerSave:(YAConversation *)aConversation;
- (void)makeConversationValidForSavedStatus:(YAConversation *)aConversation;

@end

//
//  YAConversationCommandFactoryTests.h
//  altoids
//
//  Created by Jon Herron on 10/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>

@interface YAConversationCommandFactoryTests : SenTestCase

- (void)testCanConstructCommandToCreateConversation;
- (void)testCanConstructCommandToRetrieveListOfMostRecentConversations;
- (void)testCanConstructCommandToRetrieveConversationsAfterAConversation;
- (void)testCanConstructCommandToRetrieveListOfMostrecentMessagesForAConversation;
- (void)testCanConstructCommandToRetrieveMessagesAfterAMessageForAConversation;
- (void)testCanConstructCommandToReplyToAConversationWithMessageBody;

@end

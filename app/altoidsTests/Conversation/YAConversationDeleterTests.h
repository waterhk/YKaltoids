//
//  YAConversationDeleterTests.h
//  altoids
//
//  Created by Jon Herron on 9/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>

@interface YAConversationDeleterTests : SenTestCase

- (void)testDeleteAllConversationsUsesFetchRequestForAllConversations;
- (void)testDeleteAllConversationsExecutesFetchRequestUsingGivenManagedObjectContext;
- (void)testDeleteAllConversationsReturnsIfFetchRequestFails;
- (void)testDeleteAllConversationsReturnsIfNoConversationsAreFetched;
- (void)testDeleteAllConversationsUsesConversationHandlerToDeleteEachFetchedConversation;
- (void)testDeleteAllConversationsIssuesSaveOnManagedObjectContext;

@end

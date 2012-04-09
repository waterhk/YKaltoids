//
//  YAConversationGapDetectorTests.h
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientConversationListGapHandling
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>

@interface YAConversationGapDetectorTests : SenTestCase

- (void)testIfNoMoreConversationsExistOnTheServerDetectorReturnsNilIndicatingNoGap;
- (void)testIfConversationListIsEmptyDetectorReturnsNilIndicatingNoGap;
- (void)testIfExistingConversationMatchesIDAndTimestampOfLastConversationFromServerDetectorReturnsNilIndicatingNoGap;

- (void)testIfLastConversationFromServerDoesNotExistLocallyDetectorReturnsLastConversationIndicatingGapPossibility;
- (void)testIfLastConversationFromServerExistsLocallyButTimestampsDifferDetectorReturnsLastConversationIndicatingGapPossibility;

@end

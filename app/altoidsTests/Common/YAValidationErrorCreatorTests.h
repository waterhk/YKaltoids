//
//  YAValidationErrorCreatorTests.h
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>

@interface YAValidationErrorCreatorTests : SenTestCase

- (void)testCreatesErrorWithinValidationErrorDomainAndGivenErrorCode;
- (void)testCreatesErrorWithCorrectLocalizedStringForErrorCode;
- (void)testCreatesErrorWithUnderlyingErrorIfPresent;
- (void)testReturnsErrorCreatedByErrorCreator;

@end

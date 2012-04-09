//
//  YASettingsErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YASettingsErrorCreator.h"

// Private class extension
@interface YASettingsErrorCreator ()

// @property definitions
@property (strong, nonatomic) id<ErrorCreator> errorCreator;

// methods
- (NSString *)localizedDescriptionForErrorCode:(YASettingsErrorCodes)theErrorCode;

@end

@implementation YASettingsErrorCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize errorCreator = errorCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithErrorCreator:(id<ErrorCreator>)theErrorCreator
{
    self = [super init];
    
  if (self) 
  {
      errorCreator_ = theErrorCreator;
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
#pragma mark SettingsErrorCreator delegate methods

- (NSError *)errorWithCode:(YASettingsErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YASettingsErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    NSString *localizedDescription = [self localizedDescriptionForErrorCode:theErrorCode];
    
    return [[self errorCreator] errorWithDomain:YASettingsErrorDomain code:theErrorCode localizedDescription:localizedDescription underlyingError:theUnderlyingError];
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
#pragma mark YASettingsErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YASettingsErrorCodes)theErrorCode
{
    switch (theErrorCode) 
    {
		case YASettingsErrorCodeFailedToFetchSettingsFromLocalStorage:
			return YASettingsErrorFailedToFetchSettingsFromLocalStorage;
		case YASettingsErrorCodeFailedToSaveSettingsLocally:
			return YASettingsErrorFailedToSaveSettingsLocally;
		case YASettingsErrorCodeFailedToReportAProblem:
			return YASettingsErrorFailedToReportAProblem;
		case YASettingsErrorCodeFailedToDetactivateApplication:
			return YASettingsErrorFailedToDetactivateApplication;
        default:
            return nil;
    }
}

@end

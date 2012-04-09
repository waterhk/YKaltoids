//
//  YARegistrationFetcher.m
//  altoids
//
//  Created by Anand Subba Rao on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationFetcher.h"

#undef kYALogComponent
#define kYALogComponent lcl_cRegistrationRepository

// Private class extension
@interface YARegistrationFetcher ()

// @property definitions

// methods

@end

@implementation YARegistrationFetcher

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize registrationErrorCreator = registrationErrorCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark RegistrationFetcher
- (YARegistrationInfo *)fetchRegistrationInfoInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"RegistrationInfo" inManagedObjectContext:managedObjectContext]];
    
    NSError *error = nil;
    NSArray *registrationInfos = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        YALogError(@"Unable to fetch RegistrationInfo : %@", [error localizedDescription]);
        *anError = [[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeFailedToFetchRegistrationInformationFromLocalStorage underlyingError:error];
        
        return nil;
    }
    
    if ([registrationInfos count]) {
        YALogTrace(@"Found %d RegistrationInfos", [registrationInfos count]);
        return [registrationInfos objectAtIndex:0];
    }

    return nil;
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
#pragma mark YARegistrationFetcher ()

@end

//
//  YARegistrationRepository.m
//  altoids
//
//  Created by Anand Subba Rao on 8/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationRepository.h"
#import "YARegistrationInfo.h"

#undef kYALogComponent
#define kYALogComponent lcl_cRegistrationRepository

@interface YARegistrationRepository ()

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation YARegistrationRepository

@synthesize mmcCommandQueue = mmcCommandQueue_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize registrationFetcher = registrationFetcher_;
@synthesize registrationErrorCreator = registrationErrorCreator_;
@synthesize registrationHandler = registrationHandler_;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize registrationInfoCommandCreator = registrationInfoCommandCreator_;

- (BOOL)registrationRequired
{
    YARegistrationInfo *regInfo = [self existingRegistrationInfo];
    
    return [[regInfo phoneNumber] length] == 0 || [[regInfo token] length] == 0;
}

- (YARegistrationInfo *)existingRegistrationInfo
{
    NSError *error;
    YALogInfo(@"Checking for existing registrationInfo");
    
    YARegistrationInfo *registrationInfo = [[self registrationFetcher] fetchRegistrationInfoInManagedObjectContext:[self managedObjectContext] error:&error];
    
    
    return registrationInfo;
}


- (YARegistrationInfo *)createRegistrationInfo
{
    YARegistrationInfo *registrationInfo = [self existingRegistrationInfo];
    
    if (registrationInfo) {
        YALogInfo(@"Found existing registration info: %@", registrationInfo);
        return registrationInfo;   
    }
    
    YALogInfo(@"Creating new RegistrationInfo");
    return [[self registrationHandler] createRegistrationInfoEntityInManagedObjectContext:[self managedObjectContext]];
}

- (void)setPhoneNumber:(NSString *)phoneNumber registrationInfo:(YARegistrationInfo *)registrationInfo
{
    [[self registrationHandler] setPhoneNumber:phoneNumber registrationInfo:registrationInfo];
}

- (void)setExpirationDate:(NSDate *)expirationDate registrationInfo:(YARegistrationInfo *)registrationInfo
{
    [[self registrationHandler] setExpirationDate:expirationDate registrationInfo:registrationInfo];
}

- (void)setProfileUpdated:(BOOL)profileUpdated registrationInfo:(YARegistrationInfo *)registrationInfo
{
    [[self registrationHandler] setProfileUpdated:profileUpdated registrationInfo:registrationInfo];
}

- (void)setToken:(NSString *)token registrationInfo:(YARegistrationInfo *)registrationInfo 
{
    [[self registrationHandler] setToken:token registrationInfo:registrationInfo];
}

- (BOOL)saveRegistration:(YARegistrationInfo *)registration error:(NSError **)anError
{
    NSParameterAssert(anError);
    
    BOOL didSave;
    NSError *error;
    
    didSave = [[registration managedObjectContext] save:&error];
    
    
    if (!didSave) 
    {
        YALogError(@"Unable to save registration info: %@", [error localizedDescription]);
        *anError = [[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeFailedToSaveRegistrationInformationLocally underlyingError:error];
    }
    
    YALogInfo(@"Saved registrationInfo");
    return didSave;
}

- (void)requestRegistrationInformationForAddress:(YAAddressInfo *)address delegate:(id<RegistrationInfoCommandDelegate>)delegate
{
    id<Command> command = [[self registrationInfoCommandCreator] createWithAddress:address delegate:delegate];
    
    [[self mmcCommandQueue] append:command];
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (!managedObjectContext_)
        managedObjectContext_ = [[self managedObjectContextFactory] create];
    
    return managedObjectContext_;
}

@end

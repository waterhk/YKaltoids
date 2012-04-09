//
//  YAUserProfileViewControllerTests.m
//  altoids
//
//  Created by Anand Biligiri on 12/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAUserProfileViewControllerTests.h"
#import "FetchRequestCreator.h"
#import "FetchedResultsControllerFactory.h"
#import "ManagedObjectContextFactory.h"
#import "RegistrationRepository.h"
#import "UIAlertViewFactory.h"
#import "UserProfileSortDescriptorCreator.h"
#import "YARegistrationInfo.h"
#import "YAUserProfileViewController.h"

@implementation YAUserProfileViewControllerTests

// All code under test must be linked into the Unit Test bundle
- (void)testProfileUpdateError
{
    id userProfileRepositoryMock = [OCMockObject mockForProtocol:@protocol(UserProfileRepository)];
    id fetchedResultsControllerFactoryMock = [OCMockObject mockForProtocol:@protocol(FetchedResultsControllerFactory)];
    id managedObjectContextFactoryMock = [OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)];
    id registrationRepositoryMock = [OCMockObject mockForProtocol:@protocol(RegistrationRepository)];
    id fetchRequestCreatorMock = [OCMockObject mockForProtocol:@protocol(FetchRequestCreator)];
    id userProfileSortDescriptorCreatorMock = [OCMockObject mockForProtocol:@protocol(UserProfileSortDescriptorCreator)];
    id uiAlertViewFactoryMock = [OCMockObject mockForProtocol:@protocol(UIAlertViewFactory)];
    id bundleMock = [OCMockObject mockForClass:[NSBundle class]];
    
    YAUserProfileViewController *profileVC = [[YAUserProfileViewController alloc] initWithUserProfileRepository:userProfileRepositoryMock
                                                                                fetchedResultsControllerFactory:fetchedResultsControllerFactoryMock
                                                                                    managedObjectContextFactory:managedObjectContextFactoryMock
                                                                                                        nibName:@"YAUserProfileViewController"
                                                                                                         bundle:bundleMock
                                                                                         registrationRepository:registrationRepositoryMock
                                                                                            fetchRequestCreator:fetchRequestCreatorMock
                                                                               userProfileSortDescriptorCreator:userProfileSortDescriptorCreatorMock
                                                                                               alertViewFactory:uiAlertViewFactoryMock];
    
    
    STAssertNotNil(profileVC, @"Expected profileVC to be non-nil");
    
    id partialMock = [OCMockObject partialMockForObject:profileVC];
    id userMock = [OCMockObject mockForClass:[YAUser class]];
    
    [[[partialMock stub] andReturn:userMock] currentUser];
    
    id tableViewCellMock = [OCMockObject mockForClass:[UITableViewCell class]];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:4];
        

    [[tableViewCellMock stub] setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    YAImageUpdateStatus imageUpdateStatus = YAImageUpdateStatusSuccess;
    [[[userProfileRepositoryMock expect] andReturnValue:OCMOCK_VALUE(imageUpdateStatus)] imageUpdateStatusForUser:userMock];
    
    YAProfileUpdateStatus profileUpdateStatus = YAProfileUpdateStatusError;
    [[[userProfileRepositoryMock expect] andReturnValue:OCMOCK_VALUE(profileUpdateStatus)] profileUpdateStatusForUser:userMock];
    
    id mockAlertView = [OCMockObject mockForClass:[UIAlertView class]];
    [[[uiAlertViewFactoryMock expect] andReturn:mockAlertView] createWithTitle:kErrorTitle message:kProfileInfoUpdateErrorMessage
                                                                      delegate:[OCMArg checkWithBlock:^BOOL(id obj) {
        return [obj conformsToProtocol:@protocol(UIAlertViewDelegate)];
    }]
                                                             cancelButtonTitle:kOkButtonText otherButtonTitles:nil];
    [[mockAlertView expect] setTag:kProfileInfoUpdateErrorViewTag];
    [[mockAlertView expect] show];

    [profileVC configureCell:tableViewCellMock atIndexPath:indexPath];
    
    [userProfileRepositoryMock verify];
    [uiAlertViewFactoryMock verify];
    [mockAlertView verify];
}

- (void)testImageUpdateError
{
    id userProfileRepositoryMock = [OCMockObject mockForProtocol:@protocol(UserProfileRepository)];
    id fetchedResultsControllerFactoryMock = [OCMockObject mockForProtocol:@protocol(FetchedResultsControllerFactory)];
    id managedObjectContextFactoryMock = [OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)];
    id registrationRepositoryMock = [OCMockObject mockForProtocol:@protocol(RegistrationRepository)];
    id fetchRequestCreatorMock = [OCMockObject mockForProtocol:@protocol(FetchRequestCreator)];
    id userProfileSortDescriptorCreatorMock = [OCMockObject mockForProtocol:@protocol(UserProfileSortDescriptorCreator)];
    id uiAlertViewFactoryMock = [OCMockObject mockForProtocol:@protocol(UIAlertViewFactory)];
    id bundleMock = [OCMockObject mockForClass:[NSBundle class]];
    
    YAUserProfileViewController *profileVC = [[YAUserProfileViewController alloc] initWithUserProfileRepository:userProfileRepositoryMock
                                                                                fetchedResultsControllerFactory:fetchedResultsControllerFactoryMock
                                                                                    managedObjectContextFactory:managedObjectContextFactoryMock
                                                                                                        nibName:@"YAUserProfileViewController"
                                                                                                         bundle:bundleMock
                                                                                         registrationRepository:registrationRepositoryMock
                                                                                            fetchRequestCreator:fetchRequestCreatorMock
                                                                               userProfileSortDescriptorCreator:userProfileSortDescriptorCreatorMock
                                                                                               alertViewFactory:uiAlertViewFactoryMock];
    
    
    STAssertNotNil(profileVC, @"Expected profileVC to be non-nil");
    
    id partialMock = [OCMockObject partialMockForObject:profileVC];
    id userMock = [OCMockObject mockForClass:[YAUser class]];
    
    [[[partialMock stub] andReturn:userMock] currentUser];
    
    id tableViewCellMock = [OCMockObject mockForClass:[UITableViewCell class]];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:4];
    
    
    [[tableViewCellMock stub] setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    YAImageUpdateStatus imageUpdateStatus = YAImageUpdateStatusError;
    [[[userProfileRepositoryMock expect] andReturnValue:OCMOCK_VALUE(imageUpdateStatus)] imageUpdateStatusForUser:userMock];
    
    YAProfileUpdateStatus profileUpdateStatus = YAProfileUpdateStatusPublic;
    [[[userProfileRepositoryMock expect] andReturnValue:OCMOCK_VALUE(profileUpdateStatus)] profileUpdateStatusForUser:userMock];
    
    id mockAlertView = [OCMockObject mockForClass:[UIAlertView class]];
    [[[uiAlertViewFactoryMock expect] andReturn:mockAlertView] createWithTitle:kErrorTitle message:kProfileImageUpdateErrorMessage
                                                                      delegate:[OCMArg checkWithBlock:^BOOL(id obj) {
        return [obj conformsToProtocol:@protocol(UIAlertViewDelegate)];
    }]
                                                             cancelButtonTitle:kOkButtonText otherButtonTitles:nil];
    [[mockAlertView expect] setTag:kProfileImageUpdateErrorViewTag];
    [[mockAlertView expect] show];
    
    [profileVC configureCell:tableViewCellMock atIndexPath:indexPath];
    
    [userProfileRepositoryMock verify];
    [uiAlertViewFactoryMock verify];
    [mockAlertView verify];
}

@end
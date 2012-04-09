//
//  YACrumbService.m
//  altoids
//
//  Created by Anand Subba Rao on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YACrumbService.h"
#import "YSMAccountInfo.h"
#import <SBJson/SBJson.h>
// Private class extension
@interface YACrumbService ()
@property (nonatomic, assign) id<CrumbServiceDelegate> delegate;
@property (nonatomic, strong) id<ProfileServerConfiguration> profileServerConfiguration;
@property (nonatomic, retain) id<ServerConfiguration> serverConfiguration;
// methods

@end

@implementation YACrumbService

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize delegate = delegate_;
@synthesize serverConfiguration = serverConfiguration_;
@synthesize profileServerConfiguration = profileServerConfiguration_;

- (id)initWithDelegate:(id<CrumbServiceDelegate>)delegate serverConfiguration:(id<ServerConfiguration>)serverConfiguration
profileServerConfiguration:(id<ProfileServerConfiguration>)profileServerConfiguration
{
  self = [super init];
  if (self) {
      delegate_ = delegate;
      serverConfiguration_ = serverConfiguration;
      profileServerConfiguration_ = profileServerConfiguration;
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
#pragma mark <CrumbService> methods
- (void)requestCrumbWithAccountInfo:(YSMAccountInfo *)accountInfo
{
    NSString *serverURLString = [NSString stringWithFormat:@"http://%@/mmc/manager/v1/session", [[self serverConfiguration] mmcServerHostname]];
    NSURL *url = [NSURL URLWithString:serverURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:[NSString stringWithFormat:@"Y=%@; T=%@", [accountInfo yCookie], [accountInfo tCookie]] forHTTPHeaderField:@"Cookie"];
    
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error || data == nil) {
        [[self delegate] crumbService:self didFailWithError:error];
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *responseDict = [parser objectWithData:data];
    
    if ([responseDict valueForKey:@"crumb"] && [responseDict valueForKey:@"guid"]) {
        [[self delegate] crumbService:self didReceiveCrumb:[responseDict valueForKey:@"crumb"] guid:[responseDict valueForKey:@"guid"]];
        return;
    }
    
    error = [NSError errorWithDomain:@"CrumbServiceDomain" code:1 userInfo:nil];
    [[self delegate] crumbService:self didFailWithError:error];
    
}

- (void)requestProfileCrumbWithAccountInfo:(YSMAccountInfo *)accountInfo
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/v1/crumb",[[self profileServerConfiguration] serverHostname]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"test" forHTTPHeaderField:@"X-Yahoo-Cprop"];
    [request setValue:[NSString stringWithFormat:@"Y=%@; T=%@", [accountInfo yCookie], [accountInfo tCookie]] forHTTPHeaderField:@"Cookie"];
    
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error || data == nil) {
        [[self delegate] crumbService:self didFailProfileCrumbWithError:error];
        return;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *responseDict = [parser objectWithData:data];
    
    if ([responseDict valueForKey:@"crumb"]) {
        [[self delegate] crumbService:self didReceiveProfileCrumb:[responseDict valueForKey:@"crumb"]];
        return;
    }
    
    error = [NSError errorWithDomain:@"CrumbServiceDomain" code:1 userInfo:nil];
    [[self delegate] crumbService:self didFailProfileCrumbWithError:error];
    
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
#pragma mark YACrumbService ()

@end

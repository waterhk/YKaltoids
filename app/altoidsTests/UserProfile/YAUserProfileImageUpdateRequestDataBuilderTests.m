//
//  YAUserProfileImageUpdateRequestDataBuilderTests.m
//  altoids
//
//  Created by Anand Subba Rao on 12/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAUserProfileImageUpdateRequestDataBuilderTests.h"
#import "YAUserProfileImageUpdateRequestDataBuilder.h"

@interface YAUserProfileImageUpdateRequestDataBuilderTests ()
@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) id imageTransformerMock;
@property (strong, nonatomic) id imageScalerMock;
@property (strong, nonatomic) id requestDataDictionaryMock;
@property (strong, nonatomic) YAUserProfileImageUpdateRequestDataBuilder *profileImageUpdateRequestDataBuilder;

@end

@implementation YAUserProfileImageUpdateRequestDataBuilderTests
@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize imageTransformerMock = imageTransformerMock_;
@synthesize imageScalerMock = imageScalerMock_;
@synthesize requestDataDictionaryMock = requestDataDictionaryMock_;
@synthesize profileImageUpdateRequestDataBuilder = profileImageUpdateRequestDataBuilder_;

// All code under test must be linked into the Unit Test bundle
- (void)setUp
{
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];
    [self setImageTransformerMock:[OCMockObject mockForProtocol:@protocol(ImageTransformer)]];
    [self setImageScalerMock:[OCMockObject mockForProtocol:@protocol(ImageScaler)]];
    
    profileImageUpdateRequestDataBuilder_ = [[YAUserProfileImageUpdateRequestDataBuilder alloc] init];
    [profileImageUpdateRequestDataBuilder_ setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
    [profileImageUpdateRequestDataBuilder_ setImageScaler:[self imageScalerMock]];
    [profileImageUpdateRequestDataBuilder_ setImageTransformer:[self imageTransformerMock]];
}

- (void)testCanBuildRequestDataForUpdatingProfileImage
{
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self requestDataDictionaryMock]] mutableDictionaryWithCapacity:2];
    
    id profileImageMock = [OCMockObject mockForClass:[UIImage class]];
    CGSize profileImageMockSize = { 2, 1 };
    NSData *profileImageData = [NSData data];
    
    [[[[self imageTransformerMock] expect] andReturn:profileImageMock] imageWithData:profileImageData];
    [[[profileImageMock expect] andReturnValue:OCMOCK_VALUE(profileImageMockSize)] size];
    
    id imageUploadDictionaryMock = [OCMockObject mockForClass:[NSMutableDictionary class]];
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:imageUploadDictionaryMock] mutableDictionaryWithCapacity:4];
    [[imageUploadDictionaryMock expect] setValue:[NSNumber numberWithInt:0] forKey:@"cropx"];
    [[imageUploadDictionaryMock expect] setValue:[NSNumber numberWithInt:0] forKey:@"cropy"];
    [[imageUploadDictionaryMock expect] setValue:[NSNumber numberWithInt:profileImageMockSize.height] forKey:@"croph"];
    [[imageUploadDictionaryMock expect] setValue:[NSNumber numberWithInt:profileImageMockSize.width] forKey:@"cropw"];
    
    id imagePostBodyMock = [OCMockObject mockForClass:[NSMutableDictionary class]];
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:imagePostBodyMock] mutableDictionaryWithCapacity:1];
    [[imagePostBodyMock expect] setValue:imageUploadDictionaryMock forKey:@"imageupload"];
    
    [[[self requestDataDictionaryMock] expect] setValue:imagePostBodyMock forKey:@"image_post_body"];
    
    [[[self requestDataDictionaryMock] expect] setValue:profileImageData forKey:@"image_data"];
    
    [[self profileImageUpdateRequestDataBuilder] requestDataForProfileImageUpdateWithImageData:profileImageData];
}
@end

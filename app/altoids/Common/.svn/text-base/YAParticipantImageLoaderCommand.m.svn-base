//
//  YAParticipantImageLoaderCommand.m
//  altoids
//
//  Created by Jon Herron on 11/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantImageLoaderCommand.h"
#import "ContactRepository.h"
#import "YAContactEndpoint.h"

@interface YAParticipantImageLoaderCommand ()

@property (strong, nonatomic) id callbackData;
@property (strong, nonatomic) NSManagedObjectID *participantID;
@property (assign, nonatomic) id<ParticipantImageLoaderCommandDelegate> delegate;

- (NSData *)contactImageDataForParticipant:(YAParticipant *)theParticipant;
- (NSData *)imageDataFromURL:(NSString *)theURLString;
- (NSData *)imageDataFromURLForParticipant:(YAParticipant *)theParticipant;
- (NSData *)profileImageDataForParticipant:(YAParticipant *)theParticipant;

@end

@implementation YAParticipantImageLoaderCommand

@synthesize participantHandler = participantHandler_;
@synthesize dataCreator = dataCreator_;
@synthesize imageCreator = imageCreator_;
@synthesize urlCreator = urlCreator_;
@synthesize contactLocator = contactLocator_;
@synthesize contactRepository = contactRepository_;
@synthesize callbackData = callbackData_;
@synthesize participantID = participantID_;
@synthesize delegate = delegate_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize personImageHandler = personImageHandler_;

- (id)initWithParticipant:(YAParticipant *)participant callbackData:(id)callbackData delegate:(id<ParticipantImageLoaderCommandDelegate>)delegate
{
    self = [super init];
    
    if (self) 
    {
        callbackData_ = callbackData;
        participantID_ = [participant objectID];
        delegate_ = delegate;
    }
    
    return self;
}

- (NSError*)execute
{
    NSData *participantImage;
    YAParticipant *participant = (YAParticipant *)[[[self managedObjectContextFactory] create] objectWithID:[self participantID]];
    
    participantImage = [self profileImageDataForParticipant:participant];
    
    if (!participant) 
    {
        participantImage = [self contactImageDataForParticipant:participant];
    }
    
    if (!participantImage) 
    {
        participantImage = [self imageDataFromURLForParticipant:participant];
    }
    
    [[self delegate] imageData:participantImage forParticipant:participant withCallbackData:[self callbackData]];
    
    return nil;
}

- (NSData *)contactImageDataForParticipant:(YAParticipant *)theParticipant
{
    YAContact* contact = [[contactLocator_ contactEndpointMatchingParticipant:theParticipant] contact];
    if(!contact) 
    {
        return nil;
    }

    return [contactRepository_ imageDataForContact:contact];
}

- (NSData *)imageDataFromURL:(NSString *)theURLString
{
    NSData *imageData;
    NSURL *imageURL;
    
    imageURL = [[self urlCreator] createWithString:theURLString];
    imageData = [[self dataCreator] createWithContentsOfURL:imageURL];
    
    return imageData;
}

- (NSData *)imageDataFromURLForParticipant:(YAParticipant *)theParticipant
{
    NSString *participantImageURLString;
    
    participantImageURLString = [[self participantHandler] photoURLForParticipant:theParticipant];
    
    return [self imageDataFromURL:participantImageURLString];
}

- (NSData *)profileImageDataForParticipant:(YAParticipant *)theParticipant
{
    NSData *profileImageData;
    NSString *profileImageURL;
    YAPersonImage *personImage;
    
    personImage = [[self participantHandler] personImageForParticipant:theParticipant];
    
    profileImageData = [[self personImageHandler] imageDataForPersonImage:personImage];
    
    if (profileImageData) 
    {
        return profileImageData;
    }
    
    profileImageURL = [[self personImageHandler] photoURLForPersonImage:personImage];
    
    if (profileImageURL)
    {
        return [self imageDataFromURL:profileImageURL];
    }
    
    return nil;
}

@end

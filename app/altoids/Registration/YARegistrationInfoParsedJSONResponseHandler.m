//
//  YARegistrationInfoParsedJSONResponseHandler.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YARegistrationInfoParsedJSONResponseHandler.h"
#import "YAAddressMetaData.h"

@interface YARegistrationInfoParsedJSONResponseHandler ()

// delegate is safely a strong reference because YARegistrationInfoParsedJSONResponseHandler has a bounded lifetime and releases delegate upon completion, avoiding any cycle;
//  this approach is much simpler than having YARegistrationInfoParsedJSONResponseHandler's delegate manage its delegation lifecycle
@property (strong, nonatomic) id<RegistrationInfoCommandDelegate> delegate;

@end

@implementation YARegistrationInfoParsedJSONResponseHandler

@synthesize addressMetaDataHandler = addressMetaDataHandler_;
@synthesize addressMetaDataRepository = addressMetaDataRepository_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize mutableArrayCreator = mutableArrayCreator_;
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;
@synthesize registrationInfoAddressMetaDataUpdater = registrationInfoAddressMetaDataUpdater_;
@synthesize registrationInfoResponseParser = registrationInfoResponseParser_;

@synthesize delegate = delegate_;

- (id)initWithDelegate:(id<RegistrationInfoCommandDelegate>)delegate
{
    self = [super init];
    
    if (self) 
    {
        delegate_ = delegate;
    }
    
    return self;
}

- (void)dealloc
{
    [self setDelegate:nil];
}

- (void)handleParsedJSONResponse:(NSDictionary *)parsedJSONResponse
{
    NSArray *numbersWithRegistrationInfo = [[self registrationInfoResponseParser] numbersInResponse:parsedJSONResponse];
    NSUInteger numbersWithRegistrationInfoCount = [numbersWithRegistrationInfo count];
    
    if (numbersWithRegistrationInfoCount == 0) 
    {
        return;
    }
    
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    NSMutableArray *updatedAddressMetaDatas = [[self mutableArrayCreator] mutableArrayWithCapacity:numbersWithRegistrationInfoCount];
    NSMutableDictionary *handleToObjectIDMap = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:numbersWithRegistrationInfoCount];
    
    for (NSDictionary *numberInfo in numbersWithRegistrationInfo) 
    {
        YAAddressMetaData *updatedAddressMetaData = [[self registrationInfoAddressMetaDataUpdater] updateAddressMetaDataFromNumberRegistrationInfo:numberInfo inManagedObjectContext:managedObjectContext];
        
        if (updatedAddressMetaData) 
        {
            NSString *handle = [[self addressMetaDataHandler] handleForAddressMetaData:updatedAddressMetaData];
            NSManagedObjectID *objectID = [[self addressMetaDataHandler] managedObjectIDForAddressMetaData:updatedAddressMetaData];
            
            if (handle && objectID) 
            {
                [handleToObjectIDMap setObject:objectID forKey:handle];
            }
            
            [updatedAddressMetaDatas addObject:updatedAddressMetaData];
        }
    }
    
    if ([updatedAddressMetaDatas count] > 0) 
    {
        BOOL didSave;
        NSError *error;
        
        didSave = [[self addressMetaDataRepository] saveAddressMetaDatas:updatedAddressMetaDatas inManagedObjectContext:managedObjectContext error:&error];
        
        if (!didSave) 
        {
            [[self delegate] registrationInfoDidFailToSaveWithError:error];
            [self setDelegate:nil];
            
            return;
        }
    }
    
    [[self delegate] registrationInfoDidSaveWithHandleToObjectIDMap:handleToObjectIDMap];
    [self setDelegate:nil];
}

@end

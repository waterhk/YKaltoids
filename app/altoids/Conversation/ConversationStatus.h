//
//  ConversationStatus.h
//  altoids
//
//  Created by Jon Herron on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

typedef enum
{
    /*
     conversation has been created but not saved locally
     */
    YAConversationStatusNew = 1,
    
    /*
     conversation has been saved as a draft but is not ready 
     to be sent to the server
     */
    YAConversationStatusDraft = 100,
    
    /*
     conversation has been saved locally and is ready to be sent 
     to the server
     */
    YAConversationStatusPending = 200,
    
    /*
     conversation has been saved locally but an error occurred 
     while saving
     */
    YAConversationStatusPendingWithErrors = 300,
    
    /*
     conversation has been successfully saved on the server
     */
    YAConversationStatusSaved = 400,
    
    /*
     conversation was received from the server with an error
     */
    YAConversationStatusReceivedWithErrors = 500,
    
    
    /*
     conversation gap placeholder, indicates that conversations at 
     this location are possibly missing from local storage
     */
    YAConversationStatusGapPlaceholder = 9999,
    
} YAConversationStatus;

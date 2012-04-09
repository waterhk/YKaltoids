//
//  MessageStatus.h
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    /*
     message has been created but not saved locally
     */
    YAMessageStatusNew = 1,
    
    /*
     message has been saved as a draft but is not ready 
     to be sent to the server
     */
    YAMessageStatusDraft = 100,
    
    /*
     message has been saved locally and is ready to be sent 
     to the server
     */
    YAMessageStatusPending = 200,
    
    /*
     message has been saved locally but an error occurred 
     while saving to the server
     */
    YAMessageStatusPendingWithErrors = 300,
    
    /*
     message has been successfully saved on the server
     */
    YAMessageStatusSaved = 400,
    
    

    /*
     message is a system message, which was generated in response 
     to an action, not by a user directly
     */
    YAMessageStatusSystemMessage = 8000,
    
    /*
     message gap placeholder, indicates that message at 
     this location are possibly missing from local storage
     */
    YAMessageStatusGapPlaceholder = 9999,
    
} YAMessageStatus;

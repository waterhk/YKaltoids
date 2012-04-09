//
//  PersonImageObserverCreator.h
//  altoids
//
//  Created by Anand Biligiri on 11/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonImageObserver.h"
#import "PersonImageObserverDelegate.h"

@protocol PersonImageObserverCreator <NSObject>

#pragma mark -
#pragma mark @required
@required
- (id<PersonImageObserver>)createWithDelegate:(id<PersonImageObserverDelegate>)delegate managedObjectContext:(NSManagedObjectContext *)context;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end

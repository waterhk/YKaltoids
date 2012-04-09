//
//  ContactRepositorySubscriber.h
//  altoids
//
//  Created by Derrick Whittle on 2/9/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ContactRepository;


// for usage, see docs/design/ContactRepository.md

@protocol ContactRepositorySubscriber <NSObject>

@required
- (void) contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository;

@end

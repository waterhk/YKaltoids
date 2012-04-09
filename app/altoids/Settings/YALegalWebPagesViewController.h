//
//  YALegalWebPagesViewController.h
//  altoids
//
//  Created by Stephane Karoubi on 3/22/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerAccessor.h"

@interface YALegalWebPagesViewController : UIViewController <ViewControllerAccessor, UIWebViewDelegate>
{
}
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, assign) NSInteger webPageIndex;
@property (nonatomic, readonly) NSArray* legalWebPages;
@end

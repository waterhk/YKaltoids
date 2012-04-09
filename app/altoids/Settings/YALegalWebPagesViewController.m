//
//  YALegalWebPagesViewController.m
//  altoids
//
//  Created by Stephane Karoubi on 3/22/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YALegalWebPagesViewController.h"

@interface YALegalWebPagesViewController ()

@end

@implementation YALegalWebPagesViewController
@synthesize webView = webView_;
@synthesize webPageIndex = webPageIndex_;
@synthesize legalWebPages = legalWebPages_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Path to the plist (in the application bundle)
    NSString* legalPagesPlistPath = [[NSBundle mainBundle] pathForResource:
                                     @"LegalPages" ofType:@"plist"];
    legalWebPages_ = [NSArray arrayWithContentsOfFile:legalPagesPlistPath];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    

    //        Temporary title until the page finished loading
    [self setTitle:kLegalWebPagesLoadingTitle];
    
    if ([self webPageIndex] < [[self legalWebPages] count]) 
    {
        [[self webView] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[self legalWebPages] objectAtIndex:[self webPageIndex]]]]];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setWebView:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIViewController *)viewController
{
    return self;   
}

#pragma mark - UIWebViewDelegate Protocol Implementation
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return true;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    Get the document title and set it as our final navigation bar title
//    This way, whenever Legal changes that property, we automatically consume it
    NSString* documentTitle = [[self webView] stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setTitle:documentTitle];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}
@end

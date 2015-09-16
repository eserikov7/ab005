//
//  UIWebVC.m
//  Abbigli
//
//  Created by Evgeny Serikov on 15.09.15.
//  Copyright (c) 2015 evs. All rights reserved.
//

#import "UIWebVC.h"
#import "UIStoryboard+instant.h"
#import "Constants.h"

@interface UIWebVC ()<UIWebViewDelegate>

@property(nonatomic,weak)IBOutlet UIWebView* web;

@end

@implementation UIWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSString* url = [request.URL absoluteString];
        if([url rangeOfString:kServer].location == NSNotFound)
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        else
            [self presentWebByUrl:[request.URL absoluteString]];
        return NO;
    }
    
    return YES;
}

- (void)presentWebByUrl:(NSString*)url
{
    UIWebVC* vc = [UIStoryboard instantWebVC];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showActivityIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationItem.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    [self hideActivityIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideActivityIndicator];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

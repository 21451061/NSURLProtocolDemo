//
//  ViewController.m
//  NSURLProtocolDemo
//
//  Created by wtwo on 16/7/18.
//  Copyright © 2016年 wtwo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (IBAction)startLoading:(id)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/21451061/NSURLProtocolDemo.git"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [self.webView loadRequest:request];
}

@end

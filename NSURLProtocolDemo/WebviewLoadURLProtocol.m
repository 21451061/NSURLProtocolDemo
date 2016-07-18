//
//  WebviewLoadURLProtocol.m
//  NSURLProtocolDemo
//
//  Created by wtwo on 16/7/18.
//  Copyright © 2016年 wtwo. All rights reserved.
//

#import "WebviewLoadURLProtocol.h"
#import <objc/message.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

static NSString *webViewLoadURLProtocolHandledKey = @"webViewLoadURLProtocolHandledKey";

static BOOL flag = false;
static NSURLConnection *connection;

@interface WebviewLoadURLProtocol ()<NSURLConnectionDataDelegate>

@end

@implementation WebviewLoadURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString *path = request.URL.path;
    if ([path hasSuffix:@".git"]) {
        if (flag) {
//            NSURL *url = [NSURL URLWithString:@"https://www.objc.io/"];
//            SEL selector = @selector(setURL:);
//            if ([request respondsToSelector:selector]) {
//                void (*obj_msgSendURL)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
//                obj_msgSendURL(request, selector, url);
//            }
//            NSLog(@"in %s, address: <%p>, URL: %@", __func__, request, request.URL.absoluteString);
            NSLog(@"in %s, address: <%p>, hash: %lu", __func__, request, (unsigned long)request.hash);
        }
        
        if ([NSURLProtocol propertyForKey:webViewLoadURLProtocolHandledKey inRequest:request]) {
            return NO;
        }
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSMutableURLRequest *newRequest = [self.request mutableCopy];
    newRequest.allHTTPHeaderFields = self.request.allHTTPHeaderFields;
    NSLog(@"in %s, address: <%p>, hash: %lu", __func__, newRequest, (unsigned long) newRequest.hash);
//    NSLog(@"in %s, address: <%p>, URL: %@", __func__, newRequest, newRequest.URL.absoluteString);
    [NSURLProtocol setProperty:@YES forKey:webViewLoadURLProtocolHandledKey inRequest:newRequest];
    flag = TRUE;
    connection = [NSURLConnection connectionWithRequest:newRequest delegate:self];
}

- (void)stopLoading {
    [connection cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

@end

//
//  JSONWebservice.m
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/19/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import "JSONWebservice.h"
#import <Reachability.h>
#import <SBJson/SBJson4.h>
#import "ProductCard.h"

#define ARRAY_RESPONSE_ROOT @"root"

@interface JSONWebservice()<NSURLSessionDataDelegate>
@property (strong) SBJson4Parser *parser;
@end

@implementation JSONWebservice

-(id) init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

#pragma mark - Request methods

-(void)requestWithURL:(NSString*)url withSuccessBlock:(AFJsonSuccessBlock)successResponse andErrorBlock:(AFJsonErrorBlock)errorResponse {
 
    //Set JSON parser
    id successBlock = ^(id data, BOOL stop) {
        successResponse(data);
    };
    id errorBlock = ^(NSError *error) {
        errorResponse(error);
    };
    
    self.parser = [SBJson4Parser multiRootParserWithBlock:successBlock
                                                   errorHandler:errorBlock];
    //Create the request
    NSURLSession *serverURLSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                             delegate:self
                                                        delegateQueue:nil];
    NSURL *productDataUrl = [NSURL URLWithString:url];
    NSURLSessionDataTask *urlSessionDataTask = [serverURLSession dataTaskWithURL:productDataUrl];
    [urlSessionDataTask resume];
}

#pragma NSURLSession Delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    switch ([self.parser parse:data]) {
        case SBJson4ParserError:
            NSLog(@"Found an error");
            [session invalidateAndCancel];
            self.parser = nil;
            break;
        case SBJson4ParserComplete:
        case SBJson4ParserStopped:
            self.parser = nil;
            break;
        case SBJson4ParserWaitingForData:
            NSLog(@"Waiting for more data!");
            break;
    }
}

@end

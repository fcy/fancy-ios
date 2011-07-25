//    Copyright 2011 Felipe Cypriano
// 
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
// 
//        http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

#import "FCJSONFetcher.h"

@implementation FCJSONFetcher

@synthesize data;
@synthesize parser;
@synthesize httpFetcher;
@synthesize error;

- (id)initWithURLRequest:(NSURLRequest *)newURLRequest jsonParsedBlock:(FCJSONActionBlock)newCompletionBlock requestFailedBlock:(FCJSONActionBlock)newFailBlock {
    self = [super init];
    if (self) {
        completionBlock = newCompletionBlock;
        failBlock = newFailBlock;
        urlRequest = newURLRequest;
    }
    return self;
}

- (id)initWithURLString:(NSString *)urlString jsonReceivedBlock:(FCJSONActionBlock)newCompletionBlock requestFailedBlock:(FCJSONActionBlock)newFailBlock {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    return [self initWithURLRequest:req jsonParsedBlock:newCompletionBlock requestFailedBlock:newFailBlock];    
}

- (void)dealloc {
    [self cancel];
    
    [error release];
    [data release];
    [httpFetcher release];
    [super dealloc];
}

- (void)start {
    if (httpFetcher) {
        [self cancel];
    }
    
    [data release];
    data = nil;
    [error release];
    error = nil;

    void (^httpCompletionBlock)(FCHTTPFetcher *) = ^(FCHTTPFetcher *fetcher){ 
        NSData *rawJson = [fetcher data];
        id json = [parser jsonFetcher:self parseData:rawJson];
        if ([parser isKindOfClass:[NSError class]]) {
            error = [json retain];
            failBlock(self);
        } else {
            data = [json retain];
            completionBlock(self);
        }
    }; 
    
    httpFetcher = [[FCHTTPFetcher alloc] initWithURLRequest:urlRequest 
                            responseReceivedBlock:httpCompletionBlock 
                            requestFailedBlock:^(FCHTTPFetcher *fetcher){ 
                                error = [[fetcher error] retain];
                                failBlock(self);
                            }];
    
    [httpFetcher start];
}

- (void)cancel {
    [httpFetcher cancel];
    [httpFetcher release];
    httpFetcher = nil;
}

- (id)data {
    return [[data copy] autorelease];
}

@end

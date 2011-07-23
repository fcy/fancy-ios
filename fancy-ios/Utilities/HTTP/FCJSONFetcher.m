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

static id<FCJSONFetcherParser> staticDefaultParser;

@implementation FCJSONFetcher

@synthesize data;
@synthesize parser;
@synthesize httpFetcher;
@synthesize error;

+ (void)setDefaultParser:(id<FCJSONFetcherParser>)newDefaultParser {
    if (staticDefaultParser != newDefaultParser) {
        [staticDefaultParser release];
        staticDefaultParser = [newDefaultParser retain];
    }
}

- (id)initWithURLRequest:(NSURLRequest *)newURLRequest completionBlock:(FCJSONActionBlock)newCompletionBlock failBlock:(FCJSONActionBlock)newFailBlock {
    self = [super init];
    if (self) {
        completionBlock = newCompletionBlock;
        failBlock = newFailBlock;
        urlRequest = newURLRequest;
    }
    return self;
}

- (id)initWithURLString:(NSString *)urlString completionBlock:(FCJSONActionBlock)newCompletionBlock failBlock:(FCJSONActionBlock)newFailBlock {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    return [self initWithURLRequest:req completionBlock:newCompletionBlock failBlock:newFailBlock];    
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
        id<FCJSONFetcherParser> currentParser = parser == nil ? staticDefaultParser : parser;
        id parsed = [currentParser jsonFetcher:self parseData:rawJson];
        if ([parser isKindOfClass:[NSError class]]) {
            error = [parsed retain];
            failBlock(self);
        } else {
            data = [parsed retain];
            completionBlock(self);
        }
    }; 
    
    httpFetcher = [[FCHTTPFetcher alloc] initWithURLRequest:urlRequest 
                            completionBlock:httpCompletionBlock 
                            failBlock:^(FCHTTPFetcher *fetcher){ 
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

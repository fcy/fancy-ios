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

#import "FCHTTPFetcher.h"

#define LOCALIZATION_TABLE @"HTTPFetcher"

static NSUInteger numberOfActiveConnections = 0;

@implementation FCHTTPFetcher

@synthesize data;
@synthesize request;
@synthesize responseHeaderFields;
@synthesize error;
@synthesize HTTPStatusCode;

- (id)initWithURLString:(NSString *)urlString completionBlock:(FCHTTPActionBlock)newCompletionBlock failBlock:(FCHTTPActionBlock)newFailBlock {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    return [self initWithURLRequest:req completionBlock:newCompletionBlock failBlock:newFailBlock];
}

- (id)initWithURLRequest:(NSURLRequest *)urlRequest completionBlock:(FCHTTPActionBlock)newCompletionBlock failBlock:(FCHTTPActionBlock)newFailBlock {
    self = [super init];
    if (self) {
        request = [urlRequest retain];
        completionBlock = newCompletionBlock;
        failBlock = newFailBlock;
    }
    return self;
}

- (void)dealloc {
    [self cancel];
    
    [data release];
    [request release];
    [responseHeaderFields release];
    [self dealloc];
}

- (void)start {
    if (connection) {
        [self cancel];
    }
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    @synchronized([FCHTTPFetcher class]) {
        numberOfActiveConnections++;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    
    [connection start];
}

- (void)decrementNumberOfActiveConnections {
    @synchronized([FCHTTPFetcher class]) {
        numberOfActiveConnections = MAX(numberOfActiveConnections - 1, 0);
        if (numberOfActiveConnections == 0) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    }
    
}

- (void)cancel {
    [connection cancel];
    [connection release];
    connection = nil;
    
    [self decrementNumberOfActiveConnections];
}

- (NSData *)data {
    return [[data copy] autorelease];
}

#pragma mark -
#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    HTTPStatusCode = [response statusCode];
    responseHeaderFields = [[response allHeaderFields] retain];
    
    [data release];
	NSInteger contentLength = [[responseHeaderFields objectForKey:@"Content-Length"] integerValue];
	if (contentLength > 0) {
		data = [[NSMutableData alloc] initWithCapacity:contentLength];
	} else {
		data = [[NSMutableData alloc] init];
	}
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)newData {
    [data appendData:newData];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)theError {
    [self decrementNumberOfActiveConnections];
    
    [error release];
    error = [theError retain];
	if ([[error domain] isEqual:NSURLErrorDomain]) 	{
		HTTPStatusCode = [error code];
	}
    
    NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
    failBlock(self);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    if (HTTPStatusCode >= 200 && HTTPStatusCode < 300) {
        NSString *message = NSLocalizedStringFromTable(@"HTTP Error", LOCALIZATION_TABLE, @"There's an error with the request");
        
        switch (HTTPStatusCode) {
            case 404:
                message = NSLocalizedStringFromTable(@"Data not found on the server", LOCALIZATION_TABLE, @"Response returned HTTP status 404");
                break;
            case 403:
                message = NSLocalizedStringFromTable(@"Access forbidden", LOCALIZATION_TABLE, @"Response returned HTTP status 403");
                break;
            case 500:
                message = NSLocalizedStringFromTable(@"Server's internal error", LOCALIZATION_TABLE, @"Response returned HTTP status 500");
                break;
            default:
                break;
        }
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
        NSError *theError = [[NSError alloc] initWithDomain:NSURLErrorDomain code:HTTPStatusCode userInfo:userInfo];
        [self connection:aConnection didFailWithError:theError];
    } else {
        [self decrementNumberOfActiveConnections];
        completionBlock(self);
    }
}

@end

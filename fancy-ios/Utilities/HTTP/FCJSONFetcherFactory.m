//
//  FCJSONFetcherFactory.m
//  fancy-ios
//
//  Created by Felipe Cypriano on 24/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FCJSONFetcherFactory.h"

@implementation FCJSONFetcherFactory

@synthesize defaultParser;

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    [defaultParser release];
    [super dealloc];
}

- (FCJSONFetcher *)newJSONFetcherWithURLString:(NSString *)urlString jsonParsedBlock:(FCJSONActionBlock)jsonParsedBlock jsonFailBlock:(FCJSONActionBlock)jsonFailBlock {
    FCJSONFetcher *newFetcher = [[FCJSONFetcher alloc] initWithURLString:urlString jsonReceivedBlock:jsonParsedBlock requestFailedBlock:jsonFailBlock];
    newFetcher.parser = defaultParser;
    return newFetcher;
}

- (FCJSONFetcher *)newJSONFetcherWithURLRequest:(NSURLRequest *)urlRequest jsonParsedBlock:(FCJSONActionBlock)jsonParsedBlock jsonFailBlock:(FCJSONActionBlock)jsonFailBlock {
    FCJSONFetcher *newFetcher = [[FCJSONFetcher alloc] initWithURLRequest:urlRequest jsonParsedBlock:jsonParsedBlock requestFailedBlock:jsonFailBlock];
    newFetcher.parser = defaultParser;
    return newFetcher;
}

@end

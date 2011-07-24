//
//  FCSBJsonParser.m
//  fc-json-parsers
//
//  Created by Felipe Cypriano on 24/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FCSBJsonParser.h"
#import "SBJson.h"

@implementation FCSBJsonParser

#pragma mark -
#pragma mark FCJSONFetcherParser method

- (id)jsonFetcher:(FCJSONFetcher *)fetcher parseData:(NSData *)jsonRawData {
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    id result = [parser objectWithData:jsonRawData];
    if ([parser error]) {
        return [parser error];
    } else {
        return result;
    }
}

@end

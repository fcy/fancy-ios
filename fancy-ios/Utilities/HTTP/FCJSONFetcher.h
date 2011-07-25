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

/**
 * @file FCJSONFetcher.h
 * JSON Fetcher
 *
 * @author Felipe Cypriano
 * @date 2011
 */

#import <Foundation/Foundation.h>
#import "FCHTTPFetcher.h"
@class FCJSONFetcher;

typedef void (^FCJSONActionBlock)(FCJSONFetcher *jsonFetcher); //< Block to execute when the request and parsing is complete

/**
 * @brief JSON Fetcher parser protocol to give the possibility to choose which parser framework to use
 *
 * @note See the fc-json-parsers project for examples of how to implement this protocal using some popular JSON frameworks
 */
@protocol FCJSONFetcherParser <NSObject>

/**
 * @brief Given a NSString returns the JSON Representation (NSArray or NSDictionary)
 *
 * @param fetcher The FCJSONFetcher that is requesting the parsed object
 * @param jsonRawData The NSData to be parsed
 * @return The JSON Representation. A NSArray or NSDictionary. <b>If any errors the return value should be a NSError.</b>
 */
- (id)jsonFetcher:(FCJSONFetcher *)fetcher parseData:(NSData *)jsonRawData;

@end


/**
 * @brief A reusable class to obtain JSON data from a request
 *
 * @warning You must maintain ownership of the object. The class doesn't retain itself.
 */
@interface FCJSONFetcher : NSObject {
    @private
    FCJSONActionBlock completionBlock;
    FCJSONActionBlock failBlock;
    NSURLRequest *urlRequest;
}

@property (nonatomic, readonly) id data; ///< The parsed JSON data
@property (nonatomic, assign) id<FCJSONFetcherParser> parser;
@property (nonatomic, readonly) FCHTTPFetcher *httpFetcher;
@property (nonatomic, readonly) NSError *error;  ///< The error returned by the parser or the FCHTTPRequest, if any.

/**
 * @brief Init the receiver with NSURLRequest and a finish block
 *
 * The receiver doesn't start the connection automatcally you need to explicity call start.
 *
 * @param urlRequest The configured NSURLRequest that will be used on the call
 * @param jsonParsedBlock A FCJSONActionBlock to be executed when the call completes successfully
 * @param requestFailedBlock A FCJSONActionBlock to be executed when the call fails
 * @return The initialized FCHTTPFetcher
 */
- (id)initWithURLRequest:(NSURLRequest *)urlRequest jsonParsedBlock:(FCJSONActionBlock)jsonParsedBlock requestFailedBlock:(FCJSONActionBlock)requestFailedBlock;
/**
 * @brief Initialize the receiver with a NSString representing the URL to be called
 *
 * A NSURLRequest will be created with the URL passed in urlString using the HTTP method GET.
 *
 * The receiver doesn't start the connection automatcally you need to explicity call start.
 *
 * @param urlString A correctly formated URL
 * @param jsonParsedBlock A FCJSONActionBlock to be executed when the call completes successfully
 * @param requestFailedBlock A FCJSONActionBlock to be executed when the call fails
 * @return The initialized FCHTTPFetcher
 */
- (id)initWithURLString:(NSString *)urlString jsonReceivedBlock:(FCJSONActionBlock)completionBlock requestFailedBlock:(FCJSONActionBlock)requestFailedBlock;

/**
 * @brief Start the request
 *
 */
- (void)start;
/**
 * @brief Cancel the request
 */
- (void)cancel;

@end

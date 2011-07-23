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
 * @file FCHTTPFetcher.h
 * HTTP Fetcher class
 *
 * @author Felipe Cypriano
 * @date 2011
 */

#import <Foundation/Foundation.h>

@class FCHTTPFetcher;

typedef void (^FCHTTPActionBlock)(FCHTTPFetcher *httpFetcher); //< Block to execute when the request completes

/**
 * @brief Reusable NSURLConnection delegate using blocks
 *
 * @warning You must maintain ownership of the object. The class doesn't retain itself.
 * @note Based on @link http://cocoawithlove.com/2011/05/classes-for-fetching-and-parsing-xml-or.html Matt Gallagher's HTTPFetcher @endlink
 */
@interface FCHTTPFetcher : NSObject {
    @private
    FCHTTPActionBlock completionBlock;
    FCHTTPActionBlock failBlock;
    NSURLConnection *connection;
    NSMutableData *data;
}

@property (nonatomic, readonly) NSData *data; ///< The data returned
@property (nonatomic, readonly) NSURLRequest *request;
@property (nonatomic, readonly) NSDictionary *responseHeaderFields;
@property (nonatomic, readonly) NSError *error; ///< If the connection ends with error this property will contain the error 
@property (nonatomic, readonly) NSInteger HTTPStatusCode; //< The HTTP Status Code of the response 

/**
 * @brief Init the receiver with NSURLRequest and a finish block
 *
 * The receiver doesn't start the connection automatcally you need to explicity call start.
 *
 * @param urlRequest The configured NSURLRequest that will be used on the call
 * @param completionBlock A FCHTTPActionBlock to be executed when the call completes successfully
 * @param failBlock A FCHTTPActionBlock to be executed when the call fails
 * @return The initialized FCHTTPFetcher
 */
- (id)initWithURLRequest:(NSURLRequest *)urlRequest completionBlock:(FCHTTPActionBlock)completionBlock failBlock:(FCHTTPActionBlock)failBlock;
/**
 * @brief Initialize the receiver with a NSString representing the URL to be called
 *
 * A NSURLRequest will be created with the URL passed in urlString using the HTTP method GET.
 *
 * The receiver doesn't start the connection automatcally you need to explicity call start.
 *
 * @param urlString A correctly formated URL
 * @param completionBlock A FCHTTPActionBlock to be executed when the call completes successfully
 * @param failBlock A FCHTTPActionBlock to be executed when the call fails
 * @return The initialized FCHTTPFetcher
 */
- (id)initWithURLString:(NSString *)urlString completionBlock:(FCHTTPActionBlock)completionBlock failBlock:(FCHTTPActionBlock)failBlock;

/**
 * @brief Start the connection
 *
 */
- (void)start;
/**
 * @brief Cancel the connection
 */
- (void)cancel;

@end

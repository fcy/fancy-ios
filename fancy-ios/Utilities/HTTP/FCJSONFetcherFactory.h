//
//  FCJSONFetcherFactory.h
//  fancy-ios
//
//  Created by Felipe Cypriano on 24/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/**
 * @file FCJSONFetcherFactory.h
 * A factory for FCJSONFetcher
 *
 * @author Felipe Cypriano
 * @date 2011
 */

#import <Foundation/Foundation.h>
#import "FCJSONFetcher.h"

/**
 * @brief FCJSONFetcher factory
 *
 * This class simplifies the creation of FCJSONFetcher by setting default
 * properties like the parser.
 *
 * A common use is to keeo the factory on AppDelegate and set the defaultParser
 * property to the JSON parser implementation that you will use throughout your project.
 */
@interface FCJSONFetcherFactory : NSObject

@property (nonatomic, retain) id<FCJSONFetcherParser> defaultParser; ///< The implementation of FCJSONFetcherParser that will be used by new instances of FCJSONFetcher created using this factory

/**
 * @brief Creates a new FCJSONFetcher
 *
 * @return A new FCJSONFetcher with the properties setted
 */
- (FCJSONFetcher *)newJSONFetcherWithURLString:(NSString *)urlString jsonParsedBlock:(FCJSONActionBlock)jsonParsedBlock jsonFailBlock:(FCJSONActionBlock)jsonFailBlock;

/**
 * @brief Creates a new FCJSONFetcher
 *
 * @return A new FCJSONFetcher with the properties setted
 */
- (FCJSONFetcher *)newJSONFetcherWithURLRequest:(NSURLRequest *)urlRequest jsonParsedBlock:(FCJSONActionBlock)jsonParsedBlock jsonFailBlock:(FCJSONActionBlock)jsonFailBlock;

@end

//
//  FCYDictionaryFilter.h
//  fancy-ios
//
//  Created by Felipe Cypriano on 03/07/13.
//
//

#import <Foundation/Foundation.h>

/**
 * This class filters the content os NSDictionary so that any NSNull
 * is returned as nil.
 */
@interface FCYDictionaryFilter : NSObject

/**
 * Creates a new `FCYDictionaryFilter`
 * 
 * @param The NSDictionary that will be read
 * @return A FCYDictionaryFilter
 * @see `initWithDictionary:`
 */
+ (instancetype)filterDictionary:(NSDictionary *)dictionary;

/**
 * Init the filter with the given dictionary.
 *
 * @param The NSDictionary that will be read
 * @return A FCYDictionaryFilter
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

/**
 * Returns the object with the given that is in the dictionary.
 *
 * If the object is an instance of NSNull than the return is `nil`
 * instead of the NSNull object.
 * 
 * @param key The key of the object
 * @return The object with the key or nil if the object is a NSNull
 * or doesn't exist.
 */
- (id)objectForKey:(id)key;

/**
 * @see `objectForKey:`
 */
- (id)objectForKeyedSubscript:(id)key;

@end

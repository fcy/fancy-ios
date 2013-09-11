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
 * Tell the filter if it should convert a nil to a NSNull object when setting.
 * 
 * The default is `NO`. If set to `YES` when `setObject:forKey` is called with
 * nil object a NSNull object will be set; if set to 'NO' it will be ignored.
 * 
 * ```
 * NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
 * FCYDictionaryFilter *dictionaryFilter = [FCYDictionaryFilter filterDictionary:dictionary];
 * dictionaryFilter.convertNilToNSNullOnSet = YES;
 * dictionaryFilter[@"key"] = nil;
 * [dictionary[@"key"] isKindOfClass[NSNull class]]; // returns YES
 * ```
 */
@property (nonatomic) BOOL convertNilToNSNullOnSet;

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

/**
 * Filter the object based on the property `convertNilToNSNullOnSet`.
 *
 * @warn You should pass a `NSMutableDictionary` when instantiating `FCYDictionaryFilter`
 * @param object the object to set
 * @key the key
 * @sa `convertNilToNSNullOnSet`
 */
- (void)setObject:(id)object forKey:(id<NSCopying>)key;

/**
 * @see `setObject:forKey:`
 */
- (void)setObject:(id)object forKeyedSubscript:(id<NSCopying>)key;

@end

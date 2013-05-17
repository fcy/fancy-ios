//
//  Created by Felipe Cypriano on 17/05/13.
//
//


#import <Foundation/Foundation.h>

/**
* Helper methods to NSArray. All of them prefixed with `fcy_` to avoid conflicts
*/
@interface NSArray (FCYArrayAdditions)

/**
* Returns a new array with randomized items
*
* Uses `arc4random_uniform` to get random indexes and build a new array with the objects from the random indexes.
* It also avoids duplicate results, unless there are already duplicate objects in the origin array.
*
* @param limit The maximum size of randomized array
* @return A array with random items that size is _up to_ `limit` or the size of the origin array.
*/
- (NSArray *)fcy_randomObjectsArrayWithLimit:(NSUInteger)limit;

@end
//
//  Created by Felipe Cypriano on 17/05/13.
//
//


#import "NSArray+FCYArrayAdditions.h"


@implementation NSArray (FCYArrayAdditions)

- (NSArray *)fcy_randomObjectsArrayWithLimit:(NSUInteger)limit {
    NSUInteger count = [self count];
    if (count > 0 && limit > 0) {
        NSMutableArray *random = [[NSMutableArray alloc] initWithCapacity:MIN(limit, count)];
        NSMutableArray *alreadyChoosenIndexes = [[NSMutableArray alloc] init];
        NSUInteger i = 0;
        do {
            uint32_t randomIndex = arc4random_uniform((uint32_t) count);
            NSNumber *index = @(randomIndex);
            if (![alreadyChoosenIndexes containsObject:index]) {
                id randomObject = [self objectAtIndex:randomIndex];
                [random addObject:randomObject];
                [alreadyChoosenIndexes addObject:@(randomIndex)];
            }
            i++;
        } while ([random count] < limit && i < count * 2);

        return [random copy];
    } else {
        return @[];
    }
}


- (NSArray *)fcy_arrayByRemovingObjectsInArray:(NSArray *)array {
    NSMutableArray *mutableArray = [self mutableCopy];
    [mutableArray removeObjectsInArray:array];
    return [mutableArray copy];
}


@end

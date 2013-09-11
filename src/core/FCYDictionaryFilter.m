//
//  FCYDictionaryFilter.m
//  fancy-ios
//
//  Created by Felipe Cypriano on 03/07/13.
//
//

#import "FCYDictionaryFilter.h"

@implementation FCYDictionaryFilter {
    NSDictionary *_dictionary;
}

+ (instancetype)filterDictionary:(NSDictionary *)dictionary {
    return [[FCYDictionaryFilter alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _dictionary = dictionary;
        self.convertNilToNSNullOnSet = NO;
    }
    return self;
}

- (id)objectForKey:(id<NSCopying>)key {
    id obj = [_dictionary objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        obj = nil;
    }
    return obj;
}

- (id)objectForKeyedSubscript:(id<NSCopying>)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)object forKey:(id<NSCopying>)key {
    if ([_dictionary isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary *mdic = (NSMutableDictionary *) _dictionary;
        if (object == nil) {
            if (self.convertNilToNSNullOnSet) {
                object = [NSNull null];
                [mdic setObject:object forKey:key];
            }
        } else {
            [mdic setObject:object forKey:key];
        }
    } else {
        [[NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:@"Should create FCYDictionaryFilter with a NSMutableDictionary instance to use setObject:forKey:"
                               userInfo:nil] raise];
    }
}

- (void)setObject:(id)object forKeyedSubscript:(id<NSCopying>)key {
    [self setObject:object forKey:key];
}

@end

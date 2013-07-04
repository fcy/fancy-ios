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
    }
    return self;
}

- (id)objectForKey:(id)key {
    id obj = [_dictionary objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        obj = nil;
    }
    return obj;
}

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

@end

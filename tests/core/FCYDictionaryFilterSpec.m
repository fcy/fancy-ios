#import "Kiwi.h"
#import "FCYDictionaryFilter.h"

SPEC_BEGIN(FCYDictionaryFilterSpec)

describe(@"FCYDictionaryFilter", ^{
    context(@"newly created", ^{
        it(@"defaults convertNilToNSNull to NO", ^{
            FCYDictionaryFilter *dictionaryFilter = [[FCYDictionaryFilter alloc] init];
            [[theValue(dictionaryFilter.convertNilToNSNullOnSet) should] beNo];
        });
    });

    describe(@"objectForKey:", ^{
        it(@"returns nil if the underlying value is a NSNull", ^{
            NSDictionary *dic = @{ @"null": [NSNull null] };
            FCYDictionaryFilter *filter = [FCYDictionaryFilter filterDictionary:dic];
            [[filter objectForKey:@"null"] shouldBeNil];
        });

        it(@"returns the actual object if underlying value is not NSNull", ^{
            NSObject *obj = [[NSObject alloc] init];
            FCYDictionaryFilter *filter = [[FCYDictionaryFilter alloc] initWithDictionary:@{ @"obj" : obj }];
            [[[filter objectForKey:@"obj"] should] equal:obj];
        });
    });

    describe(@"objectForKeyedSubscription:", ^{
        it(@"calls objectForKey:", ^{
            FCYDictionaryFilter *filter = [[FCYDictionaryFilter alloc] init];
            [[[filter should] receive] objectForKey:@"key"];
            filter[@"key"];
        });
    });

    describe(@"setObject:forKey:", ^{
        __block NSMutableDictionary *_mutableDictionary;
        __block FCYDictionaryFilter *_filter;
        beforeEach(^{
            _mutableDictionary = [[NSMutableDictionary alloc] init];
            _filter = [FCYDictionaryFilter filterDictionary:_mutableDictionary];
        });

        it(@"raises NSInternalInconsistencyException if backed by NSDictionary", ^{
            FCYDictionaryFilter *filter = [FCYDictionaryFilter filterDictionary:@{ }];
            [[theBlock(^{
                [filter setObject:@"" forKey:@"emtpyString"];
            }) should] raiseWithName:NSInternalInconsistencyException];
        });

        it(@"does not raise any exception if object is nil", ^{
            [[theBlock(^{
                [_filter setObject:nil forKey:@"key"];
            }) shouldNot] raise];
        });

        it(@"works as a NSMutableDictionary with non nil/NSNull objects", ^{
            NSObject *obj = [[NSObject alloc] init];
            [_filter setObject:obj forKey:@"obj"];
            [[_mutableDictionary[@"obj"] should] equal:obj];
        });

        it(@"ignores nil objects", ^{
            [_filter setObject:nil forKey:@"key"];
            [_mutableDictionary[@"key"] shouldBeNil];
        });

        context(@"convertNilToNSNull setted to YES", ^{
            it(@"sets a NSNull object if passed nil", ^{
                _filter.convertNilToNSNullOnSet = YES;
                [_filter setObject:nil forKey:@"key"];
                [[_mutableDictionary[@"key"] should] beKindOfClass:[NSNull class]];
            });
        });
    });

    describe(@"setObject:forKeyedSubscription:", ^{
        it(@"calls setObject:forKey:", ^{
            NSObject *obj = [[NSObject alloc] init];
            FCYDictionaryFilter *filter = [[FCYDictionaryFilter alloc] init];
            [[[filter should] receive] setObject:obj forKey:@"key"];
            filter[@"key"] = obj;
        });
    });
});

SPEC_END
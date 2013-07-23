//
//  FCYDictionaryFilterTests.m
//  fancy-ios
//
//  Created by Felipe Cypriano on 23/07/13.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "FCYDictionaryFilter.h"

@interface FCYDictionaryFilterTests : SenTestCase
@end


@implementation FCYDictionaryFilterTests

- (void)testShouldConvertNilToNSNullOnSetDefaultsToNO {
    FCYDictionaryFilter *dictionaryFilter = [[FCYDictionaryFilter alloc] init];
    STAssertFalse(dictionaryFilter.shouldConvertNilToNSNullOnSet, @"shouldConvertNilToNSNullOnSet defaults to NO");
}

- (void)testObjectForKeyReturnsNilIfKeyHasNSNull {
    NSDictionary *dic = @{ @"null": [NSNull null] };
    FCYDictionaryFilter *filter = [FCYDictionaryFilter filterDictionary:dic];
    STAssertNil([filter objectForKey:@"null"], @"Should return nil for NSNull values");
    STAssertNil(filter[@"null"], @"objectForKeyedSubscription should return nil for NSNull values as well");
}

- (void)testObjectForKeyReturnsTheCorrectObjectWhenNotNSNull {
    NSObject *obj = [[NSObject alloc] init];
    FCYDictionaryFilter *filter = [[FCYDictionaryFilter alloc] initWithDictionary:@{ @"obj" : obj }];
    STAssertEqualObjects([filter objectForKey:@"obj"], obj, @"Should return the correct object");
    STAssertEqualObjects(filter[@"obj"], obj, @"Should return the correct object with objectForKeyedSubscription as well");
}

- (void)testSetObjectForKeyRaisesExceptionWhenBackedByNSDictionary {
    FCYDictionaryFilter *filter = [FCYDictionaryFilter filterDictionary:@{}];
    STAssertThrowsSpecificNamed([filter setObject:@"" forKey:@"emptyString"], NSException, NSInternalInconsistencyException, @"Should raise a NSInternalInconsistencyException when the filter is not backed by a NSMutableDictionary");
}

- (void)testSetObjectForKeyWithNilObjectDoesNotThrow {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    FCYDictionaryFilter *filter = [[FCYDictionaryFilter alloc] initWithDictionary:dic];
    STAssertNoThrow([filter setObject:nil forKey:@"key"], @"Should not throw for nil object");
}

- (void)testSetObjectForKeyIgnoresNil {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    FCYDictionaryFilter *filter = [[FCYDictionaryFilter alloc] initWithDictionary:dic];
    [filter setObject:nil forKey:@"key"];
    STAssertNil(dic[@"key"], @"Filter should ignore the nil value if shouldConvertNilToNSNullOnSet is NO");
    filter[@"anotheKey"] = nil;
    STAssertNil(dic[@"anotherKey"], @"Should filter nil in setObject:ForKeyedSubscription if shouldConvertNilToNSNullOnSet is NO as well");
}

- (void)testSetObjectForKeyWithAValidObjectWorks {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    FCYDictionaryFilter *filter = [[FCYDictionaryFilter alloc] initWithDictionary:dic];
    NSObject *obj = [[NSObject alloc] init];
    filter[@"obj"] = obj;
    STAssertEqualObjects(dic[@"obj"], obj, @"Should work as a plain NSMutableDictionary for non nil values");
}

- (void)testSetObjectForKeyConvertsNilToNSNull {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    FCYDictionaryFilter *filter = [[FCYDictionaryFilter alloc] initWithDictionary:dic];
    filter.shouldConvertNilToNSNullOnSet = YES;
    [filter setObject:nil forKey:@"key"];
    STAssertTrue([dic[@"key"] isKindOfClass:[NSNull class]], @"Should convert nil to NSNull if shouldConvertNilToNSNullOnSet is YES");
    filter[@"anotherKey"] = nil;
    STAssertTrue([dic[@"anotherKey"] isKindOfClass:[NSNull class]], @"Should convert nil to NSNull if shouldConvertNilToNSNullOnSet is YES on keyed subscription as well");
}

@end

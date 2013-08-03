#import "Kiwi.h"
#import "NSArray+FCYArrayAdditions.h"

SPEC_BEGIN(NSArrayFCYArrayAdditionsSpec)

describe(@"FCYArrayAdditions Category", ^{
    describe(@"fcy_arrayByRemovingObjectsInArray:", ^{
        it(@"returns a new array without the specified objects", ^{
            NSArray *original = @[ @1, @2, @3, @6, @55 ];
            NSArray *result = [original fcy_arrayByRemovingObjectsInArray:@[ @6, @55 ]];
            [[result should] equal:@[ @1, @2, @3 ]];
        });
    });
});

SPEC_END
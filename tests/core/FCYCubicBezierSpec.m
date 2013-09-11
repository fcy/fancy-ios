#import "Kiwi.h"
#import "FCYCubicBezier.h"

SPEC_BEGIN(FCYCubicBezierSpec)

describe(@"FCYCubicBezier", ^{
    __block FCYCubicBezier *cubicBezier;
    context(@"new instance", ^{
        beforeEach(^{
            cubicBezier = [[FCYCubicBezier alloc] init];
        });

        it(@"has a start point of (0, 0)", ^{
            [[theValue(cubicBezier.startPoint) should] equal:theValue(CGPointZero)];
        });

        it(@"has a control point 1 of (0, 0)", ^{
            [[theValue(cubicBezier.controlPoint1) should] equal:theValue(CGPointZero)];
        });

        it(@"has an control point 2 of (1.0, 1.0)", ^{
            [[theValue(cubicBezier.controlPoint2) should] equal:theValue(CGPointMake(1.0, 1.0))];
        });

        it(@"has an end point of (1.0, 1.0)", ^{
            [[theValue(cubicBezier.endPoint) should] equal:theValue(CGPointMake(1.0, 1.0))];
        });
    });

// I don't know how to make the unit tests for this.
// Please let me know if you have a tip
//    describe(@"-bezierPointForAxisX:", ^{
//
//    });
});

SPEC_END
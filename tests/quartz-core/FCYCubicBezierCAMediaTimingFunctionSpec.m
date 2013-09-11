#import "Kiwi.h"
#import "FCYCubicBezier+CAMediaTimingFunction.h"
#import "FCYMacros.h" 


CGPoint pointAtIndex(CAMediaTimingFunction *mediaTimingFunction, NSInteger idx) {
    float coords[2];
    [mediaTimingFunction getControlPointAtIndex:idx values:coords];
    return CGPointMake(coords[0], coords[1]);
}

SPEC_BEGIN(FCYCubicBezierCAMediaTimingFunctionSpec)

describe(@"FCYCubicBezier+CAMediaTimingFunction", ^{
    __block FCYCubicBezier *cubicBezier;
    describe(@"-initWithMediaTimingFunction:", ^{
        __block CAMediaTimingFunction *mediaTimingFunction;
        beforeEach(^{
            mediaTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            cubicBezier = [[FCYCubicBezier alloc] initWithMediaTimingFunction:mediaTimingFunction];
        });

        it(@"gets the correct startPoint", ^{
            CGPoint expected = pointAtIndex(mediaTimingFunction, 0);
            [[theValue(cubicBezier.startPoint) should] equal:theValue(expected)];
        });

        it(@"gets the correct controlPoint1", ^{
            CGPoint expected = pointAtIndex(mediaTimingFunction, 1);
            [[theValue(cubicBezier.controlPoint1) should] equal:theValue(expected)];
        });

        it(@"gets the correct controlPoint2", ^{
            CGPoint expected = pointAtIndex(mediaTimingFunction, 2);
            [[theValue(cubicBezier.controlPoint2) should] equal:theValue(expected)];
        });

        it(@"gets the correct endPoint", ^{
            CGPoint expected = pointAtIndex(mediaTimingFunction, 3);
            [[theValue(cubicBezier.endPoint) should] equal:theValue(expected)];
        });
    });

    describe(@"-initWithMediaTimingFunctionName:", ^{
        it(@"instantiates a CAMediaTimingFunction using functionWithName:", ^{
            [[[CAMediaTimingFunction should] receive] functionWithName:kCAMediaTimingFunctionDefault];
            FCYSuppressWarning(-Wunused-value, {
                [[FCYCubicBezier alloc] initWithMediaTimingFunctionName:kCAMediaTimingFunctionDefault];
            });
        });
    });

    describe(@"-progressionCurveForTime:", ^{
        beforeEach(^{
            cubicBezier = [[FCYCubicBezier alloc] init];
        });

        it(@"calls bezierPointForAxisX:", ^{
            [[[cubicBezier should] receive] bezierPointForAxisX:0.3];
            [cubicBezier progressionCurveForTime:0.3];
        });

        it(@"returns the Y axis of the bezier curve", ^{
            CGFloat y = [cubicBezier bezierPointForAxisX:0.3].y;
            CGFloat progression = [cubicBezier progressionCurveForTime:0.3];
            [[theValue(progression) should] equal:theValue(y)];
        });

        context(@"t bigger than 1", ^{
            it(@"returns as if t was 1", ^{
                CGFloat expected = [cubicBezier progressionCurveForTime:1];
                CGFloat actual = [cubicBezier progressionCurveForTime:2];
                [[theValue(actual) should] equal:theValue(expected)];
            });
        });

        context(@"t smaller than 0", ^{
            it(@"returns as if t was 0", ^{
                CGFloat expected = [cubicBezier progressionCurveForTime:0];
                CGFloat actual = [cubicBezier progressionCurveForTime:-2];
                [[theValue(actual) should] equal:theValue(expected)];
            });
        });
    });
});

SPEC_END
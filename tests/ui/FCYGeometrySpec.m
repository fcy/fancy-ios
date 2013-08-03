#import "Kiwi.h"
#import "FCYGeometry.h"


SPEC_BEGIN(FCYGeometrySpec)

describe(@"FCYGeometry", ^{
    __block CGRect base;
    beforeEach(^{
        base = CGRectMake(5, 0, 100, 100);
    });

    it(@"can change size using FCYCGRectAdjustSizeBy", ^{
        CGRect changed = FCYCGRectAdjustSizeBy(base, 1, -1);
        CGRect expected = CGRectMake(5, 0, 101, 99);
        [[theValue(changed) should] equal:theValue(expected)];
    });

    it(@"can set the height with FCYCGRectSetHeight", ^{
        CGRect changed = FCYCGRectSetHeight(base, 1);
        CGRect expected = CGRectMake(5, 0, 100, 1);
        [[theValue(changed) should] equal:theValue(expected)];
    });

    it(@"can set the width with FCYCGRectSetWidth", ^{
        CGRect changed = FCYCGRectSetWidth(base, 1);
        CGRect expected = CGRectMake(5, 0, 1, 100);
        [[theValue(changed) should] equal:theValue(expected)];
    });

    it(@"can set the size with FCYCGRectSetSize", ^{
        CGRect changed = FCYCGRectSetSize(base, CGSizeMake(101, 99));
        CGRect expected = CGRectMake(5, 0, 101, 99);
        [[theValue(changed) should] equal:theValue(expected)];
    });

    it(@"can set the size with FCYCGRectSetSizeMake", ^{
        CGRect changed = FCYCGRectSetSizeMake(base, 101, 99);
        CGRect expected = CGRectMake(5, 0, 101, 99);
        [[theValue(changed) should] equal:theValue(expected)];
    });

    it(@"can set the position with FCYCGRectSetPosition", ^{
        CGRect changed = FCYCGRectSetPosition(base, 1, 0);
        CGRect expected = CGRectMake(1, 0, 100, 100);
        [[theValue(changed) should] equal:theValue(expected)];
    });

    it(@"can set the y position with FCYCGRectSetPositionY", ^{
        CGRect changed = FCYCGRectSetPositionY(base, 1);
        CGRect expected = CGRectMake(5, 1, 100, 100);
        [[theValue(changed) should] equal:theValue(expected)];
    });

    it(@"can set the x position with FCYCGRectSetPositionX", ^{
        CGRect changed = FCYCGRectSetPositionX(base, 1);
        CGRect expected = CGRectMake(1, 0, 100, 100);
        [[theValue(changed) should] equal:theValue(expected)];
    });

    it(@"can get the horizontal end value of a rect: sum x + width", ^{
        [[theValue(FCYCGRectHorizontalEndValue(base)) should] equal:theValue(105.0f)];
    });

    it(@"can get the center point of a rect with FCYCenterPointOfRect", ^{
        CGRect rect = CGRectMake(2, 2, 20, 10);
        CGPoint expectedCenter = CGPointMake(10, 5);
        CGPoint center = FCYCenterPointOfRect(rect);
        [[theValue(center) should] equal:theValue(expectedCenter)];
    });
});

SPEC_END
#import "Kiwi.h"
#import "FCYRangeSlider.h"

SPEC_BEGIN(FCYRangeSliderSpec)

describe(@"FCYRangeSlider", ^{
    __block FCYRangeSlider *rangeSlider;
    beforeEach(^{
        rangeSlider = [[FCYRangeSlider alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    });

    afterEach(^{
        rangeSlider = nil;
    });

    context(@"initial values", ^{
        it(@"has a minimuValue of zero", ^{
            [[theValue([rangeSlider minimumValue]) should] beZero];
        });

        it(@"has a maximumValue of 10", ^{
            [[theValue([rangeSlider maximumValue]) should] equal:theValue(10.0f)];
        });

        it(@"has initialRange of NSMakeRange(0, 11)", ^{
            NSUInteger location = (NSUInteger) [rangeSlider minimumValue];
            NSUInteger length = (NSUInteger) [rangeSlider maximumValue] + 1;
            NSRange expectedInitialRange = NSMakeRange(location, length);
            [[theValue([rangeSlider range]) should] equal:theValue(expectedInitialRange)];
        });

        it(@"has initialRangeValue of (0,10)", ^{
            [[theValue(rangeSlider.rangeValue.start) should] equal:theValue(0.0f)];
            [[theValue(rangeSlider.rangeValue.end) should] equal:theValue(10.0f)];
        });

        it(@"has initialMinimumRangeLength of zero", ^{
            [[theValue(rangeSlider.minimumRangeLength) should] beZero];
        });
    });

    it(@"adjusts rangeValue.start when minimumValue is set to be greater than the current rangeValue.start", ^{
        rangeSlider.minimumValue = 1.0f;
        [[theValue(rangeSlider.rangeValue.start) should] equal:theValue(rangeSlider.minimumValue)];
        [[theValue(rangeSlider.range.length) should] equal:theValue(10.0f)];
    });

    it(@"adjusts rangeValue.end when maximumValue is set to be lower than the current rangeValue.end", ^{
        rangeSlider.maximumValue = 8.0f;
        [[theValue(rangeSlider.rangeValue.end) should] equal:theValue(rangeSlider.maximumValue)];
        CGFloat expectedRangeLength = rangeSlider.rangeValue.start + rangeSlider.rangeValue.end + 1;
        [[theValue(rangeSlider.range.length) should] equal:theValue(expectedRangeLength)];
    });

    describe(@"setRangeValue:", ^{
        context(@"property acceptOnlyNonFractionValues is set to YES", ^{
            it(@"correctly rounds the rangeValue to be 'integers'", ^{
                rangeSlider.acceptOnlyNonFractionValues = YES;
                rangeSlider.rangeValue = FCYRangeSliderValueMake(0.87f, 9.2f);
                [[theValue(rangeSlider.rangeValue.start) should] equal:theValue(1.0f)];
                [[theValue(rangeSlider.rangeValue.end) should] equal:theValue(9.0f)];
            });
        });

        it(@"adjusts rangeValue.start to comply with the minimumRangeLength", ^{
            rangeSlider.minimumRangeLength = 5.0f;
            rangeSlider.rangeValue = FCYRangeSliderValueMake(7.0f, 9.0f);
            [[theValue(rangeSlider.rangeValue.start) should] equal:theValue(4.0f)];
            [[theValue(rangeSlider.rangeValue.end) should] equal:theValue(9.0f)];
        });

        it(@"adjusts rangeValue.end to comply with the minimumRangeLength", ^{
            rangeSlider.minimumRangeLength = 5.0f;
            rangeSlider.rangeValue = FCYRangeSliderValueMake(1.0f, 3.0f);
            [[theValue(rangeSlider.rangeValue.start) should] equal:theValue(1.0f)];
            [[theValue(rangeSlider.rangeValue.end) should] equal:theValue(6.0f)];
        });

        it(@"adjusts rangeValue's start and end to comply with the minimumRangeLength", ^{
            rangeSlider.minimumRangeLength = 9.0f;
            rangeSlider.rangeValue = FCYRangeSliderValueMake(4.0f, 8.0f);
            [[theValue(rangeSlider.rangeValue.start) should] equal:theValue(1.0f)];
            [[theValue(rangeSlider.rangeValue.end) should] equal:theValue(10.0f)];
        });

        it(@"sets the rangeValue to be (minimumValue, maximumValue) if minimumRangeLength is greater than the slider scale", ^{
            rangeSlider.minimumRangeLength = 11.0f;
            rangeSlider.rangeValue = FCYRangeSliderValueMake(5.0f, 7.0f);
            [[theValue(rangeSlider.rangeValue.start) should] equal:theValue(rangeSlider.minimumValue)];
            [[theValue(rangeSlider.rangeValue.end) should] equal:theValue(rangeSlider.maximumValue)];
        });

        context(@"property acceptOnlyPositiveRanges is set to YES", ^{
            rangeSlider.acceptOnlyPositiveRanges = YES;
            FCYRangeSliderValue positiveRangeValue = FCYRangeSliderValueMake(5.0f, 7.0f);
            rangeSlider.rangeValue = positiveRangeValue;
            rangeSlider.rangeValue = FCYRangeSliderValueMake(7.0f, 5.0f);
            [[theValue(rangeSlider.rangeValue.start) should] equal:theValue(positiveRangeValue.start)];
            [[theValue(rangeSlider.rangeValue.end) should] equal:theValue(positiveRangeValue.end)];
        });
    });

    it(@"sets the rangeValue to be (minimumValue, maximumValue) when maximumValue changes to lower than rangeValue.start", ^{
        rangeSlider.minimumValue = 0.0f;
        rangeSlider.maximumValue = 100.0f;
        rangeSlider.rangeValue = FCYRangeSliderValueMake(80.0f, 100.0f);
        rangeSlider.maximumValue = 20.0f;
        [[theValue(rangeSlider.rangeValue.start) should] equal:theValue(rangeSlider.minimumValue)];
        [[theValue(rangeSlider.rangeValue.end) should] equal:theValue(rangeSlider.maximumValue)];
    });
});

SPEC_END
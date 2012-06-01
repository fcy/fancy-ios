//    Copyright 2011 Felipe Cypriano
// 
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
// 
//        http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "FCRangeSlider.h"

@interface FCRangeSliderTests : SenTestCase {
    FCRangeSlider *rangeSlider;
}
@end

@implementation FCRangeSliderTests

- (void)setUp {
    [super setUp];
    rangeSlider = [[FCRangeSlider alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
}

- (void)tearDown {
    rangeSlider = nil;
}


- (void)testInitialMinimumValue {
    STAssertEqualsWithAccuracy([rangeSlider minimumValue], 0.0f, 0.01, @"minimumValue = 0");
}

- (void)testInitialMaximumValue {
    STAssertEqualsWithAccuracy([rangeSlider maximumValue], 10.0f, 0.01, @"maximumValue = 10");
}

- (void)testInitialRange {
    NSRange expectedInitialRange = NSMakeRange([rangeSlider minimumValue], [rangeSlider maximumValue] + 1);
    STAssertTrue(NSEqualRanges(expectedInitialRange, [rangeSlider range]), @"Initial range should be %@", NSStringFromRange(expectedInitialRange));
}

- (void)testInitialRangeValue {
    STAssertEqualsWithAccuracy(0.0f, [rangeSlider rangeValue].start, 0.01, @"rangeValue.start");
    STAssertEqualsWithAccuracy(10.0f, [rangeSlider rangeValue].end, 0.01, @"rangeValue.end");
}

- (void)testInitialMinimumRangeLength {
    STAssertEqualsWithAccuracy([rangeSlider minimumRangeLength], 0.0f, 0.01, @"minimumRangeLength = 0");
}

- (void)testSetMinimumValueAboveRangeValueStart {
    rangeSlider.minimumValue = 1.0f;
    STAssertEqualsWithAccuracy([rangeSlider minimumValue], [rangeSlider rangeValue].start, 0.00, @"rangeValue.start should be >= minimumValue");
    STAssertTrue([rangeSlider range].location == 1, @"range.location should be >= minimumValue");
}

- (void)testSetMaximumValueBelowRangeValueEnd {
    rangeSlider.maximumValue = 8.0f;
    STAssertEqualsWithAccuracy([rangeSlider maximumValue], [rangeSlider rangeValue].end, 0.00, @"rangeValue.end should be <= maximumValue");
    STAssertTrue([rangeSlider range].length == rangeSlider.rangeValue.start + rangeSlider.rangeValue.end + 1, @"range.length is wrong after changing maximumValue");
}

- (void)setRangeValueWithAcceptOnlyNonFractionValuesYes {
    rangeSlider.acceptOnlyNonFractionValues = YES;
    rangeSlider.rangeValue = FCRangeSliderValueMake(0.87, 9.2);
    STAssertEqualsWithAccuracy(1.0f, [rangeSlider rangeValue].start, 0.01, @"rangeValue.start should be rounded");
    STAssertEqualsWithAccuracy(9.0f, [rangeSlider rangeValue].end, 0.01, @"rangeValue.end should be rounded");    
}

- (void)testSetRangeSmallerThanMinimumAdjustingRangeEnd {
    rangeSlider.minimumRangeLength = 5.0f;
    rangeSlider.rangeValue = FCRangeSliderValueMake(1.0f, 3.0f);
    STAssertEqualsWithAccuracy(1.0f, [rangeSlider rangeValue].start, 0.01, @"rangeValue.start should not change");
    STAssertEqualsWithAccuracy(6.0f, [rangeSlider rangeValue].end, 0.01, @"rangeValue.end should equal rangeValue.start + minimumRangeLength");
}

- (void)testSetRangeSmallerThanMinimumAdjustingRangeStart {
    rangeSlider.minimumRangeLength = 5.0f;
    rangeSlider.rangeValue = FCRangeSliderValueMake(7.0f, 9.0f);
    STAssertEqualsWithAccuracy(4.0f, [rangeSlider rangeValue].start, 0.01, @"rangeValue.start should equal rangeValue.end - minimumRangeLength");
    STAssertEqualsWithAccuracy(9.0f, [rangeSlider rangeValue].end, 0.01, @"rangeValue.end should not change");
}

- (void)testSetRangeSmallerThanMinimumAdjustingBothRangeEnds {
    rangeSlider.minimumRangeLength = 9.0f;
    rangeSlider.rangeValue = FCRangeSliderValueMake(4.0f, 8.0f);
    STAssertEqualsWithAccuracy(1.0f, [rangeSlider rangeValue].start, 0.01, @"rangeValue.start should be as close as possible to requested range start");
    STAssertEqualsWithAccuracy(10.0f, [rangeSlider rangeValue].end, 0.01, @"rangeValue.end should be adjusted to fit with minimumRangeLength");
}

- (void)testMinimumRangeLengthLargerThanSliderScale {
    rangeSlider.minimumRangeLength = 11.0f;
    rangeSlider.rangeValue = FCRangeSliderValueMake(5.0f, 7.0f);
    STAssertEqualsWithAccuracy(rangeSlider.minimumValue, [rangeSlider rangeValue].start, 0.01, @"rangeValue.start should == rangeSlider.minimumValue");
    STAssertEqualsWithAccuracy(rangeSlider.maximumValue, [rangeSlider rangeValue].end, 0.01, @"rangeValue.end should == rangeSlider.maximumValue");
}

- (void)testDisallowNegativeRanges {
    rangeSlider.acceptOnlyPositiveRanges = YES;
    FCRangeSliderValue positiveRangeValue = FCRangeSliderValueMake(5.0f, 7.0f);
    rangeSlider.rangeValue = positiveRangeValue;
    rangeSlider.rangeValue = FCRangeSliderValueMake(7.0f, 5.0f);
    STAssertEqualsWithAccuracy(positiveRangeValue.start, [rangeSlider rangeValue].start, 0.01, @"rangeValue.start should not change");
    STAssertEqualsWithAccuracy(positiveRangeValue.end, [rangeSlider rangeValue].end, 0.01, @"rangeValue.end should not change");
}

- (void)testSetMaximumValueToLowerThanRangeStartSelectsTheWholeNewRange {
    rangeSlider.minimumValue = 0.0f;
    rangeSlider.maximumValue = 100.0f;
    rangeSlider.rangeValue = FCRangeSliderValueMake(80.0f, 100.0f);
    rangeSlider.maximumValue = 20.0f;
    
    STAssertEqualsWithAccuracy([rangeSlider minimumValue], [rangeSlider rangeValue].start, 0.001, @"rangeValue.start should be equals to minimumValue");
    STAssertEqualsWithAccuracy([rangeSlider maximumValue], [rangeSlider rangeValue].end, 0.001, @"rangeValue.end should be equals to minimumValue");
}

@end

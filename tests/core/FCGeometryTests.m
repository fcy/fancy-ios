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
#import "FCGeometry.h"

@interface FCGeometryTests : SenTestCase {
    CGRect base;
}
@end


@implementation FCGeometryTests

- (void)setUp {
    base = CGRectMake(5, 0, 100, 100);
}

- (void)testRectChangeSize {
    CGRect changed = FCCGRectAdjustSizeBy(base, 1, -1);
    CGRect expected = CGRectMake(5, 0, 101, 99);

    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed size rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetHeight {
    CGRect changed = FCCGRectSetHeight(base, 1);
    CGRect expected = CGRectMake(5, 0, 100, 1);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetWidth {
    CGRect changed = FCCGRectSetWidth(base, 1);
    CGRect expected = CGRectMake(5, 0, 1, 100);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetSize {
    CGRect changed = FCCGRectSetSize(base, CGSizeMake(101, 99));
    CGRect expected = CGRectMake(5, 0, 101, 99);

    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed size rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetSizeMake {
    CGRect changed = FCCGRectSetSizeMake(base, 101, 99);
    CGRect expected = CGRectMake(5, 0, 101, 99);

    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed size rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetPosition {
    CGRect changed = FCCGRectSetPosition(base, 1, 0);
    CGRect expected = CGRectMake(1, 0, 100, 100);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetPositionY {
    CGRect changed = FCCGRectSetPositionY(base, 1);
    CGRect expected = CGRectMake(5, 1, 100, 100);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetPositionX {
    CGRect changed = FCCGRectSetPositionX(base, 1);
    CGRect expected = CGRectMake(1, 0, 100, 100);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectHorizontalEndValue {
    STAssertEqualsWithAccuracy(105.0f, FCCGRectHorizontalEndValue(base), 0.01f, @"End value = sum x + width");
}

- (void)testGettingTheCenterPointOfARect {
    CGRect rect = CGRectMake(2, 2, 20, 10);
    CGPoint expectedCenter = CGPointMake(10, 5);
    CGPoint center = FCCenterPointOfRect(rect);
    STAssertTrue(CGPointEqualToPoint(expectedCenter, center), @"The center of rect %@ should be %@, not %@", NSStringFromCGRect(rect), NSStringFromCGPoint(expectedCenter), NSStringFromCGPoint(center));
}

@end

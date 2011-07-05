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
    CGRect changed = CGRectChangeSize(base, 1, -1);
    CGRect expected = CGRectMake(5, 0, 101, 99);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed size rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetHeight {
    CGRect changed = CGRectSetHeight(base, 1);
    CGRect expected = CGRectMake(5, 0, 100, 1);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetWidth {
    CGRect changed = CGRectSetWidth(base, 1);
    CGRect expected = CGRectMake(5, 0, 1, 100);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetPosition {
    CGRect changed = CGRectSetPosition(base, 1, 0);
    CGRect expected = CGRectMake(1, 0, 100, 100);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetPositionY {
    CGRect changed = CGRectSetPositionY(base, 1);
    CGRect expected = CGRectMake(5, 1, 100, 100);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectSetPositionX {
    CGRect changed = CGRectSetPositionX(base, 1);
    CGRect expected = CGRectMake(1, 0, 100, 100);
    
    STAssertTrue(CGRectEqualToRect(expected, changed), @"Expected changed height rect %@ but was %@", NSStringFromCGRect(expected), NSStringFromCGRect(changed));
}

- (void)testRectEndValue {
    STAssertEqualsWithAccuracy(105.0f, CGRectEndValue(base), 0.01f, @"End value = sum x + width");
}

@end

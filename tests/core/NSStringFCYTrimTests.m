//
//  Created by Felipe Cypriano on 16/05/13.
//
//


#import <SenTestingKit/SenTestingKit.h>
#import "NSString+FCYStringAdditions.h"


@interface NSStringFCYTrimTests : SenTestCase
@end

@implementation NSStringFCYTrimTests {

}

- (void)testBothSidesTrim {
    STAssertEqualObjects([@" a " fcy_trim], @"a", @"Should trim both sides whitespaces");
}

@end
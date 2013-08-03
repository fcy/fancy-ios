#import "Kiwi.h"
#import "NSString+FCYStringAdditions.h"


SPEC_BEGIN(NSStringFCYTrimSpec)

describe(@"FCYTrim NSString category", ^{
    describe(@"fcy_trim", ^{
        it(@"removes whitespaces from both sides of a string", ^{
            [[[@" a " fcy_trim] should] equal:@"a"];
        });
    });
});

SPEC_END
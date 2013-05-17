//
//  Created by Felipe Cypriano on 16/05/13.
//
//


#import "NSString+FCYStringAdditions.h"


@implementation NSString (FCYStringAdditions)

- (NSString *)fcy_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
//
//  Created by Felipe Cypriano on 16/05/13.
//
//


#import "NSString+FCYTrim.h"


@implementation NSString (FCYTrim)

- (NSString *)fcy_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
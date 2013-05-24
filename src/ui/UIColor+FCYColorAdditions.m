//
//  Created by Felipe Cypriano on 24/05/13.
//
//


#import "UIColor+FCYColorAdditions.h"


@implementation UIColor (FCYColorAdditions)

+ (UIColor *)fcy_colorWithHex:(NSString *)hexValue {
    return [self fcy_colorWithHex:hexValue alpha:1.0f];
}

+ (UIColor *)fcy_colorWithHex:(NSString *)hexValue alpha:(CGFloat)alpha {
    UIColor *color;

    NSArray *hexComponents = [self hexComponentsFromHexString:hexValue];
    BOOL isValid = [hexComponents count] > 0;
    if (isValid) {
        CGFloat components[3];
        //Seperate the R,G,B values
        for (NSUInteger i = 0; i < 3; i++) {
            NSString *component = hexComponents[i];
            NSScanner *scanner = [NSScanner scannerWithString:component];
            unsigned int value;
            isValid &= [scanner scanHexInt:&value];
            components[i] = (CGFloat) value / 255.0f;
        }

        if (isValid) {
            color = [UIColor colorWithRed:components[0]
                                    green:components[1]
                                     blue:components[2]
                                    alpha:alpha];
        }
    }

    return color;
}


#pragma mark - Private Methods

+ (NSArray *)hexComponentsFromHexString:(NSString *)hexString {
    NSMutableArray *components = [[NSMutableArray alloc] init];

    NSString *hexComponent = @"[0-9,A-F]{1,2}";
    NSString *pattern = [NSString stringWithFormat:@"#(%1$@)(%1$@)(%1$@)", hexComponent];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSRange range = NSMakeRange(0,[hexString length]);
    NSTextCheckingResult *match = [regex firstMatchInString:[hexString uppercaseString] options:0 range:range];
    if ([match numberOfRanges] == 4) {
        components[0] = [hexString substringWithRange:[match rangeAtIndex:1]];
        components[1] = [hexString substringWithRange:[match rangeAtIndex:2]];
        components[2] = [hexString substringWithRange:[match rangeAtIndex:3]];
    }
    return components;
}


@end
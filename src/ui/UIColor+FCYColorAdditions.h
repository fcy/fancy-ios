//
//  Created by Felipe Cypriano on 24/05/13.
//
//


#import <Foundation/Foundation.h>

/**
* Add color constructors like color from hex.
*
* @note The color from hex feature is based on Byron Salau UIColor+PXExtensions
* code from his blog post [How to convert a html hex string into UIColor with objective-c][1].
*
* [1]: http://pixelchild.com.au/post/12785987198/how-to-convert-a-html-hex-string-into-uicolor-with
*/
@interface UIColor (FCYColorAdditions)

/**
* Creates a color from a hex string with alpha 1
*
* @param hexValue The hex string representing the color
* @return The color or nil if hex is invalid
* @see fcy_colorWithHex:alpha
*/
+ (UIColor *)fcy_colorWithHex:(NSString *)hexValue;
/**
* Creates a color from a hex string with the specified alpha
*
* Examples of valid hex values: `#FFF`, `FFFFFF`.
*
* @param hexValue The hex string representing the color
* @param alpha The color alpha from 0 to 1
* @return The color or nil if hex is invalid
*/
+ (UIColor *)fcy_colorWithHex:(NSString *)hexValue alpha:(CGFloat)alpha;

@end
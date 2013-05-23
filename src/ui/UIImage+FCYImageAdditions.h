//
//  Created by Felipe Cypriano on 16/05/13.
//
//


#import <Foundation/Foundation.h>

@interface UIImage (FCYImageAdditions)

+ (UIImage *)fcy_resizableImageWithColor:(UIColor *)color;

- (UIImage *)fcy_tintedImageWithColor:(UIColor *)tintColor;

@end
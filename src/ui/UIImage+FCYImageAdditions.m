//
//  Created by Felipe Cypriano on 16/05/13.
//
//


#import "UIImage+FCYImageAdditions.h"

static NSCache *_cache;

@implementation UIImage (FCYImageAdditions)

+ (void)initialize {
    [super initialize];
    _cache = [[NSCache alloc] init];
}


+ (UIImage *)fcy_resizableImageWithColor:(UIColor *)color {
    UIImage *image = [_cache objectForKey:color];
    if (!image) {
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ctx, [color CGColor]);
        CGContextFillRect(ctx, rect);
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image = [image resizableImageWithCapInsets:UIEdgeInsetsZero];
        [_cache setObject:image forKey:color];
    }
    return image;
}

- (UIImage *)fcy_tintedImageWithColor:(UIColor *)tintColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}


@end
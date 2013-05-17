/**
 * @file FCYThumbView.h
 * Thumb view class
 *
 * @author Felipe Cypriano
 * @date 2012
 */

#import <Foundation/Foundation.h>

/**
 * Draws a thumb to be used in the slider
 *
 * This view is used as the default thumb in FCYRangeSlider. And it has a fixed size of 24 x 24 points.
 *
 * You can use the image and highlightedImage properties to customize the thumb.
 *
 * @note Depends on FancyCore
 */
@interface FCYThumbView : UIView

/**
 * Returns the thumb's size
 *
 * Size is 24 x 24 points.
 */
+ (CGSize)size;

/**
 * When highlighted the thumb is displayed a little darker
 *
 * Thumb is darker or the highlightedImage is displayed.
 */
@property (nonatomic) BOOL highlighted;

/**
 * The image to customize the thumb in normal state
 *
 * The image size must be 24 x 24 points
 */
@property (nonatomic, strong) UIImage *image;

/**
 * The image to customize the thumb in highlighted state
 *
 * The image size must be 24 x 24 points
 */
@property (nonatomic, strong) UIImage *highlightedImage;


@end
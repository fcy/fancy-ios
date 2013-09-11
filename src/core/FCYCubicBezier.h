//
//  Created by Felipe Cypriano on 11/09/13.
//
//


#import <Foundation/Foundation.h>


/**
 * Makes Cubic Bezier calculations
 *
 * @note If you import `FCYCubicBezier+CAMediaTimingFunction.h` you can
 * use a `CATimingFunction` from QuartzCore to make a new instance
 * to make custom animations using the standard values of the platform.
 */
@interface FCYCubicBezier : NSObject

@property (nonatomic, readonly) CGPoint startPoint;
@property (nonatomic, readonly) CGPoint controlPoint1;
@property (nonatomic, readonly) CGPoint controlPoint2;
@property (nonatomic, readonly) CGPoint endPoint;

/**
 * Instantiate a linear path
 *
 * The default values are:
 * - `startPoint` (0, 0)
 * - `controlPoint1` (0, 0)
 * - `controlPoint2` (1.0, 1.0)
 * - `endPoint` (1.0, 1.0)
 *
 * @return A `FCYCubicBezier` with default points
 */
- (id)init;
/**
 * Instantiates a new `FCYCubicBezier` passing all points
 *
 * @param start the `startPoint`
 * @param c1 the `controlPoint1`
 * @param c2 the `controlPoint2`
 * @param end the `endPoint`
 * @return a `FCYCubicBezier` with the supplied points
 */
- (id)initWithStartPoint:(CGPoint)start controlPoint1:(CGPoint)c1 controlPoint2:(CGPoint)c2 endPoint:(CGPoint)end;

- (CGPoint)bezierPointForAxisX:(CGFloat)x;

@end

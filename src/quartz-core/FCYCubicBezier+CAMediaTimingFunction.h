//
//  Created by Felipe Cypriano on 11/09/13.
//
//


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "FCYCubicBezier.h"

@interface FCYCubicBezier (CAMediaTimingFunction)

- (id)initWithMediaTimingFunction:(CAMediaTimingFunction *)mediaTimingFunction;
- (id)initWithMediaTimingFunctionName:(NSString *)mediaTimingFunctionName;

/**
 * The Y value in the cubic bezier curve to be used as the acceleration for a animation
 *
 * @param t is the animation progress from 0 to 1
 */
- (CGFloat)progressionCurveForTime:(CGFloat)t;

@end
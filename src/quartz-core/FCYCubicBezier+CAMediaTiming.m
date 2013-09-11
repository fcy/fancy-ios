//
//  Created by Felipe Cypriano on 11/09/13.
//
//


#import "FCYCubicBezier+CAMediaTimingFunction.h"


@implementation FCYCubicBezier (CAMediaTimingFunction)

- (id)initWithMediaTimingFunction:(CAMediaTimingFunction *)mediaTimingFunction {
    CGPoint (^pointAtIndex)(NSUInteger) = ^(NSUInteger idx) {
        float coord[2];
        [mediaTimingFunction getControlPointAtIndex:idx values:coord];
        return CGPointMake(coord[0], coord[1]);
    };

    CGPoint cp0 = pointAtIndex(0);
    CGPoint cp1 = pointAtIndex(1);
    CGPoint cp2 = pointAtIndex(2);
    CGPoint cp3 = pointAtIndex(3);

    return [self initWithStartPoint:cp0 controlPoint1:cp1 controlPoint2:cp2 endPoint:cp3];
}

- (id)initWithMediaTimingFunctionName:(NSString *)mediaTimingFunctionName {
    CAMediaTimingFunction *mediaTimingFunction = [CAMediaTimingFunction functionWithName:mediaTimingFunctionName];
    return [self initWithMediaTimingFunction:mediaTimingFunction];
}

- (CGFloat)progressionCurveForTime:(CGFloat)t {
    t = MAX(0, MIN(1, t));
    CGPoint bezier = [self bezierPointForAxisX:t];
    return bezier.y;
}


@end
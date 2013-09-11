//
//  Created by Felipe Cypriano on 11/09/13.
//
//


#import "FCYCubicBezier.h"


@implementation FCYCubicBezier {

}

- (id)init {
    CGPoint point1 = CGPointMake(1.0, 1.0);
    return [self initWithStartPoint:CGPointZero controlPoint1:CGPointZero controlPoint2:point1 endPoint:point1];
}

- (id)initWithStartPoint:(CGPoint)start controlPoint1:(CGPoint)c1 controlPoint2:(CGPoint)c2 endPoint:(CGPoint)end {
    self = [super init];
    if (self) {
        _startPoint = start;
        _controlPoint1 = c1;
        _controlPoint2 = c2;
        _endPoint = end;
    }
    return self;
}

/*
 * Reference: http://rosettacode.org/wiki/Bitmap/Bézier_curves/Cubic#C
 * http://en.wikipedia.org/wiki/Bézier_curve#Cubic_B.C3.A9zier_curves
 */
- (CGPoint)bezierPointForAxisX:(CGFloat)x {
    CGFloat a = powf((1.0 - x), 3.0);
    CGFloat b = 3.0 * x * powf((1.0 - x), 2.0);
    CGFloat c = 3.0 * powf(x, 2.0) * (1.0 - x);
    CGFloat d = powf(x, 3.0);

    CGPoint point;
    point.x = a * _startPoint.x + b * _controlPoint1.x + c * _controlPoint2.x + d * _endPoint.x;
    point.y = a * _startPoint.y + b * _controlPoint1.y + c * _controlPoint2.y + d * _endPoint.y;

    return point;
}


@end
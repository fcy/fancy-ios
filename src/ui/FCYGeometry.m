
#import "FCYGeometry.h"

CGRect FCYCGRectAdjustSizeBy(CGRect rect, CGFloat deltaWidth, CGFloat deltaHeight) {
    CGFloat width = rect.size.width + deltaWidth;
    CGFloat height = rect.size.height + deltaHeight;
    return CGRectMake(rect.origin.x, rect.origin.y, width, height);
}

CGPoint FCYCenterPointOfRect(CGRect rect) {
    return CGPointMake(rect.size.width / 2, rect.size.height / 2);
}




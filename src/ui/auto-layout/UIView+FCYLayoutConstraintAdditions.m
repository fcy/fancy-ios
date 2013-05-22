//
//  Created by Felipe Cypriano on 22/05/13.
//
//


#import "UIView+FCYLayoutConstraintAdditions.h"
#import "FCYLayoutConstraint.h"


@implementation UIView (FCYLayoutConstraintAdditions)

- (NSArray *)fcy_addConstraintsToCenterSubview:(UIView *)view {
    NSArray *constraints = [FCYLayoutConstraint constraintsCenteringView:view inView:self];
    [self addConstraints:constraints];
    return constraints;
}

- (NSArray *)fcy_addConstraintsToAlignBothSidesOfSubview:(UIView *)view {
    NSArray *constraints = [FCYLayoutConstraint constraintsAligningBothSidesOfViewInItsSuperview:view];
    [self addConstraints:constraints];
    return constraints;
}


@end
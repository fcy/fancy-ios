//
//  Created by Felipe Cypriano on 22/05/13.
//
//


#import "FCYLayoutConstraint.h"

@implementation FCYLayoutConstraint {

}

#pragma mark - Centering

+ (NSArray *)constraintsCenteringView:(UIView *)view1 inView:(UIView *)view2 {
    return @[
            [self constraintCenterXOfView:view1 inView:view2],
            [self constraintCenterYOfView:view1 inView:view2]
    ];
}

+ (NSLayoutConstraint *)constraintCenterXOfView:(UIView *)view1 inView:(UIView *)view2 {
    return [self equalityConstraintWithView1:view1 view2:view2 attribute:NSLayoutAttributeCenterX];
}

+ (NSLayoutConstraint *)constraintCenterYOfView:(UIView *)view1 inView:(UIView *)view2 {
    return [self equalityConstraintWithView1:view1 view2:view2 attribute:NSLayoutAttributeCenterY];
}

#pragma mark - Position and alignment

+ (NSLayoutConstraint *)constraintAlignTopEdgeOfView:(UIView *)view1 withView:(UIView *)view2 {
    return [self equalityConstraintWithView1:view1 view2:view2 attribute:NSLayoutAttributeTop];
}

+ (NSLayoutConstraint *)constraintAlignRightEdgeOfView:(UIView *)view1 withView:(UIView *)view2 {
    return [self equalityConstraintWithView1:view1 view2:view2 attribute:NSLayoutAttributeRight];
}

+ (NSLayoutConstraint *)constraintAlignBottomEdgeOfView:(UIView *)view1 withView:(UIView *)view2 {
    return [self equalityConstraintWithView1:view1 view2:view2 attribute:NSLayoutAttributeBottom];
}

+ (NSLayoutConstraint *)constraintAlignLeftEdgeOfView:(UIView *)view1 withView:(UIView *)view2 {
    return [self equalityConstraintWithView1:view1 view2:view2 attribute:NSLayoutAttributeLeft];
}

+ (NSArray *)constraintsAligningAllEdgesOfView:(UIView *)view1 withView:(UIView *)view2 {
    return @[
            [self constraintAlignTopEdgeOfView:view1 withView:view2],
            [self constraintAlignRightEdgeOfView:view1 withView:view2],
            [self constraintAlignBottomEdgeOfView:view1 withView:view2],
            [self constraintAlignLeftEdgeOfView:view1 withView:view2]
    ];
}

+ (NSArray *)constraintsAligningBothSidesOfViewInItsSuperview:(UIView *)view1 {
    return [NSLayoutConstraint constraintsWithVisualFormat:@"|[view1]|"
                                            options:NSLayoutFormatAlignAllCenterX
                                            metrics:nil
                                              views:NSDictionaryOfVariableBindings(view1)];
}



#pragma mark - Private Methods

+ (NSLayoutConstraint *)equalityConstraintWithView1:(UIView *)view1 view2:(UIView *)view2 attribute:(NSLayoutAttribute)attribute {
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:view2
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:0.0];
}


@end
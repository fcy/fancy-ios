//
//  Created by Felipe Cypriano on 22/05/13.
//
//


#import <Foundation/Foundation.h>

@interface UIView (FCYLayoutConstraintAdditions)

/**
* Add a set of constraints to self centering a subview
*
* @param view The view to center
* @return An array of the added constraints
*/
- (NSArray *)fcy_addConstraintsToCenterSubview:(UIView *)view;
/**
* Add a set of constraints to self align leading and trailing of a subview to its parent
*
* @param view The view to align
* @return An array of the added constraints
* @see [FCYLayoutConstraint constraintsAligningBothSidesOfViewInItsSuperview:]
*/
- (NSArray *)fcy_addConstraintsToAlignBothSidesOfSubview:(UIView *)view;

@end
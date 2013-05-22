//
//  Created by Felipe Cypriano on 22/05/13.
//
//


#import <Foundation/Foundation.h>


/**
* A set of class methods to build `NSLayoutConstraint`(s)
*/
@interface FCYLayoutConstraint : NSObject

/// ---------------------
/// @name Centering Views
/// ---------------------

/**
*  A set of constraints that center both X and Y of a view in another
*
*  @param view1 The view to be centered
*  @param view2 The view in which view1 will be centered
*  @return An array of `NSLayoutConstraint`
*/
+ (NSArray *)constraintsCenteringView:(UIView *)view1 inView:(UIView *)view2;
/**
* A constraint to center the X of a view into another
*
*  @param view1 The view to be centered
*  @param view2 The view in which view1 will be centered
*  @return A `NSLayoutConstraint`
*/
+ (NSLayoutConstraint *)constraintCenterXOfView:(UIView *)view1 inView:(UIView *)view2;
/**
* A constraint to center the Y of a view into another
*
*  @param view1 The view to be centered
*  @param view2 The view in which view1 will be centered
*  @return A `NSLayoutConstraint`
*/
+ (NSLayoutConstraint *)constraintCenterYOfView:(UIView *)view1 inView:(UIView *)view2;

/// -------------------------------
/// @name Positioning and Alignment
/// -------------------------------

/**
* A constraint to align the top edges of two views
*
* @param view1 The view to be aligned
* @param view2 The base view
* @return A constraint that keeps both views top aligned
*/
+ (NSLayoutConstraint *)constraintAlignTopEdgeOfView:(UIView *)view1 withView:(UIView *)view2;
/**
* A constraint to align the right edges of two views
*
* @param view1 The view to be aligned
* @param view2 The base view
* @return A constraint that keeps both views right aligned
*/
+ (NSLayoutConstraint *)constraintAlignRightEdgeOfView:(UIView *)view1 withView:(UIView *)view2;
/**
* A constraint to align the bottom edges of two views
*
* @param view1 The view to be aligned
* @param view2 The base view
* @return A constraint that keeps both views bottom aligned
*/
+ (NSLayoutConstraint *)constraintAlignBottomEdgeOfView:(UIView *)view1 withView:(UIView *)view2;
/**
* A constraint to align the left edges of two views
*
* @param view1 The view to be aligned
* @param view2 The base view
* @return A constraint that keeps both views left aligned
*/
+ (NSLayoutConstraint *)constraintAlignLeftEdgeOfView:(UIView *)view1 withView:(UIView *)view2;
/**
* A set of constraints to align all edges of two views
*
* @note Only alignment constraints are used. No width or height constraints are used.
*
* @param view1 The view to be aligned
* @param view2 The base view
* @return An array of constraints that keeps both views in the same position and same size
*/
+ (NSArray *)constraintsAligningAllEdgesOfView:(UIView *)view1 withView:(UIView *)view2;
/**
* A set of constraints that align both sides (leading and trailing) of a view in its superview
*
* This is equivalent in visual format to: `|[view1]|`
*
* @param view1 The view to be aligned
* @return An array of constraints to keep both sides of view1 aligned to its superview
*/
+ (NSArray *)constraintsAligningBothSidesOfViewInItsSuperview:(UIView *)view1;

@end
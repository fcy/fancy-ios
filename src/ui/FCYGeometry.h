#import <Foundation/NSObjCRuntime.h>

/**
 * @file FCYGeometry.h
 * A collection of C functions to make the code less verbose when dealing with CGGeometry structures.
 *
 * @author Felipe Cypriano
 * @date 2011
 */

/**
 * Changes the size of a CGRect by adding or subtracting width and height.
 *
 * This function works like CGRectOffset, but instead of changing the position
 * it changes the size.
 *
 * @param rect The base rect
 * @param deltaWidth This number is added to the rect's width. It can be negative
 * @param deltaHeight This number is added to the rect's height. It can be negative
 */
CGRect FCYCGRectAdjustSizeBy(CGRect rect, CGFloat deltaWidth, CGFloat deltaHeight);

/**
 * Set a new height to a CGRect
 *
 * @param rect The base rect
 * @param height This is number will be the absolute height of the returned rect
 */
NS_INLINE CGRect FCYCGRectSetHeight(CGRect rect, CGFloat height) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
}

/**
 * Set a new width to a CGRect
 *
 * @param rect The base rect
 * @param height This is number will be the absolute width of the returned rect
 */
NS_INLINE CGRect FCYCGRectSetWidth(CGRect rect, CGFloat width) {
    return CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
}

/**
 * Changes the size of a CGRect to the width and height of CGSize.
 *
 * @param rect The base rect
 * @param size The new size
 */
NS_INLINE CGRect FCYCGRectSetSize(CGRect rect, CGSize size) {
    return CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
}

/**
 * Changes the size of a CGRect to the width and height.
 *
 * @param rect The base rect
 * @param width The new width
 * @param height The new height
 */
NS_INLINE CGRect FCYCGRectSetSizeMake(CGRect rect, CGFloat width, CGFloat height) {
    return CGRectMake(rect.origin.x, rect.origin.y, width, height);
}

/**
 * Set a new CGPoint as origin of a CGRect
 *
 * Unline CGRectOffset this function actually set an absolute position,
 * instead of adding/subtracting.
 *
 * @param rect The base CGRect
 * @param x This will be the new origin.x
 * @param y This will be the new origin.y
 */
NS_INLINE CGRect FCYCGRectSetPosition(CGRect rect, CGFloat x, CGFloat y) {
    return CGRectMake(x, y, rect.size.width, rect.size.height);
}

/**
 * Set a new origin.x to a CGRect
 *
 * @param rect The base rect
 * @param height This is number will be the new origin.x
 */
NS_INLINE CGRect FCYCGRectSetPositionX(CGRect rect, CGFloat x) {
    return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}

/**
 * Set a new origin.y to a CGRect
 *
 * @param rect The base rect
 * @param height This is number will be the new origin.y
 */
NS_INLINE CGRect FCYCGRectSetPositionY(CGRect rect, CGFloat y) {
    return CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
}

/**
 * Returns the last horizontal point of a rect
 *
 * Returns CGRect.origin.x + CGRect.size.width
 * 
 * @param rect The rect of what the value will be obtained
 */
NS_INLINE CGFloat FCYCGRectHorizontalEndValue(CGRect rect) {
    return rect.origin.x + rect.size.width;
}

/**
 * Returns the center point of a CGRect
 *
 * @param rect The rect that you want the center point
 */
CGPoint FCYCenterPointOfRect(CGRect rect);
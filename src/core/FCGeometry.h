//    Copyright 2011 Felipe Cypriano
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//        http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

#import <Foundation/NSObjCRuntime.h>

/**
 * @file FCGeometry.h
 * @brief A collection of C functions to make the code less verbose when dealing with CGGeometry structures.
 *
 * @author Felipe Cypriano
 * @date 2011
 */

/**
 * @brief Changes the size of a CGRect by adding or subtracting width and height.
 *
 * This function works like CGRectOffset, but instead of changing the position
 * it changes the size.
 *
 * @param rect The base rect
 * @param deltaWidth This number is added to the rect's width. It can be negative
 * @param deltaHeight This number is added to the rect's height. It can be negative
 */
CGRect FCCGRectAdjustSizeBy(CGRect rect, CGFloat deltaWidth, CGFloat deltaHeight);

/**
 * @brief Set a new height to a CGRect
 *
 * @param rect The base rect
 * @param height This is number will be the absolute height of the returned rect
 */
NS_INLINE CGRect FCCGRectSetHeight(CGRect rect, CGFloat height) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
}

/**
 * @brief Set a new width to a CGRect
 *
 * @param rect The base rect
 * @param height This is number will be the absolute width of the returned rect
 */
NS_INLINE CGRect FCCGRectSetWidth(CGRect rect, CGFloat width) {
    return CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
}

/**
 * @brief Changes the size of a CGRect to the width and height of CGSize.
 *
 * @param rect The base rect
 * @param size The new size
 */
NS_INLINE CGRect FCCGRectSetSize(CGRect rect, CGSize size) {
    return CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
}

/**
 * @brief Changes the size of a CGRect to the width and height.
 *
 * @param rect The base rect
 * @param width The new width
 * @param height The new height
 */
NS_INLINE CGRect FCCGRectSetSizeMake(CGRect rect, CGFloat width, CGFloat height) {
    return CGRectMake(rect.origin.x, rect.origin.y, width, height);
}

/**
 * @brief Set a new CGPoint as origin of a CGRect
 *
 * Unline CGRectOffset this function actually set an absolute position,
 * instead of adding/subtracting.
 *
 * @param rect The base CGRect
 * @param x This will be the new origin.x
 * @param y This will be the new origin.y
 */
NS_INLINE CGRect FCCGRectSetPosition(CGRect rect, CGFloat x, CGFloat y) {
    return CGRectMake(x, y, rect.size.width, rect.size.height);
}

/**
 * @brief Set a new origin.x to a CGRect
 *
 * @param rect The base rect
 * @param height This is number will be the new origin.x
 */
NS_INLINE CGRect FCCGRectSetPositionX(CGRect rect, CGFloat x) {
    return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}

/**
 * @brief Set a new origin.y to a CGRect
 *
 * @param rect The base rect
 * @param height This is number will be the new origin.y
 */
NS_INLINE CGRect FCCGRectSetPositionY(CGRect rect, CGFloat y) {
    return CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
}

/**
 * @brief Returns the last horizontal point of a rect
 *
 * Returns CGRect.origin.x + CGRect.size.width
 * 
 * @param rect The rect of what the value will be obtained
 */
NS_INLINE CGFloat FCCGRectHorizontalEndValue(CGRect rect) {
    return rect.origin.x + rect.size.width;
}

/**
 * @brief Returns the center point of a CGRect
 *
 * @param rect The rect that you want the center point
 */
CGPoint FCCenterPointOfRect(CGRect rect);

/**
 * @brief Set a new height to a CGRect
 *
 * @deprecated Use FCCGRectSetHeight instead.
 *
 * @param rect The base rect
 * @param height This is number will be the absolute height of the returned rect
 */
CGRect CGRectSetHeight(CGRect rect, CGFloat height) DEPRECATED_ATTRIBUTE;

/**
 * @brief Set a new width to a CGRect
 *
 * @deprecated Use FCCGRectSetWidth instead.
 *
 * @param rect The base rect
 * @param height This is number will be the absolute width of the returned rect
 */
CGRect CGRectSetWidth(CGRect rect, CGFloat width) DEPRECATED_ATTRIBUTE;

/**
 * @brief Changes the size of a CGRect to the width and height.
 *
 * @deprecated Use FCCGRectSetSizeMake instead.
 *
 * @param rect The base rect
 * @param width The new width
 * @param height The new height
 */
CGRect CGRectSetSize(CGRect rect, CGFloat width, CGFloat height) DEPRECATED_ATTRIBUTE;

/**
 * @brief Set a new CGPoint as origin of a CGRect
 *
 * Unline CGRectOffset this function actually set an absolute position,
 * instead of adding/subtracting.
 *
 * @deprecated Use FCCGRectSetPosition instead.
 *
 * @param rect The base CGRect
 * @param x This will be the new origin.x
 * @param y This will be the new origin.y
 */
CGRect CGRectSetPosition(CGRect rect, CGFloat x, CGFloat y) DEPRECATED_ATTRIBUTE;

/**
 * @brief Set a new origin.x to a CGRect
 *
 * @deprecated Use FCCGRectSetPositionX instead.
 *
 * @param rect The base rect
 * @param height This is number will be the new origin.x
 */
CGRect CGRectSetPositionX(CGRect rect, CGFloat x) DEPRECATED_ATTRIBUTE;

/**
 * @brief Set a new origin.y to a CGRect
 *
 * @deprecated Use FCCGRectSetPositionY instead.
 *
 * @param rect The base rect
 * @param height This is number will be the new origin.y
 */
CGRect CGRectSetPositionY(CGRect rect, CGFloat y) DEPRECATED_ATTRIBUTE;

/**
 * @brief Changes the size of a CGRect by adding or subtracting width and height.
 *
 * This function works like CGRectOffset, but instead of changing the position
 * it changes the size.
 *
 * @deprecated Use FCCGRectAdjustSizeBy instead.
 *
 * @param rect The base rect
 * @param deltaWidth This number is added to the rect's width. It can be negative
 * @param deltaHeight This number is added to the rect's height. It can be negative
 */
CGRect CGRectChangeSize(CGRect rect, CGFloat deltaWidth, CGFloat deltaHeight) DEPRECATED_ATTRIBUTE;

/**
 * @deprecated Use FCCGRectHorizontalEndPoint instead.
 */
CGFloat CGRectEndValue(CGRect rect) DEPRECATED_ATTRIBUTE;

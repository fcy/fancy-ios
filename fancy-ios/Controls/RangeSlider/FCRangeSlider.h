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

/**
 * @file FCRangeSlider.h
 * Range slider class
 *
 * @author Felipe Cypriano
 * @date 2011
 */

#import <Foundation/Foundation.h>

/**
 * @brief Represents the selected range using CGFloat values.
 *
 * The values are absolute, so the start value corresponds to the exact 
 * location where the range start. Unline NSRange the end is where the 
 * range ends and not the length.
 *
 * This component idea was based on @link https://github.com/doukasd/iOS-Components/tree/master/Controls/DoubleSlider Dimitris Doukas' DoubleSlider @endlink
 * @note Depends on FCGeometry.h
 */
typedef struct _FCRangeSliderValue {
    CGFloat start;
    CGFloat end;
} FCRangeSliderValue;


/**
 * @brief A slider to select ranges. It's like UISlider but with two thumbs.
 *
 * A FCRangeSlider is a visual component to select two values within a range. It's always
 * displayed as a horizontal bar and the height is fixed at 30 pixels. It has two indicator,
 * or <strong>thumb</strong> as UISlider calls it, and the user can move them freely to select
 * the range he wants.
 */
@interface FCRangeSlider : UIControl {
@private
    UIImageView *outRangeTrackView;
    UIImageView *inRangeTrackView;
    UIImageView *minimumThumbView;
    UIImageView *maximumThumbView;
    UIImageView *thumbBeingDragged;
    CGFloat trackSliderWidth;
    NSNumberFormatter *roundFormatter;
    BOOL isTracking;
}

/**
 * @brief Contains the mininum allowed value
 *
 * If the change causes the current rangeValue.start to be below the new minimum value,
 * it will be adjusted to match the new minimum value automatically.
 *
 * If acceptOnlyNonFractionValues is set to YES the value will be rounded to its nearest
 * integer automatically.
 *
 * The default value is 0.0
 *
 */
@property (nonatomic) CGFloat minimumValue;
/**
 * @brief Contains the maximum allowed value
 *
 * If the change causes the current rangeValue.end to be above the new maximum value,
 * it will be adjusted to match the new maximum value automatically.
 *
 * If acceptOnlyNonFractionValues is set to YES the value will be rounded to its nearest
 * integer automatically.
 *
 * The default value is 10.0
 *
 */
@property (nonatomic) CGFloat maximumValue;
/**
 * @brief Contains the selected range represented by NSRange
 *
 * Important this property is only completely reliable if acceptOnlyNonFractionValues is
 * set to YES. Because of the difference between floats and integers. NSRange is always rounded.
 *
 */
@property (nonatomic) NSRange range;
/**
 * @brief Contains the selected range with float values
 *
 * This property contains the exact selected range expressed in float values.
 *
 * If acceptOnlyNonFractionValyes is set to YES the values will be rounded automatically.
 *
 */
@property (nonatomic) FCRangeSliderValue rangeValue;
/**
 * @brief Contains the minimum accepted range length
 *
 * This property contains the minimum length of a range. Setting it to positive value
 * ensures that selected range is at least of a given length. Applies to both
 * positive and negative ranges.
 *
 * If the requested range is smaller than minimumRangeLength, the algorithm is as follows:
 * - only range end is adjusted if it fits within slider scale
 * - only range start is adjusted if range end doesn't fit within slider scale with respect
 *   to given minimumRangeLength
 * - range start is adjusted as little as possible, and then range end is adjusted as needed
 *   when both range ends need to be adjusted
 *
 * The default value is 0.0
 */
@property (nonatomic) CGFloat minimumRangeLength;
/**
 * @brief Controls if only integer values can be selected
 *
 * If this property is set to YES both thumbs will be automatically anchored to it's
 * closest integer value.
 *
 * The default value is NO
 */
@property (nonatomic) BOOL acceptOnlyNonFractionValues;
/**
 * @brief Controls if only positive ranges (start >= end) can be selected
 *
 * If this property is set to YES slider will not allow for setting end thumb before
 * the start thumb.
 *
 * The default value is NO
 */
@property (nonatomic) BOOL acceptOnlyPositiveRanges;
/**
 * @brief A image to represent the values outside the selected range
 *
 * You should correctly set the UIImage's stretchableImageWithLeftCapWidth:topCapHeight:
 * to get a perfect visual.
 */
- (void)setOutRangeTrackImage:(UIImage *)image;
/**
 * @brief A image to represent the selected range
 */
- (void)setInRangeTrackImage:(UIImage *)image;
/**
 * @brief A image to represent both thumbs, or indicators.
 *
 * @param image The image
 * @param state The state when the image will be show. Currently only 
 * UIControlStateNormal and UIControlStateHighlighted are supported.
 */
- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;

/**
 * @brief Sets the receiver’s current rangeValue, allowing you to animate the change visually.
 *
 * @param newRangeValue The new rangeValue
 * @param animated Specify whether the change will be animated or not
 */
- (void)setRangeValue:(FCRangeSliderValue)newRangeValue animated:(BOOL)animated;
/**
 * @brief Sets the receiver’s current range, allowing you to animate the change visually.
 *
 * @param newRange The new range
 * @param animated Specify whether the change will be animated or not
 */
- (void)setRange:(NSRange)newRange animated:(BOOL)animated;

@end

/**
 * @brief Creates a new FCRangeSliderValue
 */
NS_INLINE FCRangeSliderValue FCRangeSliderValueMake(CGFloat start, CGFloat end) {
    FCRangeSliderValue r;
    r.start = start;
    r.end = end;
    return r;
}

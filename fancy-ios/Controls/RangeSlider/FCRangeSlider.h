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

/*
 This component idea was based on Dimitris Doukas' DoubleSlider
 You can find the original code here: https://github.com/doukasd/iOS-Components/tree/master/Controls/DoubleSlider [SHA1 de375a9e]

 Dependencies:
   - FCGeometry.h
 */

#import <Foundation/Foundation.h>

/**
 * @brief Represents the selected range using CGFloat values.
 *
 * The values are absolute, so the start value corresponds to the exact 
 * location where the range start. Unline NSRange the end is where the 
 * range ends and not the length.
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
}

/**
 * @brief Contains the mininum allowed value
 *
 * The default value is 0.0
 *
 * @todo Implement the setter
 */
@property (nonatomic) CGFloat minimumValue;
/**
 * @brief Contains the maximum allowed value
 *
 * The default value is 10.0
 *
 * @todo Implement the setter
 */
@property (nonatomic) CGFloat maximumValue;
/**
 * @brief Contains the selected range represented by NSRange
 *
 * @todo Implement the setter
 */
@property (nonatomic) NSRange range;
/**
 * @brief Contains the selected range
 *
 * @todo Implement the setter
 */
@property (nonatomic) FCRangeSliderValue rangeValue;
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

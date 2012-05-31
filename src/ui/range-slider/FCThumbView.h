//    Copyright 2012 Felipe Cypriano
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
 * @file FCThumbView.h
 * Thumb view class
 *
 * @author Felipe Cypriano
 * @date 2012
 */

#import <Foundation/Foundation.h>

/**
 * @brief Draws a thumb to be used in the slider
 *
 * This view is used as the default thumb in FCRangeSlider. And it has a fixed size of 24 x 24 points.
 *
 * You can use the image and highlightedImage properties to customize the thumb.
 *
 * @note Depends on FancyCore
 */
@interface FCThumbView : UIView

/**
 * @brief Returns the thumb's size
 *
 * Size is 24 x 24 points.
 */
+ (CGSize)size;

/**
 * @brief When highlighted the thumb is displayed a little darker
 *
 * Thumb is darker or the highlightedImage is displayed.
 */
@property (nonatomic) BOOL highlighted;

/**
 * @brief The image to customize the thumb in normal state
 *
 * The image size must be 24 x 24 points
 */
@property (nonatomic, strong) UIImage *image;

/**
 * @brief The image to customize the thumb in highlighted state
 *
 * The image size must be 24 x 24 points
 */
@property (nonatomic, strong) UIImage *highlightedImage;


@end
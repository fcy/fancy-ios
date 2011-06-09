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

typedef struct _FCRangeSliderValue {
    CGFloat start;
    CGFloat end;
} FCRangeSliderValue;


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

@property (nonatomic) CGFloat minimumValue;
@property (nonatomic) CGFloat maximumValue;
@property (nonatomic) NSRange range;
@property (nonatomic) FCRangeSliderValue rangeValue;
@property (nonatomic) BOOL acceptOnlyNonFractionValues;

- (void)setOutRangeTrackImage:(UIImage *)image;
- (void)setInRangeTrackImage:(UIImage *)image;
- (void)setThumbImage:(UIImage *)image;


@end


NS_INLINE FCRangeSliderValue FCRangeSliderValueMake(CGFloat start, CGFloat end) {
    FCRangeSliderValue r;
    r.start = start;
    r.end = end;
    return r;
}

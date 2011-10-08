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

#import <UIKit/UIKit.h>
#import "FCRangeSlider.h"

/**
 * @brief UIViewController to demonstrate how to use FCRangeSlider
 *
 * @image html FCRangeSliderSampleController.png "Shows the FCRangeSlider in action"
 */
@interface FCRangeSliderSampleController : UIViewController {
    
    UILabel *lblMinimumValue;
    UILabel *lblMaximumValue;
}

+ (FCRangeSliderSampleController *)rangeSliderSampleController;

@property (nonatomic, retain) IBOutlet FCRangeSlider *slider;
@property (nonatomic, retain) IBOutlet UILabel *lblRange;
@property (nonatomic, retain) IBOutlet UILabel *lblRangeValue;
@property (nonatomic, retain) IBOutlet UILabel *lblMinimumValue;
@property (nonatomic, retain) IBOutlet UILabel *lblMaximumValue;
@property (nonatomic, retain) IBOutlet UILabel *lblMinimumRangeLength;

- (IBAction)onlyNonFractionValueChanged:(id)sender;
- (IBAction)onlyPositiveRangeValueChanged:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)minimumValueChanged:(id)sender;
- (IBAction)maximumValueChanged:(id)sender;
- (IBAction)minimumRangeLengthChanged:(id)sender;
- (IBAction)resetSameValueTouched:(id)sender;

@end

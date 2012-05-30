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

#import "RangeSliderController.h"


@implementation RangeSliderController

@synthesize lblRangeValue;
@synthesize lblMinimumValue;
@synthesize lblMaximumValue;
@synthesize lblMinimumRangeLength;
@synthesize slider;
@synthesize lblRange;

+ (RangeSliderController *)rangeSliderSampleController {
    return [[RangeSliderController alloc] init];
}

- (IBAction)onlyNonFractionValueChanged:(id)sender {
    slider.acceptOnlyNonFractionValues = [sender isOn];
}

- (IBAction)onlyPositiveRangeValueChanged:(id)sender {
    slider.acceptOnlyPositiveRanges = [sender isOn];
}

- (IBAction)sliderValueChanged:(FCRangeSlider *)sender {
    lblRangeValue.text = [NSString stringWithFormat:@"{%f, %f}", sender.rangeValue.start, sender.rangeValue.end];
    lblRange.text = NSStringFromRange(sender.range);
}

- (IBAction)minimumValueChanged:(UISlider *)sender {
    slider.minimumValue = [sender value];
    lblMinimumValue.text = [NSString stringWithFormat:@"minimumValue %f", slider.minimumValue];
}

- (IBAction)maximumValueChanged:(UISlider *)sender {
    slider.maximumValue = [sender value];
    lblMaximumValue.text = [NSString stringWithFormat:@"maximumValue %f", slider.maximumValue];
}

- (IBAction)minimumRangeLengthChanged:(UISlider *)sender {
    slider.minimumRangeLength = [sender value];
    lblMinimumRangeLength.text = [NSString stringWithFormat:@"minimumRangeLength %f", slider.minimumRangeLength];
}

- (IBAction)resetSameValueTouched:(id)sender {
    slider.rangeValue = FCRangeSliderValueMake(3, 6);
}

- (id)init {
    self = [super initWithNibName:@"RangeSlider" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [self init];
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [slider setThumbImage:[UIImage imageNamed:@"slider_thumb_highlighted"] forState:UIControlStateHighlighted];
    [self sliderValueChanged:slider];
}


- (void)viewDidUnload {
    [self setLblRange:nil];
    [self setLblRangeValue:nil];
    [self setSlider:nil];
    [self setLblMinimumValue:nil];
    [self setLblMaximumValue:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

@end

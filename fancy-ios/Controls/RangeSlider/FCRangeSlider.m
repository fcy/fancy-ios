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

#import "FCRangeSlider.h"

#define FIXED_HEIGHT 30.0f

@implementation FCRangeSlider

@synthesize minimumValue;
@synthesize maximumValue;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, FIXED_HEIGHT)];
    if (self) {
        minimumValue = 0.0f;
        maximumValue = 100.0f;
        
        outRangeTrackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 10)];
        outRangeTrackView.contentMode = UIViewContentModeScaleToFill;
        outRangeTrackView.backgroundColor = [UIColor darkGrayColor];
        outRangeTrackView.layer.cornerRadius = 5;
        [self addSubview:outRangeTrackView];

        inRangeTrackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 10)];
        inRangeTrackView.contentMode = UIViewContentModeScaleToFill;
        inRangeTrackView.backgroundColor = [UIColor blueColor];
        inRangeTrackView.layer.cornerRadius = 5;
        [self addSubview:inRangeTrackView];
        
        minimumThumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, FIXED_HEIGHT)];
        [self addSubview:minimumThumbView];

        maximumThumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, FIXED_HEIGHT)];
        [self addSubview:maximumThumbView];
    }
    return self;
}

- (void)dealloc {
    [minimumThumbView release];
    [inRangeTrackView release];
    [outRangeTrackView release];
    [super dealloc];
}

@end

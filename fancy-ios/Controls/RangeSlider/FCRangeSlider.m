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
        UIPanGestureRecognizer *minPanGesture = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(draggingThumb:)] autorelease];
        [minimumThumbView addGestureRecognizer:minPanGesture];

        maximumThumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, FIXED_HEIGHT)];
        [self addSubview:maximumThumbView];
        UIPanGestureRecognizer *maxPanGesture = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(draggingThumb:)] autorelease];
        [maximumThumbView addGestureRecognizer:maxPanGesture];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectSetHeight(self.frame, FIXED_HEIGHT);
    }
    return self;
}

- (void)dealloc {
    [minimumThumbView release];
    [inRangeTrackView release];
    [outRangeTrackView release];
    [super dealloc];
}

- (void)setFrame:(CGRect)newFrame {
    [super setFrame:CGRectSetHeight(newFrame, FIXED_HEIGHT)];
}

#pragma mark -
#pragma mark Drag handling

- (void)draggingThumb:(UIPanGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        thumbBeingDragged = [gestureRecognizer view];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateChanged || [gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        CGPoint translation = [gestureRecognizer translationInView:[thumbBeingDragged superview]];
        
        CGFloat xOffset = translation.x - thumbBeingDragged.frame.origin.x;
        thumbBeingDragged.frame = CGRectOffset(thumbBeingDragged.frame, xOffset, 0);
        
    } else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        thumbBeingDragged = nil;
    }
}

@end

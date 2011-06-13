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

@interface FCRangeSlider (Private)
- (void)clipThumbToBounds;
- (void)updateInRangeTrackView;
- (void)swtichThumbsPositionIfNecessary;
- (void)updateRangeValue;
- (void)setThumbsPositionToNonFractionValues;
@end

@implementation FCRangeSlider

@synthesize minimumValue;
@synthesize maximumValue;
@synthesize range;
@synthesize rangeValue;
@synthesize acceptOnlyNonFractionValues;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, FIXED_HEIGHT)];
    if (self) {
        minimumValue = 0.0f;
        maximumValue = 5.0f;
        acceptOnlyNonFractionValues = NO;
        
        UIImage *thumbImage = [UIImage imageNamed:@"slider_thumb"];
        CGFloat thumbCenter = thumbImage.size.width / 2;
        trackSliderWidth = frame.size.width - thumbImage.size.width;
        
        outRangeTrackView = [[UIImageView alloc] initWithFrame:CGRectMake(thumbCenter, 10, trackSliderWidth, 10)];
        outRangeTrackView.contentMode = UIViewContentModeScaleToFill;
        outRangeTrackView.backgroundColor = [UIColor darkGrayColor];
        outRangeTrackView.layer.cornerRadius = 5;
        [self addSubview:outRangeTrackView];

        inRangeTrackView = [[UIImageView alloc] initWithFrame:CGRectMake(thumbCenter, 10, trackSliderWidth, 10)];
        inRangeTrackView.contentMode = UIViewContentModeScaleToFill;
        inRangeTrackView.backgroundColor = [UIColor blueColor];
        inRangeTrackView.layer.cornerRadius = 5;
        [self addSubview:inRangeTrackView];
        
        minimumThumbView = [[UIImageView alloc] initWithImage:thumbImage];
        minimumThumbView.frame = CGRectSetPosition(minimumThumbView.frame, 0, 3);
        [self addSubview:minimumThumbView];

        maximumThumbView = [[UIImageView alloc] initWithImage:thumbImage];
        maximumThumbView.frame = CGRectSetPosition(minimumThumbView.frame, frame.size.width - 24, 3);
        [self addSubview:maximumThumbView];
        
		roundFormatter = [[NSNumberFormatter alloc] init];
		[roundFormatter setMaximumFractionDigits:0];
		[roundFormatter setRoundingMode:NSNumberFormatterRoundHalfEven];
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

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            minimumThumbView.image = image;
            maximumThumbView.image = image;
            break;
        case UIControlStateHighlighted:
            minimumThumbView.highlightedImage = image;
            maximumThumbView.highlightedImage = image;
        default:
            break;
    }
}

- (void)setOutRangeTrackImage:(UIImage *)image {
    outRangeTrackView.backgroundColor = [UIColor clearColor];
    outRangeTrackView.layer.cornerRadius = 0;
    outRangeTrackView.image = image;
}

- (void)setInRangeTrackImage:(UIImage *)image {
    inRangeTrackView.backgroundColor = [UIColor clearColor];
    inRangeTrackView.layer.cornerRadius = 0;
    inRangeTrackView.image = image;    
}

#pragma mark -
#pragma mark Drag handling

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    if (CGRectContainsPoint(minimumThumbView.frame, touchPoint)) {
        thumbBeingDragged = minimumThumbView;
    } else if (CGRectContainsPoint(maximumThumbView.frame, touchPoint)) {
        thumbBeingDragged = maximumThumbView;
    } else {
        [self cancelTrackingWithEvent:event];
        thumbBeingDragged = nil;
        return NO;
    }
    
    thumbBeingDragged.highlighted = YES;
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (thumbBeingDragged) {
        CGPoint touchPoint = [touch locationInView:self];
        thumbBeingDragged.center = CGPointMake(touchPoint.x, thumbBeingDragged.center.y);
        [self clipThumbToBounds];
        [self swtichThumbsPositionIfNecessary];
        [self updateInRangeTrackView];
        
        [self updateRangeValue];
        return YES;
    } else {
        return NO;
    }
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (acceptOnlyNonFractionValues) {
        [self setThumbsPositionToNonFractionValues];
        [self updateRangeValue];
    }
    
    thumbBeingDragged.highlighted = NO;
    thumbBeingDragged = nil;
}

#pragma mark -
#pragma mark Private methods

- (void)clipThumbToBounds {
    if (thumbBeingDragged.frame.origin.x < 0) {
        thumbBeingDragged.frame = CGRectSetPositionX(thumbBeingDragged.frame, 0);
    } else if (thumbBeingDragged.frame.origin.x + thumbBeingDragged.bounds.size.width > self.bounds.size.width) {
        thumbBeingDragged.frame = CGRectSetPositionX(thumbBeingDragged.frame, self.bounds.size.width - thumbBeingDragged.bounds.size.width);
    }    
}

- (void)swtichThumbsPositionIfNecessary {
    if (thumbBeingDragged == minimumThumbView && thumbBeingDragged.frame.origin.x >= CGRectEndValue(maximumThumbView.frame)) {
        minimumThumbView = maximumThumbView;
        maximumThumbView = thumbBeingDragged;
    } else if (thumbBeingDragged == maximumThumbView && CGRectEndValue(thumbBeingDragged.frame) <= minimumThumbView.frame.origin.x) {
        maximumThumbView = minimumThumbView;
        minimumThumbView = thumbBeingDragged;
    }
}

- (void)updateInRangeTrackView {
    CGFloat newX = minimumThumbView.frame.origin.x;
    CGFloat newWidth = maximumThumbView.frame.origin.x + maximumThumbView.bounds.size.width - newX;
    inRangeTrackView.frame = CGRectMake(newX, inRangeTrackView.frame.origin.y, newWidth, inRangeTrackView.bounds.size.height);
}

- (void)updateRangeValue {
    CGFloat valueSpan = maximumValue - minimumValue;
    CGPoint minPointInTrack = [self convertPoint:minimumThumbView.center toView:outRangeTrackView];
    CGFloat min = minimumValue + minPointInTrack.x / trackSliderWidth * valueSpan;

    CGPoint maxPointInTrack = [self convertPoint:maximumThumbView.center toView:outRangeTrackView];
    CGFloat max = minimumValue + maxPointInTrack.x /trackSliderWidth * valueSpan;
    
    rangeValue = FCRangeSliderValueMake(min, max);

    NSInteger minInt = [[roundFormatter numberFromString:[roundFormatter stringFromNumber:[NSNumber numberWithFloat:min]]] integerValue];
    NSInteger maxInt = [[roundFormatter numberFromString:[roundFormatter stringFromNumber:[NSNumber numberWithFloat:max]]] integerValue];
    range = NSMakeRange(minInt, maxInt - minInt);
    //NSLog(@"%f %f | %d %d", rangeValue.start, rangeValue.end, range.location, range.length);
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setThumbsPositionToNonFractionValues {
    CGFloat valueSpan = maximumValue - minimumValue;
    NSInteger currentMinValue = range.location - minimumValue;
    NSInteger currentMaxValue = range.location + range.length - minimumValue;
    
    CGFloat minPointXInTrack = trackSliderWidth / valueSpan * currentMinValue;
    CGPoint minCenter = [self convertPoint:CGPointMake(minPointXInTrack, 0) fromView:outRangeTrackView];
    
    CGFloat maxPoinXtInTrack = trackSliderWidth / valueSpan * currentMaxValue;
    CGPoint maxCenter = [self convertPoint:CGPointMake(maxPoinXtInTrack, 0) fromView:outRangeTrackView];
    
    [UIView animateWithDuration:0.3 animations:^{
        minimumThumbView.center = CGPointMake(minCenter.x, minimumThumbView.center.y);
        maximumThumbView.center = CGPointMake(maxCenter.x, maximumThumbView.center.y);
        
        [self updateInRangeTrackView];
    }];
}

@end

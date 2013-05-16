#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "FCYRangeSlider.h"
#import "FCYGeometry.h"
#import "FCYThumbView.h"

#define FIXED_HEIGHT 30.0f

@interface FCYRangeSlider (Private)

- (void)clipThumbToBounds;
- (void)updateInRangeTrackView;
- (void)switchThumbsPositionIfNecessary;
- (void)updateRangeValue;
- (void)setThumbsPositionToNonFractionValues;
- (NSNumber *)roundValueFloat:(CGFloat)value;
- (void)updateThumbsPositionAnimated:(BOOL)animated;
- (void)safelySetMinMaxValues;

@end

@implementation FCYRangeSlider {
    UIImageView *_outRangeTrackView;
    UIImageView *_inRangeTrackView;
    FCYThumbView *_minimumThumbView;
    FCYThumbView *_maximumThumbView;
    FCYThumbView *_thumbBeingDragged;
    CGFloat _trackSliderWidth;
    NSNumberFormatter *_roundFormatter;
    BOOL _isTracking;
    CGFloat _endPointMin;
    CGFloat _endPointMax;
    CGFloat _intrinsicProportion;
}

@synthesize minimumValue = _minimumValue;
@synthesize maximumValue = _maximumValue;
@synthesize range = _range;
@synthesize rangeValue = _rangeValue;
@synthesize minimumRangeLength = _minimumRangeLength;
@synthesize acceptOnlyNonFractionValues = _acceptOnlyNonFractionValues;
@synthesize acceptOnlyPositiveRanges = _acceptOnlyPositiveRanges;

- (void)initialize {
    _minimumValue = 0.0f;
    _maximumValue = 10.0f;
    _acceptOnlyNonFractionValues = NO;
    _acceptOnlyPositiveRanges = NO;
    _minimumRangeLength = 0.0f;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];

    _outRangeTrackView = [UIImageView new];
    _outRangeTrackView.contentMode = UIViewContentModeScaleToFill;
    _outRangeTrackView.backgroundColor = [UIColor darkGrayColor];
    _outRangeTrackView.layer.cornerRadius = 5;
    [self addSubview:_outRangeTrackView];

    _inRangeTrackView = [UIImageView new];
    _inRangeTrackView.contentMode = UIViewContentModeScaleToFill;
    _inRangeTrackView.backgroundColor = [UIColor blueColor];
    _inRangeTrackView.layer.cornerRadius = 5;
    [self addSubview:_inRangeTrackView];

    CGFloat thumbYPosition = (FIXED_HEIGHT / 2) - ([FCYThumbView size].height / 2);
    _minimumThumbView = [[FCYThumbView alloc] init];
    _minimumThumbView.frame = CGRectOffset(_minimumThumbView.frame, 0, thumbYPosition);
    [self addSubview:_minimumThumbView];

    _maximumThumbView = [[FCYThumbView alloc] init];
    _maximumThumbView.frame = FCYCGRectSetPosition(_minimumThumbView.frame, self.frame.size.width - [FCYThumbView size].width, thumbYPosition);
    _maximumThumbView.frame = FCYCGRectSetHeight(_maximumThumbView.frame, self.frame.size.height);
    _maximumThumbView.contentMode = UIViewContentModeCenter;
    [self addSubview:_maximumThumbView];

    _roundFormatter = [[NSNumberFormatter alloc] init];
    [_roundFormatter setMaximumFractionDigits:0];
    [_roundFormatter setRoundingMode:NSNumberFormatterRoundHalfEven];

    [self updateIntrinsicProportion];
    self.rangeValue = FCYRangeSliderValueMake(_minimumValue, _maximumValue);
}

- (id)init {
    self = [self initWithFrame:CGRectMake(0, 0, 100, FIXED_HEIGHT)];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:FCYCGRectSetHeight(frame, FIXED_HEIGHT)];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = FCYCGRectSetHeight(self.frame, FIXED_HEIGHT);
        [self initialize];
    }
    return self;
}


- (void)setFrame:(CGRect)newFrame {
    [super setFrame:FCYCGRectSetHeight(newFrame, FIXED_HEIGHT)];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat thumbCenter = [FCYThumbView size].width / 2;
    _trackSliderWidth = self.bounds.size.width - [FCYThumbView size].width;
    _outRangeTrackView.frame = CGRectMake(thumbCenter, 10, _trackSliderWidth, 10);
    _inRangeTrackView.frame = CGRectMake(thumbCenter, 10, _trackSliderWidth, 10);

    [self updateIntrinsicProportion];
    [self updateThumbsPositionAnimated:NO];
}

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        [self setThumbsImage:image];
    } else if (state == UIControlStateHighlighted) {
        [self setThumbsHighlightedImage:image];
    }
}

- (void)setOutRangeTrackImage:(UIImage *)image {
    _outRangeTrackView.backgroundColor = [UIColor clearColor];
    _outRangeTrackView.layer.cornerRadius = 0;
    _outRangeTrackView.image = image;
}

- (void)setInRangeTrackImage:(UIImage *)image {
    _inRangeTrackView.backgroundColor = [UIColor clearColor];
    _inRangeTrackView.layer.cornerRadius = 0;
    _inRangeTrackView.image = image;
}

#pragma mark -
#pragma mark Value Setters

- (void)setMinimumValue:(CGFloat)newMinimumValue {
    _minimumValue = _acceptOnlyNonFractionValues ? [[self roundValueFloat:newMinimumValue] floatValue] : newMinimumValue;
    [self safelySetMinMaxValues];
    [self updateIntrinsicProportion];
    [self constrainRangeValueToMinMaxValues];
}

- (void)setMaximumValue:(CGFloat)newMaximumValue {
    _maximumValue = _acceptOnlyNonFractionValues ? [[self roundValueFloat:newMaximumValue] floatValue] : newMaximumValue;
    [self safelySetMinMaxValues];
    [self updateIntrinsicProportion];
    [self constrainRangeValueToMinMaxValues];
}

- (void)constrainRangeValueToMinMaxValues {
    if (_rangeValue.start >= _minimumValue && _rangeValue.end <= _maximumValue) {
        [self updateThumbsPositionAnimated:YES];
    } else {
        CGFloat start = MIN(_rangeValue.start, _minimumValue);
        CGFloat end = MIN(_rangeValue.end, _maximumValue);

        self.rangeValue = FCYRangeSliderValueMake(start, end);
    }
}

- (void)setMinimumRangeLength:(CGFloat)newMinimumRangeLength {
    _minimumRangeLength = newMinimumRangeLength;

    if (fabs(_rangeValue.end - _rangeValue.start) < _minimumRangeLength) {
        [self setRangeValue:self.rangeValue animated:YES];
    }
}

- (void)setRangeValue:(FCYRangeSliderValue)newRangeValue {
    [self setRangeValue:newRangeValue animated:NO];
}

- (void)setRange:(NSRange)newRange {
    [self setRange:newRange animated:NO];
}

- (void)setRangeValue:(FCYRangeSliderValue)newRangeValue animated:(BOOL)animated {
    CGFloat safeStart = MAX(newRangeValue.start, _minimumValue);
    CGFloat safeEnd = MIN(newRangeValue.end, _maximumValue);

    if (_acceptOnlyPositiveRanges && safeEnd < safeStart) {
        return;
    }

    if (_acceptOnlyNonFractionValues) {
        safeStart = [[self roundValueFloat:safeStart] floatValue];
        safeEnd = [[self roundValueFloat:safeEnd] floatValue];
    }

    void (^adjustForMinimumRangeLength)(CGFloat *, CGFloat *) = ^(CGFloat *start, CGFloat *end) {
        if (*start + _minimumRangeLength < _maximumValue) {
            *end = *start + _minimumRangeLength;
        } else if (*end - _minimumRangeLength > _minimumValue) {
            *start = *end - _minimumRangeLength;
        } else {
            *end = _maximumValue;
            *start = MAX(_minimumValue, *end - _minimumRangeLength);
        }
    };

    if (_minimumRangeLength > fabs(safeStart - safeEnd)) {
        if (safeEnd > safeStart) {
            adjustForMinimumRangeLength(&safeStart, &safeEnd);
        } else {
            adjustForMinimumRangeLength(&safeEnd, &safeStart);
        }
    }

    _rangeValue = FCYRangeSliderValueMake(safeStart, safeEnd);

    NSInteger minInt = [[self roundValueFloat:safeStart] integerValue];
    NSInteger maxInt = [[self roundValueFloat:safeEnd] integerValue];
    _range = NSMakeRange(minInt, maxInt - minInt + 1);

    if (!_isTracking) {
        [self updateThumbsPositionAnimated:animated];
    }

    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setRange:(NSRange)newRange animated:(BOOL)animated {
    CGFloat start = [[NSNumber numberWithInteger:newRange.location] floatValue];
    CGFloat end = [[NSNumber numberWithInteger:NSMaxRange(newRange) - 1] floatValue];

    [self setRangeValue:FCYRangeSliderValueMake(start, end) animated:animated];
}

- (void)setAcceptOnlyNonFractionValues:(BOOL)newAcceptOnlyNonFractionValues {
    if (newAcceptOnlyNonFractionValues != _acceptOnlyNonFractionValues && newAcceptOnlyNonFractionValues) {
        [self setRange:_range animated:YES];
        self.minimumValue = [[self roundValueFloat:_minimumValue] floatValue];
        self.maximumValue = [[self roundValueFloat:_maximumValue] floatValue];
    }
    _acceptOnlyNonFractionValues = newAcceptOnlyNonFractionValues;
}

#pragma mark -
#pragma mark Drag handling

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self safelySetMinMaxValues];
    _isTracking = YES;

    CGPoint touchPoint = [touch locationInView:self];
    if (CGRectContainsPoint(_minimumThumbView.frame, touchPoint)) {
        _thumbBeingDragged = _minimumThumbView;
    } else if (CGRectContainsPoint(_maximumThumbView.frame, touchPoint)) {
        _thumbBeingDragged = _maximumThumbView;
    } else {
        [self cancelTrackingWithEvent:event];
        _thumbBeingDragged = nil;
        return NO;
    }

    _thumbBeingDragged.highlighted = YES;
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (_thumbBeingDragged) {
        CGPoint touchPoint = [touch locationInView:self];
        FCYThumbView *otherThumb = (_thumbBeingDragged == _minimumThumbView) ? _maximumThumbView : _minimumThumbView;
        CGFloat otherXCenter = otherThumb.center.x;
        CGFloat xCenter = touchPoint.x;
        CGFloat minimumRangeLengthInPixels = _trackSliderWidth * _minimumRangeLength / (_maximumValue - _minimumValue);
        BOOL updatePosition = YES;
        if (_acceptOnlyPositiveRanges) {
            if ((_thumbBeingDragged == _maximumThumbView && xCenter <= otherXCenter) ||
                    (_thumbBeingDragged == _minimumThumbView && xCenter >= otherXCenter)) {
                updatePosition = NO;
            }
        }
        if (updatePosition && minimumRangeLengthInPixels <= fabs(xCenter - otherThumb.center.x)) {
            _thumbBeingDragged.center = CGPointMake(touchPoint.x, _thumbBeingDragged.center.y);
            [self clipThumbToBounds];
            [self switchThumbsPositionIfNecessary];
            [self updateInRangeTrackView];

            [self updateRangeValue];
        }
        return YES;
    } else {
        return NO;
    }
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    _isTracking = NO;

    if (_acceptOnlyNonFractionValues) {
        [self setThumbsPositionToNonFractionValues];
        [self updateRangeValue];
    }

    _thumbBeingDragged.highlighted = NO;
    _thumbBeingDragged = nil;
}

#pragma mark -
#pragma mark Private methods

- (void)clipThumbToBounds {
    CGFloat centerX = _thumbBeingDragged.center.x;
    if (centerX < _endPointMin) {
        centerX = _endPointMin;
    } else if (centerX > _endPointMax) {
        centerX = _endPointMax;
    }
    _thumbBeingDragged.center = CGPointMake(centerX, _thumbBeingDragged.center.y);
}

- (void)switchThumbsPositionIfNecessary {
    if (_thumbBeingDragged == _minimumThumbView && _thumbBeingDragged.frame.origin.x >= FCYCGRectHorizontalEndValue(_maximumThumbView.frame)) {
        _minimumThumbView = _maximumThumbView;
        _maximumThumbView = _thumbBeingDragged;
    } else if (_thumbBeingDragged == _maximumThumbView && FCYCGRectHorizontalEndValue(_thumbBeingDragged.frame) <= _minimumThumbView.frame.origin.x) {
        _maximumThumbView = _minimumThumbView;
        _minimumThumbView = _thumbBeingDragged;
    }
}

- (void)updateInRangeTrackView {
    CGFloat newX = _minimumThumbView.center.x;
    CGFloat newWidth = _maximumThumbView.frame.origin.x + (_maximumThumbView.bounds.size.width / 2) - newX;
    _inRangeTrackView.frame = CGRectMake(newX, _inRangeTrackView.frame.origin.y, newWidth, _inRangeTrackView.bounds.size.height);
}

- (void)updateRangeValue {
    CGFloat minValue = (_minimumThumbView.center.x - _endPointMin) * _intrinsicProportion + _minimumValue;
    CGFloat maxValue = (_maximumThumbView.center.x - _endPointMin) * _intrinsicProportion + _minimumValue;

    self.rangeValue = FCYRangeSliderValueMake(minValue, maxValue);
}

- (void)setThumbsPositionToNonFractionValues {
    [self setRange:_range animated:YES];
}

- (void)updateThumbsPositionAnimated:(BOOL)animated {
    CGFloat currentMinValue = _rangeValue.start - _minimumValue;
    CGFloat currentMaxValue = _rangeValue.end - _minimumValue;

    CGFloat minCenterX = currentMinValue / _intrinsicProportion + _endPointMin;
    CGFloat maxCenterX = currentMaxValue / _intrinsicProportion + _endPointMin;

    void (^move)(void) = ^{
        _minimumThumbView.center = CGPointMake(minCenterX, _minimumThumbView.center.y);
        _maximumThumbView.center = CGPointMake(maxCenterX, _maximumThumbView.center.y);
        [self updateInRangeTrackView];
    };

    void (^adjustRect)(BOOL) = ^(BOOL finished) {
        _minimumThumbView.frame = CGRectIntegral(_minimumThumbView.frame);
        _maximumThumbView.frame = CGRectIntegral(_maximumThumbView.frame);
    };

    if (animated) {
        [UIView animateWithDuration:.3 animations:move completion:adjustRect];
    } else {
        move();
        adjustRect(YES);
    }
}

- (NSNumber *)roundValueFloat:(CGFloat)value {
    return [_roundFormatter numberFromString:[_roundFormatter stringFromNumber:[NSNumber numberWithFloat:value]]];
}

- (void)safelySetMinMaxValues {
    if (_minimumValue > _maximumValue) {
        CGFloat switchValues = _minimumValue;
        _minimumValue = _maximumValue;
        _maximumValue = switchValues;
    } else if (_maximumValue < _minimumValue) {
        CGFloat switchValues = _maximumValue;
        _maximumValue = _minimumValue;
        _minimumValue = switchValues;
    }
}

- (void)setThumbsImage:(UIImage *)image {
    _minimumThumbView.image = image;
    _maximumThumbView.image = image;
}

- (void)setThumbsHighlightedImage:(UIImage *)image {
    _minimumThumbView.highlightedImage = image;
    _maximumThumbView.highlightedImage = image;
}

- (void)updateIntrinsicProportion {
    _endPointMin = [_outRangeTrackView frame].origin.x;
    _endPointMax = FCYCGRectHorizontalEndValue([_outRangeTrackView frame]);
    _intrinsicProportion = (_maximumValue - _minimumValue) / (_endPointMax - _endPointMin);
}

@end

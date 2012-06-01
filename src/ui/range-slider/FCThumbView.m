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

#import "FCThumbView.h"
#import "FCGeometry.h"

#define THUMB_WIDTH 24.0f
#define THUMB_HEIGHT 24.0f

@implementation FCThumbView {
    UIImageView *_imageView;
}

@synthesize highlighted = _highlighted;

+ (CGSize)size {
    return CGSizeMake(THUMB_WIDTH, THUMB_WIDTH);
}

- (id)init {
    self = [self initWithFrame:CGRectMake(0, 0, THUMB_WIDTH, THUMB_HEIGHT)];
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:FCCGRectSetSize(frame, [FCThumbView size])];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!_imageView) {
        [self drawDefaultThumb];
    }
}

- (void)setFrame:(CGRect)newFrame {
    [super setFrame:FCCGRectSetSize(newFrame, [FCThumbView size])];
}

- (UIImage *)image {
    return [_imageView image];
}

- (void)setImage:(UIImage *)image {
    if (image && image != [self image]) {
        [[self imageView] setImage:image];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    if (_imageView) {
        _imageView.highlighted = highlighted;
    }
    [self setNeedsDisplay];
}

- (UIImage *)highlightedImage {
    return [_imageView highlightedImage];
}

- (void)setHighlightedImage:(UIImage *)highlightedImage {
    if (highlightedImage && highlightedImage != [self highlightedImage]) {
        [[self imageView] setHighlightedImage:highlightedImage];
    }
}

#pragma mark -
#pragma mark Private Methods

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, THUMB_WIDTH, THUMB_HEIGHT)];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.highlighted = _highlighted;
        [self addSubview:_imageView];
        [self setNeedsDisplay];
    }
    return _imageView;
}

- (void)drawDefaultThumb {
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* innerStrokeColor = [UIColor colorWithRed: 0.93 green: 0.93 blue: 0.93 alpha: 1];

    //// Gradient Declarations
    NSArray* insideGradientColors = [NSArray arrayWithObjects:
        (__bridge id)[UIColor grayColor].CGColor,
        (__bridge id)[UIColor colorWithRed: 0.8 green: 0.8 blue: 0.8 alpha: 1].CGColor,
        (__bridge id)[UIColor whiteColor].CGColor, nil];
    CGFloat insideGradientLocations[] = {0, 0.4, 1};
    CGGradientRef insideGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)insideGradientColors, insideGradientLocations);


    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 23, 23)];
    CGContextSaveGState(context);
    [ovalPath addClip];
    CGContextDrawLinearGradient(context, insideGradient, CGPointMake(12, 0.5), CGPointMake(12, 23.5), 0);
    CGContextRestoreGState(context);

    [[UIColor darkGrayColor] setStroke];
    ovalPath.lineWidth = 0.5;
    [ovalPath stroke];


    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(1, 1, 22, 22)];
    [innerStrokeColor setStroke];
    oval2Path.lineWidth = 0.5;
    [oval2Path stroke];

    //// Cleanup
    CGGradientRelease(insideGradient);
    CGColorSpaceRelease(colorSpace);
}

@end
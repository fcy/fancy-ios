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

#import "FCGeometry.h"

CGRect FCCGRectAdjustSizeBy(CGRect rect, CGFloat deltaWidth, CGFloat deltaHeight) {
    CGFloat width = rect.size.width + deltaWidth;
    CGFloat height = rect.size.height + deltaHeight;
    return CGRectMake(rect.origin.x, rect.origin.y, width, height);
}

CGRect CGRectChangeSize(CGRect rect, CGFloat deltaWidth, CGFloat deltaHeight) {
    return FCCGRectAdjustSizeBy(rect, deltaWidth, deltaHeight);
}

CGRect CGRectSetHeight(CGRect rect, CGFloat height) {
    return FCCGRectSetHeight(rect, height);
}

CGRect CGRectSetWidth(CGRect rect, CGFloat width) {
    return FCCGRectSetWidth(rect, width);
}

CGRect CGRectSetSize(CGRect rect, CGFloat width, CGFloat height) {
    return FCCGRectSetSizeMake(rect, width, height);
}

CGRect CGRectSetPosition(CGRect rect, CGFloat x, CGFloat y) {
    return FCCGRectSetPosition(rect, x, y);
}

CGRect CGRectSetPositionX(CGRect rect, CGFloat x) {
    return FCCGRectSetPositionX(rect, x);
}

CGRect CGRectSetPositionY(CGRect rect, CGFloat y) {
    return FCCGRectSetPositionY(rect, y);
}

CGFloat CGRectEndValue(CGRect rect) {
    return FCCGRectHorizontalEndValue(rect);
}

CGPoint FCCenterPointOfRect(CGRect rect) {
    return CGPointMake(rect.size.width / 2, rect.size.height / 2);
}




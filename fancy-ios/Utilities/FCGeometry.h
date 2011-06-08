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

#import <Foundation/NSObjCRuntime.h>

// Just like CGRectOffset but changes the size
NS_INLINE CGRect CGRectChangeSize(CGRect rect, CGFloat deltaWidth, CGFloat deltaHeight) {
    CGFloat width = rect.size.width + deltaWidth;
    CGFloat height = rect.size.height + deltaHeight;
    return CGRectMake(rect.origin.x, rect.origin.y, width, height);
}

NS_INLINE CGRect CGRectSetHeight(CGRect rect, CGFloat height) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
}

NS_INLINE CGRect CGRectSetWidth(CGRect rect, CGFloat width) {
    return CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
}

NS_INLINE CGRect CGRectSetPosition(CGRect rect, CGFloat x, CGFloat y) {
    return CGRectMake(x, y, rect.size.width, rect.size.height);
}

NS_INLINE CGRect CGRectSetPositionX(CGRect rect, CGFloat x) {
    return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}

NS_INLINE CGRect CGRectSetPositionY(CGRect rect, CGFloat y) {
    return CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
}

// Returns the value for the end of the rect. That's x + width
NS_INLINE CGFloat CGRectEndValue(CGRect rect) {
    return rect.origin.x + rect.size.width;
}
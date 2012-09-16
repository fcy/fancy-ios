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

/**
 * @file FCDevice.h
 * Device releated features
 *
 * @author Felipe Cypriano
 * @date 2011
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , FCDeviceScreenResolution) {
    FCDeviceScreenResolutionUnknow = -1,
    FCDeviceScreenResolutionPhoneStandard = 1, // iPhone < 4 standard resolution
    FCDeviceScreenResolutionPhoneRetina,       // iPhone 4 and 4S retina resolution
    FCDeviceScreenResolutionPhoneRetina4,      // iPhone 5 retina 4 inch resolution
    FCDeviceScreenResolutionPadStandard,       // iPad 1 and 2 standard resolution
    FCDeviceScreenResolutionPadRetina,         // iPad 3 retina resolution
};

/**
 * @brief Returns true if the device has a retina display
 */
BOOL FCDeviceScreenResolutionIsRetina(FCDeviceScreenResolution resolution);


/**
 * @brief Class with helper methods to get information about the device
 *
 * You should use the shared method instead of allocting this class directly
 * because it will cache the results. And the shared instance will be
 * automatically released when it receives a memory warning.
 */
@interface FCDevice : NSObject {
    @private
    NSCache *cache;
}

/**
 * @brief Returns a shared instance of FCDevice
 *
 */
+ (id)shared;

/**
 * @brief Check if the device is able to make phone calls
 *
 * The actual implementations checks that if application can open "tel://" URLs
 * and caches the result.
 */
- (BOOL)canMakePhoneCalls;

- (FCDeviceScreenResolution)currentResolution;

@end
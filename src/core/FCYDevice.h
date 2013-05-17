//
//  Created by Felipe Cypriano on 17/08/11.
//  Copyright 2011 Felipe Cypriano. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , FCYDeviceScreenResolution) {
    FCYDeviceScreenResolutionUnknown = -1,
    FCYDeviceScreenResolutionPhoneStandard = 1, /// iPhone < 4 standard resolution
    FCYDeviceScreenResolutionPhoneRetina,       /// iPhone 4 and 4S retina resolution
    FCYDeviceScreenResolutionPhoneRetina4,      /// iPhone 5 retina 4 inch resolution
    FCYDeviceScreenResolutionPadStandard,       /// iPad 1 and 2 standard resolution
    FCYDeviceScreenResolutionPadRetina,         /// iPad 3 retina resolution
};

/**
* Returns true if the device has a retina screen
*
* @param resolution The FCYDeviceScreenResolution obtained from currentResolution
* @return True if resolution is equal to FCYDeviceScreenResolutionPhoneRetina, FCYDeviceScreenResolutionPhoneRetina4
* or FCYDeviceScreenResolutionPadRetina
*/
BOOL FCYDeviceScreenResolutionIsRetina(FCYDeviceScreenResolution resolution);

/**
* Class with helper methods to get information about the device
*
* You should use the shared method instead of allocting this class directly
* because it will cache the results. And the shared instance will be
* automatically released when it receives a memory warning.
*/
@interface FCYDevice : NSObject

/// Returns a shared instance of FCYDevice
+ (id)shared;

/**
* Check if the device is able to make phone calls
*
* @note The actual implementations checks that if application can open "tel://" URLs
* and caches the result.
*/
- (BOOL)canMakePhoneCalls;

/**
* Returns a FCYDeviceScreenResulotion representing device screen resolution
*
* @note You can use the `FCYDeviceScreenResolutinIsRetina` function to simplify the check for all the retina devices.
* Unfortunatelly documentation for C functions is not ready with appledoc, check the header file for this class to
* see the documentation.
*/
- (FCYDeviceScreenResolution)currentResolution;

@end
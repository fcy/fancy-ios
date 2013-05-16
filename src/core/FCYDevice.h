/**
 * @file FCYDevice.h
 * Device releated features
 *
 * @author Felipe Cypriano
 * @date 2011
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , FCYDeviceScreenResolution) {
    FCYDeviceScreenResolutionUnknow = -1,
    FCYDeviceScreenResolutionPhoneStandard = 1, // iPhone < 4 standard resolution
    FCYDeviceScreenResolutionPhoneRetina,       // iPhone 4 and 4S retina resolution
    FCYDeviceScreenResolutionPhoneRetina4,      // iPhone 5 retina 4 inch resolution
    FCYDeviceScreenResolutionPadStandard,       // iPad 1 and 2 standard resolution
    FCYDeviceScreenResolutionPadRetina,         // iPad 3 retina resolution
};

/**
 * @brief Returns true if the device has a retina display
 */
BOOL FCYDeviceScreenResolutionIsRetina(FCYDeviceScreenResolution resolution);


/**
 * @brief Class with helper methods to get information about the device
 *
 * You should use the shared method instead of allocting this class directly
 * because it will cache the results. And the shared instance will be
 * automatically released when it receives a memory warning.
 */
@interface FCYDevice : NSObject

/**
 * @brief Returns a shared instance of FCYDevice
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

- (FCYDeviceScreenResolution)currentResolution;

@end
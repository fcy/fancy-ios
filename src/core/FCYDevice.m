//
//  FCYDevice.m
//  fancy-ios
//
//  Created by Felipe Cypriano on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FCYDevice.h"

BOOL FCYDeviceScreenResolutionIsRetina(FCYDeviceScreenResolution resolution) {
    return resolution == FCYDeviceScreenResolutionPhoneRetina ||
            resolution == FCYDeviceScreenResolutionPhoneRetina4 ||
            resolution == FCYDeviceScreenResolutionPadRetina;
}

#define CAN_MAKE_PHONE_CALLS_KEY @"phoneCall"

@implementation FCYDevice {
    NSCache *_cache;
}

+ (id)shared {
    static id sharedInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedInstance = [[FCYDevice alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
    }
    
    return self;
}

#pragma mark -
#pragma mark FCYDevice methods

- (BOOL)canMakePhoneCalls {
    NSNumber *canMake = [_cache objectForKey:CAN_MAKE_PHONE_CALLS_KEY];
    if (canMake == nil) {
        canMake = [NSNumber numberWithBool:[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]];
        [_cache setObject:canMake forKey:CAN_MAKE_PHONE_CALLS_KEY];
    }
    return [canMake boolValue];
}

- (FCYDeviceScreenResolution)currentResolution {
    FCYDeviceScreenResolution current = FCYDeviceScreenResolutionUnknow;
    BOOL isRetina = [[UIScreen mainScreen] scale] == 2.0f;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        current = FCYDeviceScreenResolutionPhoneStandard;
        if (isRetina) {
            current = FCYDeviceScreenResolutionPhoneRetina;
            if ([[UIScreen mainScreen] bounds].size.height == 568.0f) {
                current = FCYDeviceScreenResolutionPhoneRetina4;
            }
        }
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        current = isRetina ? FCYDeviceScreenResolutionPadRetina : FCYDeviceScreenResolutionPadStandard;
    }
    
    return current;
}


@end

//
//  FCDevice.m
//  fancy-ios
//
//  Created by Felipe Cypriano on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FCDevice.h"

BOOL FCDeviceScreenResolutionIsRetina(FCDeviceScreenResolution resolution) {
    return resolution == FCDeviceScreenResolutionPhoneRetina ||
            resolution == FCDeviceScreenResolutionPhoneRetina4 ||
            resolution == FCDeviceScreenResolutionPadRetina;
}

static id sharedInstance = nil;

#define CAN_MAKE_PHONE_CALLS_KEY @"phoneCall"

@implementation FCDevice

+ (id)shared {
    if (sharedInstance == nil) {
        sharedInstance = [[FCDevice alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(receivedMemoryNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        cache = [[NSCache alloc] init];
    }
    
    return self;
}

#pragma mark -
#pragma mark Memory management


- (void)receviedMemoryWarning:(NSNotification *)notification {
    if (sharedInstance) {
        [[NSNotificationCenter defaultCenter] removeObserver:sharedInstance];
        
        sharedInstance = nil;
    }
}

#pragma mark -
#pragma mark FCDevice methods

- (BOOL)canMakePhoneCalls {
    NSNumber *canMake = [cache objectForKey:CAN_MAKE_PHONE_CALLS_KEY];
    if (canMake == nil) {
        canMake = [NSNumber numberWithBool:[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]];
        [cache setObject:canMake forKey:CAN_MAKE_PHONE_CALLS_KEY];
    }
    return [canMake boolValue];
}

- (FCDeviceScreenResolution)currentResolution {
    FCDeviceScreenResolution current = FCDeviceScreenResolutionUnknow;
    BOOL isRetina = [[UIScreen mainScreen] scale] == 2.0f;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        current = FCDeviceScreenResolutionPhoneStandard;
        if (isRetina) {
            current = FCDeviceScreenResolutionPhoneRetina;
            if ([[UIScreen mainScreen] bounds].size.height == 568.0f) {
                current = FCDeviceScreenResolutionPhoneRetina4;
            }
        }
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        current = isRetina ? FCDeviceScreenResolutionPadRetina : FCDeviceScreenResolutionPadStandard;
    }
    
    return current;
}


@end

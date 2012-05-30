//
//  FCDevice.m
//  fancy-ios
//
//  Created by Felipe Cypriano on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FCDevice.h"

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

- (void)dealloc {
    [cache release];
    [super dealloc];
}

- (void)receviedMemoryWarning:(NSNotification *)notification {
    if (sharedInstance) {
        [[NSNotificationCenter defaultCenter] removeObserver:sharedInstance];
        
        [sharedInstance release];
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

@end

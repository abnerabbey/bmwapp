//
//  LocationSingleton.m
//  BmwApp
//
//  Created by Abner Castro Aguilar on 15/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "LocationSingleton.h"

@implementation LocationSingleton


+ (LocationSingleton *)sharedInstace
{
    static LocationSingleton *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LocationSingleton alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}


@end

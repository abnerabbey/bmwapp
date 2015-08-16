//
//  LocationSingleton.h
//  BmwApp
//
//  Created by Abner Castro Aguilar on 15/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationSingleton : NSObject

@property (nonatomic, strong)CLLocationManager *locationManager;

+(LocationSingleton *)sharedInstace;


@end

//
//  LocationSingleton.h
//  BmwApp
//
//  Created by Abner Castro Aguilar on 15/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RidersManager.h"

@interface LocationSingleton : NSObject<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong) NSNumber *currentDistance;
@property (nonatomic, strong) NSNumber *realDistance;
@property (nonatomic, strong) RidersManager *mpManager;

+(LocationSingleton *)sharedInstace;
-(void)startNewTrip;
-(void)stopTrip;
@end

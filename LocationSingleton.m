//
//  LocationSingleton.m
//  BmwApp
//
//  Created by Abner Castro Aguilar on 15/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "LocationSingleton.h"
#import "RidersManager.h"

@interface LocationSingleton ()

@property (nonatomic, strong) CLLocation *lastDistance;


@end

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
        self.locationManager.activityType = CLActivityTypeFitness;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = 5;
    }
    return self;
}


-(void)startNewTrip{
    [self.locationManager startUpdatingLocation];
    
    self.currentDistance = [[NSNumber alloc] initWithInt:0];
    
    self.mpManager = [RidersManager sharedManager];
    [self.mpManager startBrowsing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRider) name:@"gotNewRider" object:nil];
}

-(void)newRider {

    
    

}

-(void)stopTrip{

    [self.locationManager stopUpdatingLocation];
    
    self.currentDistance = @0;
    self.realDistance = @0;
    self.mpManager = nil;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if(!self.lastDistance){
    
        self.lastDistance = locations.lastObject;
        return;
    }
    
    CLLocation *newDistance = locations.lastObject;
    int multiplier;
    
    if(self.mpManager.session.connectedPeers.count>0){
        multiplier = (int)self.mpManager.session.connectedPeers.count +1;
        NSLog(@"distance multiplied");
    }
    else{
        multiplier = 1;
    }
    
    int newDistanceMeters = self.currentDistance.intValue + ([newDistance distanceFromLocation:self.lastDistance]*multiplier);
    
    int realdistance = self.currentDistance.intValue + ([newDistance distanceFromLocation:self.lastDistance]);

    self.realDistance = [NSNumber numberWithInt:realdistance];
    self.currentDistance = [NSNumber numberWithInt:newDistanceMeters];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"locationDistanceUpdated" object:nil userInfo:@{@"currentDistance": self.currentDistance}];
    
}
@end

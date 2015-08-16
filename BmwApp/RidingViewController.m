//
//  RidingViewController.m
//  BmwApp
//
//  Created by Antonio Santiago on 8/15/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "RidingViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "BMwApp-Swift.h"
#import "LocationSingleton.h"
#import <Parse/Parse.h>

int counter = 30;// segun yo este es el contador :/


@interface RidingViewController ()<MKMapViewDelegate>
@property (nonatomic, strong) LocationSingleton *locationManager;
@property (nonatomic, strong) UILabel *label;
@end

@implementation RidingViewController

{
    NSArray *startingValues;
    Vector *myVec;
    Vector *biggestVec;
    CMMotionManager *motionMan;
    ColisionDetector *colDetector;
    NSTimer *timer;
    NSTimer *timerAlarm;
    NSUserDefaults *sharedData;
    int count;
    BOOL m;
    
}

- (void)viewDidLoad {
    count = 30;
    m = false;
    [super viewDidLoad];
    
    self.ridingMapView.showsUserLocation = YES;
    self.locationManager = [LocationSingleton sharedInstace];
    self.ridingMapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.locationManager startNewTrip];
    self.ridingMapView.delegate = self;
    // Do any additional setup after loading the view.
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(methodB) userInfo:nil repeats:YES];
    sharedData = [[NSUserDefaults alloc] initWithSuiteName:@"group.motoRide"];
    [sharedData setObject: @"OK" forKey:@"status"];
    colDetector = [[ColisionDetector alloc] init];
    startingValues = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.0], [NSNumber numberWithDouble:0.0], nil];
    myVec = [[Vector alloc] initWithF:startingValues];
    [self restartValue];
    motionMan = [[CMMotionManager alloc] init];
    motionMan.accelerometerUpdateInterval = 0.1;
    if (motionMan.isAccelerometerAvailable) {
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [motionMan startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 myVec = [[Vector alloc] initWithF:[NSArray arrayWithObjects:[NSNumber numberWithDouble:accelerometerData.acceleration.x],[NSNumber numberWithDouble:accelerometerData.acceleration.y], [NSNumber numberWithDouble:accelerometerData.acceleration.z], nil]];
                 if ([colDetector isNewForceBigger:biggestVec v:myVec]){
                     biggestVec = myVec;
                 }
                 NSLog(@"%.2f", [myVec getMagnitud]);
                 
                 if ([colDetector colHasOcurred:biggestVec value:10]){
                     //                     self.statusL.text = @"Ha Ocurrido un accidente";
                     [self ventanaEmergente];
//
                     if (m == false) {
                         m = true;
                     }
                     
                     //Ocurrio un Accidente
//                     self.butLabel.text = @"Alert!";
                     [sharedData setObject: @"Danger!" forKey:@"status"];
                     [sharedData synchronize];
                 } else {
                     [self desapareceVentana];
                     //                     self.statusL.text = @"Todo Esta bien";
                     //Todo esta bien
//                     self.butLabel.text = @"On Ride";
                     //Do Something with the data
                     [self restartValue];
                 }
             });
         }];
    }
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 40)];
    self.label.text = @"0";
    [self.label setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.label];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdated) name:@"locationDistanceUpdated" object:nil];

}

-(void)locationUpdated{
    
    
    self.label.text = [NSString stringWithFormat:@"Distance %@", self.locationManager.currentDistance];
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

    [self.ridingMapView setRegion:MKCoordinateRegionMakeWithDistance(self.locationManager.locationManager.location.coordinate, 20, 20)];
    
    MKMapCamera *newCamera = [[self.ridingMapView camera] copy];
    [newCamera setPitch:70.0]; // or newCamera.heading + 90.0 % 360.0
    [self.ridingMapView setCamera:newCamera animated:NO];
    
    NSLog(@"aqui");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)restartValue{
    count = 30;
    biggestVec = [[Vector alloc] initWithF:startingValues];
    
    //Reinicia el algoritmo del acelerometro
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void) methodB{
    
    NSLog(@"cadena %@", [sharedData valueForKey:@"status"] );
    if ([[sharedData valueForKey:@"L"]  isEqualToString: @"M"]) {
        [self restartValue];
    }
    [sharedData setObject: @"Ok" forKey:@"status"];
    [sharedData setValue:@"N" forKey:@"L"];
    if (m == true) {
        timerAlarm = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(triggerAlarm) userInfo:nil repeats:YES];
    }
}

- (void) ventanaEmergente {
    [self.MasterView bringSubviewToFront:self.alertViewR];
    [UIView animateWithDuration:0.6 animations:^{
        [self estadoFinal];
    }];
    
}

- (void) triggerAlarm{
    count = count - 1;
    NSLog(@"%d", count);
    
    if (count <= 0) {
        count = 0;
        [timerAlarm invalidate];
        m = false;
        PFUser *user = [PFUser currentUser];
        [PFCloud callFunctionInBackground:@"telefonos"
                           withParameters:@{@"objectId": user.objectId}
                                    block:^(NSString *success, NSError *error) {
                                        if (!error) {
                                            
                                        }
                                    }];
        count = 30;
        //triggerAlarm
    }
    self.counterLabel.text = [NSString stringWithFormat:@"%d", count];
}

- (void) desapareceVentana {
    [self.MasterView sendSubviewToBack:self.alertViewR];
    [UIView animateWithDuration:0.6 animations:^{
        [self estadoFinal];
    }];
    
}

- (void) estadoFinal {
    self.alertViewR.transform = CGAffineTransformIdentity;
    self.alertViewR.alpha = 1;
    
}

- (void) estadoInicial{
    self.alertViewR.transform = CGAffineTransformMakeScale(30, 30);
    self.alertViewR.alpha = 0;
    
}

- (IBAction)popUpButton:(id)sender {
    [self restartValue];
    [sharedData setObject: @"OK" forKey:@"status"];
    [sharedData synchronize];
    //Cancelar Alarma!!!
    
}

- (IBAction)endRideButtonTapped:(UIButton *)sender {
    
    
    [self restartValue];
    PFUser *user = [PFUser currentUser];
    
    int maxDistance = [user[@"points"] intValue] + self.locationManager.currentDistance.intValue;
    user[@"points"] = [NSNumber numberWithInt:maxDistance];
    [user saveInBackground];
    
    [self.locationManager stopTrip];
    [self dismissViewControllerAnimated:false completion:nil];

    
}

-(void)dealloc{

    self.locationManager = nil;
    self.ridingMapView.delegate = nil;
    
}

@end

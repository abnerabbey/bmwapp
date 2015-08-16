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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ridingMapView.showsUserLocation = YES;
    self.locationManager = [LocationSingleton sharedInstace];
    self.ridingMapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.locationManager startNewTrip];
    self.ridingMapView.delegate = self;
    // Do any additional setup after loading the view.
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
                 
                 //Do Something with the data
                 
                 if ([colDetector colHasOcurred:biggestVec value:12]){
                     //                     self.statusL.text = @"Ha Ocurrido un accidente";
                     
                     //Ocurrio un Accidente
                     
                     
                 } else {
                     //                     self.statusL.text = @"Todo Esta bien";
                     
                     //Todo esta bien
                     
                     
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

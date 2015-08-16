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

@interface RidingViewController ()

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
    [self dismissViewControllerAnimated:false completion:nil];
}
@end

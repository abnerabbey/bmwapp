//
//  RidingViewController.m
//  BmwApp
//
//  Created by Antonio Santiago on 8/15/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "RidingViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "BmwApp-Swift.h"

int counter = 30;

@interface RidingViewController ()

@end

@implementation RidingViewController

{
    NSArray *startingValues;
    Vector *myVec;
    Vector *biggestVec;
    CMMotionManager *motionMan;
    ColisionDetector *colDetector;
    NSTimer *timer;
    NSUserDefaults *sharedData;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void) methodB{
    
    NSLog(@"cadena %@", [sharedData valueForKey:@"status"] );
    if ([[sharedData valueForKey:@"L"]  isEqualToString: @"M"]) {
        [self restartValue];
    }
//    [sharedData setObject: self.butLabel.text forKey:@"status"];
    [sharedData setValue:@"N" forKey:@"L"];
}

- (void) ventanaEmergente {
    [UIView animateWithDuration:0.5 animations:^{
        [self estadoFinal];
    }];
    [self.MasterView bringSubviewToFront:self.alertViewR];
}

- (void) desapareceVentana {
    [UIView animateWithDuration:0.5 animations:^{
        [self estadoFinal];
    }];
    [self.MasterView sendSubviewToBack:self.alertViewR];
}

- (void) estadoFinal {
    self.alertViewR.transform = CGAffineTransformIdentity;
    self.alertViewR.alpha = 1;
    self.counterLabel.text = @"30"; //poner counter aqui
}

- (void) estadoInicial{
    self.alertViewR.transform = CGAffineTransformMakeScale(30, 30);
    self.alertViewR.alpha = 0;
    self.counterLabel.text = @"30"; //poner counter aqui
}

- (IBAction)popUpButton:(id)sender {
    [self restartValue];
    [sharedData setObject: @"OK" forKey:@"status"];
    [sharedData synchronize];
    //Cancelar Alarma!!!
    
}

- (IBAction)endRideButtonTapped:(UIButton *)sender {
    [self restartValue];
    [self dismissViewControllerAnimated:false completion:nil];
}
@end

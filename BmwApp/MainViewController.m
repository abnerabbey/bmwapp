//
//  MainViewController.m
//  BmwApp
//
//  Created by Abner Castro Aguilar on 15/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "MainViewController.h"
#import <Parse/Parse.h>
#import "LocationSingleton.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    BOOL firstTime;
    LocationSingleton *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [LocationSingleton sharedInstace];
    [locationManager.locationManager requestWhenInUseAuthorization];
    
    firstTime = YES;
    
    UIBarButtonItem *rideButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleDone target:self action:@selector(settings)];
    rideButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rideButton;
    
    self.rideButton.layer.cornerRadius = 6.0;
}

- (void)viewDidAppear:(BOOL)animated
{
    if(firstTime){
        PFUser *currentUser = [PFUser currentUser];
        if(!currentUser){
            ViewController *loginView = [[self storyboard] instantiateViewControllerWithIdentifier:@"login"];
            UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self presentViewController:nv animated:YES completion:nil];
        }
        firstTime = NO;
    }
}

- (void)settings
{
    
}



- (IBAction)takeRide:(UIButton *)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"About to ride" message:@"How would you like to ride?" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ride Solo" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ride Along" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end




































































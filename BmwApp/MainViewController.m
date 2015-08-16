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
#import "RidingViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    BOOL firstTime;
    LocationSingleton *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
}



- (IBAction)takeRide:(UIButton *)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"About to ride" message:@"How would you like to ride?" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ride Solo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        RidingViewController *ridingView = [[self storyboard] instantiateViewControllerWithIdentifier:@"ridin"];
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:ridingView];
        [self presentViewController:nv animated:NO completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ride Along" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end




































































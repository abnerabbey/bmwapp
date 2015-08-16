//
//  RidingViewController.h
//  BmwApp
//
//  Created by Antonio Santiago on 8/15/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RidingViewController : UIViewController

// MARK: Properties

@property (strong, nonatomic) IBOutlet UIView *MasterView;
@property (weak, nonatomic) IBOutlet MKMapView *ridingMapView;
@property (weak, nonatomic) IBOutlet UIButton *endRideButton;
@property (weak, nonatomic) IBOutlet UIView *alertViewR;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;

// MARK: Actions

- (IBAction)endRideButtonTapped:(UIButton *)sender;


@end

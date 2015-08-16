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

@property (weak, nonatomic) IBOutlet MKMapView *ridingMapView;
@property (weak, nonatomic) IBOutlet UIButton *endRideButton;
@property (weak, nonatomic) IBOutlet UIButton *popupbutton;

// MARK: Actions

- (IBAction)endRideButtonTapped:(UIButton *)sender;


@end

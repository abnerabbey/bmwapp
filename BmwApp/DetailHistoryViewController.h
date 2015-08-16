//
//  DetailHistoryViewController.h
//  BmwApp
//
//  Created by Abner Castro Aguilar on 16/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

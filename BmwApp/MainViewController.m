//
//  MainViewController.m
//  BmwApp
//
//  Created by Abner Castro Aguilar on 15/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "MainViewController.h"
#import <Parse/Parse.h>

@interface MainViewController ()

@end

@implementation MainViewController
{
    
    
    NSMutableArray *arrayRoute;
    NSMutableArray *arrayDate;
    NSMutableArray *arrayRank;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rideButton = [[UIBarButtonItem alloc] initWithTitle:@"Ride" style:UIBarButtonItemStyleDone target:self action:@selector(ride)];
    self.navigationItem.rightBarButtonItem = rideButton;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getParse];

}

#pragma mark TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayRoute.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    UILabel *routeLabel = (UILabel *)[cell viewWithTag:1];
    routeLabel.text = [arrayRoute objectAtIndex:indexPath.row];
    
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:2];
    dateLabel.text = [arrayDate objectAtIndex:indexPath.row];
    
    UILabel *rankLabel = (UILabel *)[cell viewWithTag:3];
    rankLabel.text = [arrayRank objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)getParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"viajes"];
    [query whereKey:@"user" equalTo:[NSString stringWithFormat:@"%@", [PFUser currentUser].email]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        for (PFObject *object in objects) {
            [arrayRoute addObject:[object objectForKey:@"ruta"]];
            [arrayDate addObject:[object objectForKey:@"fecha"]];
            [arrayRank addObject:[object objectForKey:@"rank"]];
            [self.tableView reloadData];
        }
    }];
}

- (void)ride
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"About to ride" message:@"How would you like to ride?" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ride Solo" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ride Along" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


@end

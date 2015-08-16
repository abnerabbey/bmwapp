//
//  RecentsViewController.m
//  BmwApp
//
//  Created by Abner Castro Aguilar on 15/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "RecentsViewController.h"
#import <Parse/Parse.h>

@interface RecentsViewController ()
{
    NSMutableArray *routesarray;
    NSMutableArray *datesarray;
}

@end

@implementation RecentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"Rides Recents";
    
    [self getParse];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [routesarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recentC"];
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"recentC"];
    
    UILabel *routeLabel = (UILabel *)[cell viewWithTag:1];
    routeLabel.text = [routesarray objectAtIndex:indexPath.row];
    
    UILabel *datesLabel = (UILabel *)[cell viewWithTag:2];
    datesLabel.text = [datesarray objectAtIndex:indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getParse
{
    routesarray = [[NSMutableArray alloc] init];
    datesarray = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"viajes"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        for (PFObject *object in objects) {
            [routesarray addObject:[object objectForKey:@"ruta"]];
            [datesarray addObject:[object objectForKey:@"fecha"]];
        }
        [self.tableView reloadData];
    }];
}



@end




























































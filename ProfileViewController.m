//
//  ProfileViewController.m
//  BmwApp
//
//  Created by Abner Castro Aguilar on 16/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()
{
    NSArray *profileArray;
    UIImageView *profilePhoto;
    UILabel *labelProfile;
    
    NSMutableArray *stats;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"My Profile";
    
    //header view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 200.0)];
    profilePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, headerView.frame.size.height/2 - 50, 100.0, 100.0)];
    profilePhoto.image = [UIImage imageNamed:@"joseluis.jpg"];
    [headerView addSubview:profilePhoto];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableHeaderView = headerView;
    [self getParse];
    
}

#pragma mark TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stats.count;
}

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return @"Stats";
            break;
        case 1:
            return @"Emergency numbers";
            break;
        default:
            break;
    }
    return nil;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = [stats objectAtIndex:indexPath.row];
    return cell;
}

- (void)getParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:[PFUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        PFObject *object = [objects objectAtIndex:0];
        stats = [[NSMutableArray alloc] init];
        [stats addObject:[object objectForKey:@"name"]];
        [stats addObject:[object objectForKey:@"placas"]];
        NSArray *tels = [object objectForKey:@"telefonos"];
        for (int i = 0; i < tels.count; i++) {
            [stats addObject:[tels objectAtIndex:i]];
        }
        [stats addObject:@"Your ranking: 4/5"];
        [self.tableView reloadData];
    }];
}


@end
































































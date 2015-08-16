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
    
    PFObject *myObject;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"My Profile";
    
    //header view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 200.0)];
    profilePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, headerView.frame.size.height/2 - 50, 100.0, 100.0)];
    [headerView addSubview:profilePhoto];
    
    labelProfile = [[UILabel alloc] initWithFrame:CGRectMake(profilePhoto.frame.origin.x, profilePhoto.frame.origin.y + 120, 100.0, 100.0)];
    labelProfile.text = @"John Appleseed";
    labelProfile.font = [UIFont systemFontOfSize:12.0];
    [headerView addSubview:labelProfile];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableHeaderView = headerView;
    [self getParse];
    
}

#pragma mark TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return profileArray.count;
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
    NSArray *stats = [NSArray arrayWithObjects:[myObject objectForKey:@"placas"], @"puntuación obtenida: 4/5", nil];
    cell.textLabel.text = [stats objectAtIndex:indexPath.row];
    NSArray *numbers = [myObject objectForKey:@"telefonos"];
    cell.textLabel.text = [numbers objectAtIndex:indexPath.row];
    return cell;
}

- (void)getParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:[PFUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        PFObject *object = [objects objectAtIndex:0];
        myObject = [objects objectAtIndex:0];
        labelProfile.text = [object objectForKey:@"name"];
        [self.tableView reloadData];
    }];
}


@end
































































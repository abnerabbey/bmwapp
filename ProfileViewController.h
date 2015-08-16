//
//  ProfileViewController.h
//  BmwApp
//
//  Created by Abner Castro Aguilar on 16/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

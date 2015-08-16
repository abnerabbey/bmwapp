//
//  ContactsViewController.h
//  BmwApp
//
//  Created by Antonio Santiago on 8/15/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UIViewController

// MARK: Properties

@property (weak, nonatomic) IBOutlet UITableView *emergencyContactsTableView;

// MARK: Actions

- (IBAction)addNewEmergencyContactButtonTapped:(UIButton *)sender;

@end

//
//  AddUserInfoViewController.h
//  BmwApp
//
//  Created by Jose Luis Rodriguez on 16/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddUserInfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)contactPressed:(UIButton *)sender;
- (IBAction)savePressed:(UIBarButtonItem *)sender;

@end

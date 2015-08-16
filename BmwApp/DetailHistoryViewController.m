//
//  DetailHistoryViewController.m
//  BmwApp
//
//  Created by Abner Castro Aguilar on 16/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "DetailHistoryViewController.h"

@interface DetailHistoryViewController ()
{
    NSArray *contentArray;
}

@end

@implementation DetailHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end

//
//  ViewController.m
//  BmwApp
//
//  Created by Abner Castro Aguilar on 15/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFUser *user = [PFUser currentUser];
    if(user){
        //Omite login
    }
    else
    {
        
    }
}
- (IBAction)logIn:(UIButton *)sender
{
    NSArray *permisssions = @[@"public_profile", @"user_birthday", @"email", @"user_friends"];
    [PFFacebookUtils logInWithPermissions:permisssions block:^(PFUser *user, NSError *error){
        if(!error){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
@end


























































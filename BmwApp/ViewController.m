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
    NSArray *permisssions = @[@"public_profile"];
    
    
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permisssions block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else {
            
            [self performSegueWithIdentifier:@"logedIn" sender:nil];

            
            NSLog(@"%@", user);
            
            
            [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
            
        
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name"}]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (error) {
                     
                 }
                 else {
                     NSLog(@"fecthed user: %@", [result valueForKey:@"name"]);
                     user[@"name"]= [result valueForKey:@"name"];
                     [user saveEventually];
                 }
             }];
            
            
            
            
            
            
            //            // Send request to Facebook
            //            FBRequest *request = [FBRequest requestForMe];
            //
            //
            //                [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            //                    // handle response
            //                    [self performSegueWithIdentifier:@"logedIn" sender:nil];
            //
            //                    if(!error){
            //
            //                        NSDictionary *userData = (NSDictionary *)result;
            //
            //
            //
            //
            //                    }
            //                    else {
            //                        NSLog(@"%@", error);
            //                    }
            //                    
            //                }];
            
            NSLog(@"User signed up and logged in through Facebook!");
        }

        
    }];
}
@end


























































//
//  AddUserInfoViewController.m
//  BmwApp
//
//  Created by Jose Luis Rodriguez on 16/08/15.
//  Copyright (c) 2015 Abner Castro Aguilar. All rights reserved.
//

#import "AddUserInfoViewController.h"
#import "ABWrappers.h"
#import <Parse/Parse.h>


@interface AddUserInfoViewController ()<ABPeoplePickerNavigationControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *currentPhones;
@end

@implementation AddUserInfoViewController
{
    BOOL addNewPhone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ABStandin requestAccess];
    self.currentPhones = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section==0?@"Add your plate number":@"Emergency Contacts";

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0)
        return 1;
    
    return self.currentPhones.count+ 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"plateCell"];
    
    }
    else{
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"emergency"];

        if(self.currentPhones.count>0){
            if(indexPath.row < self.currentPhones.count){
                UILabel *phonelabel = (UILabel *)[cell viewWithTag:1];
                phonelabel.text = [self.currentPhones objectAtIndex:indexPath.row];
            }
        }
        
    
    }
    
    
    
    return cell;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)contactPressed:(UIButton *)sender {
    NSLog(@"contatcs pressed");
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    picker.displayedProperties = @[[NSNumber numberWithInt:kABPersonPhoneProperty]];
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)savePressed:(UIBarButtonItem *)sender {
    [self saveUserValues];
    
}


-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{

    
    ABContact *contact=[ABContact contactWithRecord:person];
    
    NSString *phone = contact.phoneArray.firstObject;
    phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [self.currentPhones addObject:phone];
    
    [self.table reloadData];

}
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{

}

-(void)saveUserValues{

    PFUser *user = [PFUser currentUser];
    user[@"placas"] = @"123456";
    user[@"telefonos"] = self.currentPhones;

    [user saveInBackground];
}

@end

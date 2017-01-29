//
//  ViewController.m
//  AppForAcromine
//
//  Created by Aditya Tanna on 4/11/16.
//  Copyright © 2016 Aditya Tanna. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mutArrAcronyms,txtSearchAcronyms,tblAcronymsDetails;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mutArrAcronyms = [[NSMutableArray alloc]init];
    
    [tblAcronymsDetails setHidden:YES];
}

#pragma mark : UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    [self btnActnGetAcronyms:nil];
    
    return YES;
}


#pragma Mark : UITableView Data Source & Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return mutArrAcronyms.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cellAcronyms"];
    
    UILabel *lblSince = (UILabel*) [cell viewWithTag:100];
    
    NSString *strLf = [[mutArrAcronyms objectAtIndex:indexPath.row] objectForKey:@"lf"];
    
    NSString *strFreq = [[mutArrAcronyms objectAtIndex:indexPath.row] objectForKey:@"freq"];
    
    NSString *strSince = [[mutArrAcronyms objectAtIndex:indexPath.row] objectForKey:@"since"];
    
    cell.textLabel.text = strLf;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Frequency: %@",strFreq];
    
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    lblSince.text = [NSString stringWithFormat:@"Since: %@",strSince];
    
    lblSince.textColor = [UIColor whiteColor];
    return cell;
    
}

- (IBAction)btnActnGetAcronyms:(UIButton *)sender {
    
    [txtSearchAcronyms resignFirstResponder];
    
    [mutArrAcronyms removeAllObjects];
    
    [tblAcronymsDetails reloadData];
    
    NSString *aStrURL = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",txtSearchAcronyms.text];
    
    AppDelegate *objAppn = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    
    [objAppn showActivityWithTitle:@"Loading..."];
    
    [objAppn callWebService:aStrURL parameters:nil httpMethod:@"GET" complition:^(NSDictionary *response) {
        
        [mutArrAcronyms addObjectsFromArray:[response objectForKey:@"lfs"]];
        
        if (mutArrAcronyms.count > 0) {
            [tblAcronymsDetails setHidden:NO];
            [tblAcronymsDetails reloadData];
        }else{
            [tblAcronymsDetails setHidden:YES];
            alert(@"Oops!!", @"No acronyms Found");
        }
        
        
        [objAppn hideActivity];
        
    } failure:^(NSError *error, NSDictionary *response) {
        
        [objAppn hideActivity];
         alert(@"Oops!!", @"Something went wrong !!");
        
    }];
}
@end

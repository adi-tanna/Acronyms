//
//  ViewController.h
//  AppForAcromine
//
//  Created by Aditya Tanna on 4/11/16.
//  Copyright © 2016 Aditya Tanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(nonatomic, strong) NSMutableArray *mutArrAcronyms;

@property (strong, nonatomic) IBOutlet UITextField *txtSearchAcronyms;

- (IBAction)btnActnGetAcronyms:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITableView *tblAcronymsDetails;

@end


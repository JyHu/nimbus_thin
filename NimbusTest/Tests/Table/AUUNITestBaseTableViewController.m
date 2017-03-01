//
//  AUUNITestBaseTableViewController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUNITestBaseTableViewController.h"

@interface AUUNITestBaseTableViewController ()

@end

@implementation AUUNITestBaseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    self.tableView.dataSource = self.model;
    if (self.actions) {
        self.tableView.delegate = [self.actions forwardingTo:self];
    }
}

- (void)loadData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

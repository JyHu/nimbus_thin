//
//  AUUNITestBaseTableViewController.h
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NimbusCore.h"
#import "NimbusModels.h"

@interface AUUNITestBaseTableViewController : UITableViewController

@property (retain, nonatomic) NITableViewModel *model;

@property (retain, nonatomic) NITableViewActions *actions;

- (void)loadData;

@end

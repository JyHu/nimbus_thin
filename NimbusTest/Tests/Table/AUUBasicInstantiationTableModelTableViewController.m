//
//  AUUBasicInstantiationTableModelTableViewController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUBasicInstantiationTableModelTableViewController.h"
#import "NimbusModels.h"
#import "NimbusCore.h"


@interface AUUBasicInstantiationTableModelTableViewController ()


@end

@implementation AUUBasicInstantiationTableModelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData
{
    self.actions = [[NITableViewActions alloc] initWithTarget:self];
    
    NSArray *tableContents = @[
                               [NITitleCellObject objectWithTitle:@"Row 1"],
                               [NISubtitleCellObject objectWithTitle:@"Row2" subtitle:@"subtitle 2"],
                               [self.actions attachToObject:[NITitleCellObject objectWithTitle:@"Row 3"]
                                        navigationBlock:NIPushControllerAction([AUUBasicInstantiationTableModelTableViewController class])]
                               ];
    
    self.model = [[NITableViewModel alloc] initWithListArray:tableContents delegate:(id)[NICellFactory class]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

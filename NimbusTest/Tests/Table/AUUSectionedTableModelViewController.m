//
//  AUUSectionedTableModelViewController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUSectionedTableModelViewController.h"
#import "NimbusModels.h"
#import "NimbusCore.h"

@interface AUUSectionedTableModelViewController ()

@end

@implementation AUUSectionedTableModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData
{
    NSArray *tableContents = @[
                               [NITitleCellObject objectWithTitle:@"First section"],
                               @"Section with rows              - 0",
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               
                               @"Section without any row        - 1",
                               [NITitleFooterObject objectWithTitle:@"footer - 1"],
                               @"Another section                - 2",
                               [NITitleCellObject objectWithTitle:@"Row"],
                               
                               @"                               - 3",
                               [NITitleCellObject objectWithTitle:@"This section has no header"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"First section"],
                               @"Section with rows              - 4",
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               
                               @"Section without any row        - 5",
                               
                               @"Another section                - 6",
                               [NITitleCellObject objectWithTitle:@"Row"],
                               
                               @"                               - 7",
                               [NITitleCellObject objectWithTitle:@"This section has no header"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"First section"],
                               @"Section with rows              - 8",
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               
                               @"Section without any row        - 9",
                               
                               @"Another section                - 10",
                               [NITitleCellObject objectWithTitle:@"Row"],
                               
                               @"                               - 11",
                               [NITitleCellObject objectWithTitle:@"This section has no header"],
                               [NITitleCellObject objectWithTitle:@"Row"]
                               ];
    self.model = [[NITableViewModel alloc] initWithSectionedArray:tableContents delegate:(id)[NICellFactory class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

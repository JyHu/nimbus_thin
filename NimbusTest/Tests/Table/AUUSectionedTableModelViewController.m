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

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData
{
    NSArray *tableContents = @[
                               [NITitleCellObject objectWithTitle:@"First section"],
                               @"Section with rows",
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NISubTitleFooterObject objectWithTitle:@"subtitle footer title" detail:@"subtitle footer detail"],
                               [NISubTitleHeaderObject objectWithTitle:@"subtitle header title" detail:@"subtitle header detail"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               [NITitleCellObject objectWithTitle:@"Row"],
                               
                               @"Section without any row",
                               
                               @"Another section",
                               [NITitleCellObject objectWithTitle:@"Row"],
                               
                               @"",
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

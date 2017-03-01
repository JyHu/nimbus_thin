//
//  AUUIndexedTableModelViewController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUIndexedTableModelViewController.h"

@interface AUUIndexedTableModelViewController ()

@end

@implementation AUUIndexedTableModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData
{
    NSArray *tableContent = @[
                              @"A",
                              [NITitleCellObject objectWithTitle:@"Jon Abrams"],
                              [NITitleCellObject objectWithTitle:@"Crystal Arbor"],
                              [NITitleCellObject objectWithTitle:@"Mike Axiom"],
                              
                              @"B",
                              [NITitleCellObject objectWithTitle:@"Joey Bannister"],
                              [NITitleCellObject objectWithTitle:@"Ray Bowl"],
                              [NITitleCellObject objectWithTitle:@"Jane Byte"],
                              
                              @"C",
                              [NITitleCellObject objectWithTitle:@"JJ Cranilly"],
                              
                              @"K",
                              [NITitleCellObject objectWithTitle:@"Jake Klark"],
                              [NITitleCellObject objectWithTitle:@"Viktor Krum"],
                              [NITitleCellObject objectWithTitle:@"Abraham Kyle"],
                              
                              @"L",
                              [NITitleCellObject objectWithTitle:@"Mr Larry"],
                              [NITitleCellObject objectWithTitle:@"Mo Lundlum"],
                              
                              @"N",
                              [NITitleCellObject objectWithTitle:@"Carl Nolly"],
                              [NITitleCellObject objectWithTitle:@"Jeremy Nym"],
                              
                              @"O",
                              [NITitleCellObject objectWithTitle:@"Number 1 Otter"],
                              [NITitleCellObject objectWithTitle:@"Number 2 Otter"],
                              [NITitleCellObject objectWithTitle:@"Number 3 Otter"],
                              [NITitleCellObject objectWithTitle:@"Number 4 Otter"],
                              [NITitleCellObject objectWithTitle:@"Number 5 Otter"],
                              [NITitleCellObject objectWithTitle:@"Number 6 Otter"],
                              [NITitleCellObject objectWithTitle:@"Number 7 Otter"],
                              [NITitleCellObject objectWithTitle:@"Number 8 Otter"],
                              [NITitleCellObject objectWithTitle:@"Number 9 Otter"],
                              [NITitleCellObject objectWithTitle:@"Number 10 Otter"],
                              
                              @"X",
                              [NITitleCellObject objectWithTitle:@"Charles Xavier"],
                              ];
    self.model = [[NITableViewModel alloc] initWithSectionedArray:tableContent delegate:(id)[NICellFactory class]];
    [self.model setSectionIndexType:NITableViewModelSectionIndexAlphabetical showsSearch:NO showsSummary:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

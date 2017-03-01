//
//  AUUBlockCellsViewController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUBlockCellsViewController.h"

@interface AUUBlockCellsViewController ()

@end

@implementation AUUBlockCellsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 70;
}

- (void)loadData
{
    UIImage *image = [UIImage imageNamed:@"11.jpg"];
    NICellDrawRectBlock drawTextBlock = ^CGFloat(CGRect rect, id object, UITableViewCell *cell) {
        if (cell.isHighlighted || cell.isSelected) {
            [[UIColor clearColor] set];
        } else {
            [[UIColor whiteColor] set];
        }
        
        UIRectFill(rect);
        
        NSString *text = object;
        [[UIColor blackColor] set];
        UIFont *titleFont = [UIFont boldSystemFontOfSize:16];
        [text drawAtPoint:CGPointMake(10, 5) withAttributes:@{NSFontAttributeName : titleFont}];
        
        [[UIColor grayColor] set];
        [@"Subtitle" drawAtPoint:CGPointMake(10, 5 + titleFont.lineHeight) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        [image drawInRect:CGRectMake(CGRectGetMaxX(rect) - 60 - 10, 5, 60, 60)];
        
        return 0;
    };
    
    NSMutableArray *tableContents = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 1000; i ++) {
        [tableContents addObject:[NIDrawRectBlockCellObject objectWithBlock:drawTextBlock object:[NSString stringWithFormat:@"This is cell #%zd", i]]];
    }
    
    self.model = [[NITableViewModel alloc] initWithSectionedArray:tableContents delegate:(id)[NICellFactory class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

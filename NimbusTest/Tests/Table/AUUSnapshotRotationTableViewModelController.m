//
//  AUUSnapshotRotationTableViewModelController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//



#import "AUUSnapshotRotationTableViewModelController.h"

@interface AUUSnapshotRotationTableViewModelController () <NISnapshotRotationDelegate, UITableViewDelegate>

@property (retain, nonatomic) UITableView *tableView;

@property (retain, nonatomic) NISnapshotRotation *snapshotRotation;

@property (retain, nonatomic) NITableViewModel *model;

@property (retain, nonatomic) NITableViewActions *actions;

@end

@implementation AUUSnapshotRotationTableViewModelController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.view && self.tableView.numberOfSections == 0) {
        [self.tableView reloadData];
    }
    
    NSIndexPath *selectedRow = self.tableView.indexPathForSelectedRow;
    if (selectedRow == nil) {
        [self.tableView deselectRowAtIndexPath:selectedRow animated:animated];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
    self.tableView.dataSource = self.model;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)loadData
{
    self.snapshotRotation = [[NITableViewSnapshotRotation alloc] initWithDelegate:self];
    
    NICellDrawRectBlock drawTextBlock = ^CGFloat(CGRect rect, id object, UITableViewCell *cell) {
        if ([object isKindOfClass:[NSString class]]) {
            NSString *text = object;
            UIFont *titleFont = [UIFont boldSystemFontOfSize:16];
            CGFloat titleWidth = rect.size.width - 20;
            CGSize size = [text boundingRectWithSize:CGSizeMake(titleWidth, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName : titleFont}
                                             context:nil].size;
            if (cell) {
                if (cell.isHighlighted || cell.isSelected) {
                    [[UIColor clearColor] set];
                } else {
                    [[UIColor whiteColor] set];
                }
                
                UIRectFill(rect);
                [[UIColor blackColor] set];
                [text drawInRect:CGRectMake(10, 5, size.width, size.height)
                  withAttributes:@{NSFontAttributeName : titleFont}];
            }

            return size.height + 10;
        }
        return 0;
    };
    
    NSMutableArray *tableContent = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i ++) {
        [tableContent addObject:[NIDrawRectBlockCellObject objectWithBlock:drawTextBlock
                                                                    object:@"This is a cell with a large amount of text that is going to wrap over multiple lines. This is a cell with a large amount of text that is going to wrap over multiple lines."]];
        [tableContent addObject:[NIDrawRectBlockCellObject objectWithBlock:drawTextBlock
                                                                    object:@"This is a short label"]];
    }
    
    self.model = [[NITableViewModel alloc] initWithListArray:tableContent delegate:(id)[NICellFactory class]];
    
    self.actions = [[NITableViewActions alloc] initWithTarget:self];
    [self.actions attachToClass:[NIDrawRectBlockCellObject class] navigationBlock:NIPushControllerAction([self class])];
    self.tableView.delegate = [self.actions forwardingTo:self];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.snapshotRotation willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.snapshotRotation willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.snapshotRotation didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NIDrawRectBlockCellObject *object = [self.model objectAtIndexPath:indexPath];
    return object.block(self.tableView.bounds, object.object, nil);
}

#pragma mark - snap view delegate

- (UIView *)containerViewForSnapshotRotation:(NISnapshotRotation *)snapshotRotation
{
    return self.view;
}

- (UIView *)rotatingViewForSnapshotRotation:(NISnapshotRotation *)snapshotRotation
{
    return self.tableView;
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  AUUSnapshotRotationTableViewModelController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//







/*
 
 
 
 
 
 
 
                    有问题，待调试。。。。
 
 
 
 
 
 
 
 
 
 
 
 */


































#import "AUUSnapshotRotationTableViewModelController.h"

@interface AUUSnapshotRotationTableViewModelController () <NISnapshotRotationDelegate>

@property (retain, nonatomic) NISnapshotRotation *snapshotRotation;

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
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)loadData
{
    self.snapshotRotation = [[NITableViewSnapshotRotation alloc] initWithDelegate:self];
    
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
        CGFloat titleWidth = rect.size.width - 20;
        
        CGSize size = [text boundingRectWithSize:CGSizeMake(titleWidth, CGFLOAT_MAX) options:NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName : titleFont} context:nil].size;
        
        if (cell != nil) {
            [text drawInRect:CGRectMake(10, 5, size.width, size.height) withAttributes:@{NSFontAttributeName : titleFont}];
        }
        
        return size.height + 10;
    };
    
    NSMutableArray *tableContent = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i ++) {
        [tableContent addObject:[NIDrawRectBlockCellObject objectWithBlock:drawTextBlock object:@"This is a cell with a large amount of text that is going to wrap over multiple lines"]];
        [tableContent addObject:[NIDrawRectBlockCellObject objectWithBlock:drawTextBlock object:@"This is a short label"]];
    }
    
    self.model = [[NITableViewModel alloc] initWithListArray:tableContent delegate:(id)[NICellFactory class]];
    
    self.actions = [[NITableViewActions alloc] initWithTarget:self];
    [self.actions attachToClass:[NIDrawRectBlockCellObject class] navigationBlock:NIPushControllerAction([self class])];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

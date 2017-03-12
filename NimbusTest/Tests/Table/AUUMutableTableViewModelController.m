//
//  AUUMutableTableViewModelController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUMutableTableViewModelController.h"
#import "NimbusModels.h"
#import "NimbusCore.h"
#import "NITableHeaderFooterFactory.h"

@interface AUUMutableTableViewModelController ()<NIMutableTableViewModelDelegate, NITableHeaderFooterDelegate>

@property (retain, nonatomic) NIMutableTableViewModel *model;

@property (retain, nonatomic) NITableViewActions *actions;

@property (retain, nonatomic) NSIndexPath *indexPathForDeletion;

@end

@implementation AUUMutableTableViewModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    self.tableView.dataSource = self.model;
    self.tableView.delegate = [self.actions forwardingTo:self];
    [self.actions attachToClass:[NITableHeaderFooterObject class] tapBlock:^BOOL(id object, id target, NSIndexPath *indexPath) {
        NSLog(@"tap block index %@", @([indexPath indexAtPosition:0]));
        return YES;
    }];
}

- (void)loadData
{
    self.model = [[NIMutableTableViewModel alloc] initWithDelegate:self];
    [self.model setSectionIndexType:NITableViewModelSectionIndexNone showsSearch:NO showsSummary:NO];
    self.actions = [[NITableViewActions alloc] initWithTarget:self];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddButton)];
}

- (NSString *)randomName
{
    NSMutableString *name = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < arc4random_uniform(10) + 5; i ++) {
        [name appendFormat:@"%c", arc4random_uniform('z' - 'a') + 'a'];
    }
    return [name capitalizedString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapAddButton
{
    NSIndexSet *indexSet = [self.model appendSectionHeaderWithTitle:[self randomName]];
    [self.model addSectionFooterWithTitle:[NSString stringWithFormat:@"%@ -- footer", [self randomName]]];
    NSMutableArray *objects = [NSMutableArray array];
    for (NSInteger i = 0; i < arc4random_uniform(10) + 1; i ++) {
        [objects addObject:[self.actions attachToObject:[NITitleCellObject objectWithTitle:[self randomName]] tapBlock:^BOOL(id object, id target, NSIndexPath *indexPath) {
            if ([object isKindOfClass:[NITitleCellObject class]])
            {
                NITitleCellObject *titleCellObject = (NITitleCellObject *)object;
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Notice" message:titleCellObject.title
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            return YES;
        }]];
    }
    NSArray *indexPaths = [self.model addObjectsFromArray:objects];
    if (indexSet) {
        [self.model updateSectionIndex];
        [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView scrollToRowAtIndexPath:indexPaths.lastObject atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableViewModel:(NIMutableTableViewModel *)tableViewModel canEditObject:(id)object atIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
    return YES;
}

- (BOOL)tableViewModel:(NIMutableTableViewModel *)tableViewModel shouldDeleteObject:(id)object atIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
    self.indexPathForDeletion = indexPath;
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Confirm" message:@"Are you sure you want to delete this cell?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *indexPaths = [self.model removeObjectAtIndexPath:self.indexPathForDeletion];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        self.indexPathForDeletion = nil;
    }];
    [ac addAction:cancelAction];
    [ac addAction:confirmAction];
    [self presentViewController:ac animated:YES completion:nil];
    
    return NO;
}

- (UITableViewCell *)tableViewModel:(NITableViewModel *)tableViewModel cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withObject:(id)object
{
    return [NICellFactory tableViewModel:tableViewModel cellForTableView:tableView atIndexPath:indexPath withObject:object];
}

- (void)tableView:(UITableView *)tableView didSelectSectionHeaderAtIndex:(NSUInteger)sectionIndex
{
    [self.model objectForHeaderInSection:sectionIndex];
    
    NSLog(@"在vc中响应点击表头的代理 ： %@", @(sectionIndex));
}

- (void)tableView:(UITableView *)tableView didSelectSectionFooterAtIndex:(NSUInteger)sectionIndex
{
    [self.model objectForFooterInSection:sectionIndex];
    
    NSLog(@"在vc中响应点击表尾的代理 ： %@", @(sectionIndex));
}

- (UITableViewHeaderFooterView *)tableViewModel:(NITableViewModel *)tableViewModel headerForTableView:(UITableView *)tableView inSection:(NSUInteger)section withObject:(id)object
{
    return [NITableHeaderFooterFactory headerFooterForTable:self.tableView inSection:section withTableViewModel:tableViewModel object:object];
}

- (UITableViewHeaderFooterView *)tableViewModel:(NITableViewModel *)tableViewModel footerForTableView:(UITableView *)tableView inSection:(NSUInteger)section withObject:(id)object
{
    return [NITableHeaderFooterFactory headerFooterForTable:self.tableView inSection:section withTableViewModel:tableViewModel object:object];
}

@end

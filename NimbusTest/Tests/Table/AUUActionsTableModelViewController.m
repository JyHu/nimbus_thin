//
//  AUUActionsTableModelViewController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUActionsTableModelViewController.h"
#import "NimbusModels.h"
#import "NimbusCore.h"

@interface AUUActionsTableModelViewController ()

@end

@implementation AUUActionsTableModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadData
{
    self.actions = [[NITableViewActions alloc] initWithTarget:self];
    
    NIActionBlock tapAction = ^BOOL(id object, UIViewController *viewcontroller, NSIndexPath *indexPath) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice" message:@"You tapped a cell" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [viewcontroller presentViewController:alert animated:YES completion:nil];
        
        return YES;
    };
    
    NIActionBlock tapAction2 = ^BOOL(id object, UIViewController *controller, NSIndexPath *indexPath) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice" message:@"Alternative tap action" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [controller presentViewController:alert animated:YES completion:nil];
        
        return YES;
    };
    
    NSArray *tableContents = @[
                               [NITitleCellObject objectWithTitle:@"No action attached"],
                               
                               @"",
                               [self.actions attachToObject:[NITitleCellObject objectWithTitle:@"Tap me"]
                                                   tapBlock:tapAction],
                               
                               
                               @"",
                               [self.actions attachToObject:[NITitleCellObject objectWithTitle:@"Navigate elsewhere"]
                                                   tapBlock:NIPushControllerAction([AUUActionsTableModelViewController class])],
                               
                               [self.actions attachToObject:[NITitleCellObject objectWithTitle:@"Detail action"]
                                               detailBlock:NIPushControllerAction([AUUActionsTableModelViewController class])],
                               
                               [self.actions attachToObject:[self.actions attachToObject:[NITitleCellObject objectWithTitle:@"Navigate and detail"]
                                                                                tapBlock:tapAction]
                                                detailBlock:NIPushControllerAction([AUUActionsTableModelViewController class])],
                               
                               [self.actions attachToObject:[self.actions attachToObject:[NITitleCellObject objectWithTitle:@"Tap and detail"]
                                                                                tapBlock:NIPushControllerAction([AUUActionsTableModelViewController class])]
                                                detailBlock:NIPushControllerAction([AUUActionsTableModelViewController class])],
                               
                               [self.actions attachToObject:[self.actions attachToObject:[self.actions attachToObject:[NITitleCellObject objectWithTitle:@"All actions"]
                                                                                                             tapBlock:tapAction]
                                                                         navigationBlock:NIPushControllerAction([AUUActionsTableModelViewController class])]
                                                detailBlock:NIPushControllerAction([AUUActionsTableModelViewController class])],
                               
                               
                               @"Implicit Actions",
                               
                               [NISubtitleCellObject objectWithTitle:@"Tap me" subtitle:@"Implicit action"],
                               
                               [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Override" subtitle:@"Explicit tap action"] tapBlock:tapAction2],
                               
                               
                               @"Selector Actions",
                               
                               [self.actions attachToObject:[NITitleCellObject objectWithTitle:@"Tap me"] tapSelector:@selector(didTapObject:)]
                               ];
    
    self.model = [[NITableViewModel alloc] initWithSectionedArray:tableContents delegate:(id)[NICellFactory class]];
    
    [self.actions attachToClass:[NISubtitleCellObject class] tapBlock:tapAction];
}

- (BOOL)didTapObject:(id)object
{
    NSLog(@"Did tap object %@", object);
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

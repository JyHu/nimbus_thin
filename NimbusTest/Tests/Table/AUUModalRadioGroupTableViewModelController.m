//
//  AUUModalRadioGroupTableViewModelController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUModalRadioGroupTableViewModelController.h"

typedef NS_ENUM(NSUInteger, AUURadioGroup) {
    AUURadioGroupOption1,
    AUURadioGroupOption2,
    AUURadioGroupOption3
};

@interface AUUModalRadioGroupTableViewModelController () <NIRadioGroupDelegate>

@property (retain, nonatomic) NIRadioGroup *radioGroup;

@end

@implementation AUUModalRadioGroupTableViewModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = [self.radioGroup forwardingTo:self];
}

- (void)loadData
{
    self.radioGroup = [[NIRadioGroup alloc] initWithController:self];
    self.radioGroup.delegate = self;
    self.radioGroup.cellTitle = @"Selection";
    self.radioGroup.controllerTitle = @"Make a selection";
    
    [self.radioGroup mapObject:[NITitleCellObject objectWithTitle:@"Option 1"] toIdentifier:AUURadioGroupOption1];
    [self.radioGroup mapObject:[NITitleCellObject objectWithTitle:@"Option 2"] toIdentifier:AUURadioGroupOption2];
    [self.radioGroup mapObject:[NITitleCellObject objectWithTitle:@"Option 3"] toIdentifier:AUURadioGroupOption3];
    
    NSArray *tableContents = @[self.radioGroup];
    
    self.radioGroup.selectedIdentifier = AUURadioGroupOption2;
    
    self.model = [[NITableViewModel alloc] initWithSectionedArray:tableContents delegate:(id)[NICellFactory class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)radioGroup:(NIRadioGroup *)radioGroup didSelectIdentifier:(NSInteger)identifier
{
    NSLog(@"Did select radio group option %zd ", identifier);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)radioGroup:(NIRadioGroup *)radioGroup textForIdentifier:(NSInteger)identifier
{
    switch (identifier) {
        case AUURadioGroupOption1:
            return @"Option 1";
        case AUURadioGroupOption2:
            return @"Option 2";
        case AUURadioGroupOption3:
            return @"Option 3";
        default:
            break;
    }
    
    return nil;
}

- (BOOL)radioGroup:(NIRadioGroup *)radioGroup radioGroupController:(NIRadioGroupController *)radioGroupController willAppear:(BOOL)animated
{
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:radioGroupController];
    [self presentViewController:nc animated:YES completion:nil];
    return NO;
}

@end

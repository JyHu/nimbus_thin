//
//  AUURadioGroupTableViewModelController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUURadioGroupTableViewModelController.h"

typedef NS_ENUM(NSUInteger, AUURadioGroup) {
    AUURadioGroupOption1,
    AUURadioGroupOption2,
    AUURadioGroupOption3
};

@interface AUURadioGroupTableViewModelController () <NIRadioGroupDelegate>

@property (retain, nonatomic) NIRadioGroup *radioGroup;

@end

@implementation AUURadioGroupTableViewModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = [self.actions forwardingTo:[self.radioGroup forwardingTo:self]];
}

- (void)loadData
{
    self.radioGroup = [[NIRadioGroup alloc] initWithController:self];
    self.radioGroup.delegate = self;
    self.actions = [[NITableViewActions alloc] initWithTarget:self];
    
    NSArray *tableContents = @[
                               [self.actions attachToObject:[NITitleCellObject objectWithTitle:@"Tap me"] tapSelector:@selector(didTapObject:)],
                               [self.radioGroup mapObject:[NITitleCellObject objectWithTitle:@"Option 1"] toIdentifier:AUURadioGroupOption1],
                               [self.radioGroup mapObject:[NITitleCellObject objectWithTitle:@"Option 2"] toIdentifier:AUURadioGroupOption2],
                               [self.radioGroup mapObject:[NITitleCellObject objectWithTitle:@"Option 3"] toIdentifier:AUURadioGroupOption3]
                               ];
    
    self.radioGroup.selectedIdentifier = AUURadioGroupOption2;
    
    self.model = [[NITableViewModel alloc] initWithSectionedArray:tableContents delegate:(id)[NICellFactory class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)didTapObject:(id)object
{
    NSLog(@"Did tap object %@", object);
    
    return YES;
}

- (void)radioGroup:(NIRadioGroup *)radioGroup didSelectIdentifier:(NSInteger)identifier
{
    NSLog(@"Did select radio group option %zd", identifier);
}

@end

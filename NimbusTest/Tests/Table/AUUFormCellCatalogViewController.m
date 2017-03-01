//
//  AUUFormCellCatalogViewController.m
//  NimbusTest
//
//  Created by JyHu on 2017/2/16.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUFormCellCatalogViewController.h"

typedef NS_ENUM(NSUInteger, AUURadioOption) {
    AUURadioOption1,
    AUURadioOption2,
    AUURadioOption3
};

typedef NS_ENUM(NSUInteger, AUUSubRadioOption) {
    AUUSubRadioOption1,
    AUUSubRadioOption2,
    AUUSubRadioOption3,
};

@interface AUUFormCellCatalogViewController () <UITextFieldDelegate, NIRadioGroupDelegate>

@property (retain, nonatomic) NIRadioGroup *radioGroup;

@property (retain, nonatomic) NIRadioGroup *subRadioGroup;

@end

@implementation AUUFormCellCatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = [self.radioGroup forwardingTo:[self.subRadioGroup forwardingTo:self]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTableView)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
}

- (void)loadData
{
    self.radioGroup = [[NIRadioGroup alloc] init];
    self.radioGroup.delegate = self;
    
    self.subRadioGroup = [[NIRadioGroup alloc] initWithController:self];
    self.subRadioGroup.delegate = self;
    self.subRadioGroup.cellTitle = @"Selection";
    self.subRadioGroup.controllerTitle = @"Make a selection";
    
    [self.subRadioGroup mapObject:[NISubtitleCellObject objectWithTitle:@"Sub Radio 1" subtitle:@"First option"] toIdentifier:AUUSubRadioOption1];
    [self.subRadioGroup mapObject:[NISubtitleCellObject objectWithTitle:@"Sub Radio 2" subtitle:@"Second option"] toIdentifier:AUUSubRadioOption2];
    [self.subRadioGroup mapObject:[NISubtitleCellObject objectWithTitle:@"Sub Radio 3" subtitle:@"Third option"] toIdentifier:AUUSubRadioOption3];
    
    NSArray *tableContents =
    @[
      @"Radio group",
      [self.radioGroup mapObject:[NISubtitleCellObject objectWithTitle:@"Radio 1" subtitle:@"First option"]
                    toIdentifier:AUURadioOption1],
      [self.radioGroup mapObject:[NISubtitleCellObject objectWithTitle:@"Radio 2" subtitle:@"Second option"]
                    toIdentifier:AUURadioOption2],
      [self.radioGroup mapObject:[NISubtitleCellObject objectWithTitle:@"Radio 3" subtitle:@"Third option"]
                    toIdentifier:AUURadioOption3],
      
      @"Radio group controller",
      self.subRadioGroup,
      
      @"NITextInputFormElement",
      [NITextInputFormElement textInputElementWithID:0 placeholderText:@"Placeholder" value:nil],
      [NITextInputFormElement textInputElementWithID:0 placeholderText:@"Placeholder" value:@"Initial value"],
      [NITextInputFormElement textInputElementWithID:1 placeholderText:nil value:@"Disabled input field" delegate:self],
      [NITextInputFormElement passwordInputElementWithID:0 placeholderText:@"Password" value:nil],
      [NITextInputFormElement passwordInputElementWithID:0 placeholderText:@"Password" value:@"Password"],
      
      @"NISwitchFormElement",
      [NISwitchFormElement switchElementWithID:0 labelText:@"Switch" value:NO],
      [NISwitchFormElement switchElementWithID:0 labelText:@"Switch with a really long label that will be cut off" value:YES],
      [NISwitchFormElement switchElementWithID:0 labelText:@"Switch with target/selector" value:NO didChangeTarget:self didChangeSelector:@selector(switchChanged:)],
      
      @"NISliderFormElement",
      [NISliderFormElement sliderElementWithID:0 labelText:@"Slider" value:45 minimumValue:0 maximumValue:100],
      
      @"NISegmentedControlForElement",
      [NISegmentedControlFormElement segmentedControlElementWithID:0 labelText:@"Text segments" segments:@[@"one", @"two"] selectedIndex:0],
      [NISegmentedControlFormElement segmentedControlElementWithID:0 labelText:@"Image segments" segments:@[[UIImage imageNamed:@"star.png"], [UIImage imageNamed:@"circle.png"]] selectedIndex:-1 didChangeTarget:self didChangeSelector:@selector(segmentedControlWithImageDidChangeValue:)],
      
      @"NIDatePickerFormElement",
      [NIDatePickerFormElement datePickerElementWithID:0 labelText:@"Date and time"
                                                  date:[NSDate date] datePickerMode:UIDatePickerModeDateAndTime],
      [NIDatePickerFormElement datePickerElementWithID:0 labelText:@"Date only"
                                                  date:[NSDate date] datePickerMode:UIDatePickerModeDate],
      [NIDatePickerFormElement datePickerElementWithID:0 labelText:@"Time only"
                                                  date:[NSDate date] datePickerMode:UIDatePickerModeTime
                                       didChangeTarget:self didChangeSelector:@selector(datePickerDidChangeValue:)],
      [NIDatePickerFormElement datePickerElementWithID:0 labelText:@"CountDown"
                                                  date:[NSDate date] datePickerMode:UIDatePickerModeCountDownTimer]
      ];
    
    self.radioGroup.selectedIdentifier = AUURadioOption1;
    self.subRadioGroup.selectedIdentifier = AUUSubRadioOption1;
    
    self.model = [[NITableViewModel alloc] initWithSectionedArray:tableContents delegate:(id)[NICellFactory class]];
}

- (void)switchChanged:(UISwitch *)uiswitch
{
    NSLog(@"switch changed to %@", uiswitch.on ? @"yes" : @"no");
}

- (void)segmentedControlWithImageDidChangeValue:(UISegmentedControl *)seg
{
    NSLog(@"segment control change value to index %zd", seg.selectedSegmentIndex);
}

- (void)datePickerDidChangeValue:(UIDatePicker *)dp
{
    NSLog(@"time only date picker changed value to %@", [NSDateFormatter localizedStringFromDate:dp.date
                                                                                       dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle]);
}

- (void)didTapTableView
{
    [self.view endEditing:YES];
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return textField.tag != 1;
}

#pragma mark - tabelview delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[NITextInputFormElementCell class]]) {
        NITextInputFormElementCell *textInputCell = (NITextInputFormElementCell *)cell;
        if (cell.tag == 1) {
            textInputCell.textField.textColor = [UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1];
        } else {
            textInputCell.textField.textColor = [UIColor blackColor];
        }
    }
}

#pragma mark - radio group delegate

- (void)radioGroup:(NIRadioGroup *)radioGroup didSelectIdentifier:(NSInteger)identifier
{
    if (radioGroup == self.radioGroup) {
        NSLog(@"radio group selection : %zd", identifier);
    } else if (radioGroup == self.subRadioGroup) {
        NSLog(@"sub radio group selection : %zd", identifier);
    }
}

- (NSString *)radioGroup:(NIRadioGroup *)radioGroup textForIdentifier:(NSInteger)identifier
{
    switch (identifier) {
        case AUUSubRadioOption1:
            return @"Option 1";
        case AUUSubRadioOption2:
            return @"Option 2";
        case AUUSubRadioOption3:
            return @"Option 3";
        default:
            break;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

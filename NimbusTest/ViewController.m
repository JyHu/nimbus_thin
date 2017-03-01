//
//  ViewController.m
//  NimbusTest
//
//  Created by 胡金友 on 2017/3/1.
//
//

#import "ViewController.h"

#import "NimbusModels.h"
#import "NITableViewActions.h"

#import "AUUBasicInstantiationTableModelTableViewController.h"
#import "AUUSectionedTableModelViewController.h"
#import "AUUIndexedTableModelViewController.h"
#import "AUUActionsTableModelViewController.h"
#import "AUURadioGroupTableViewModelController.h"
#import "AUUNestedRadioGroupViewModelController.h"
#import "AUUModalRadioGroupTableViewModelController.h"
#import "AUUFormCellCatalogViewController.h"
#import "AUUBlockCellsViewController.h"
#import "AUUSnapshotRotationTableViewModelController.h"
#import "AUUMutableTableViewModelController.h"

@interface ViewController ()

@property (retain, nonatomic) NITableViewModel *model;

@property (retain, nonatomic) NITableViewActions *actions;

@end

@implementation ViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    self.tableView.dataSource = self.model;
    self.tableView.delegate = [self.actions forwardingTo:self];
}

- (void)loadData
{
    self.actions = [[NITableViewActions alloc] initWithTarget:self];
    
    NSArray *sectionedObjects =
    @[
      @"Table Models",
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Basic Instantiation" subtitle:@"How to create a table view model"]
                   navigationBlock:NIPushControllerAction([AUUBasicInstantiationTableModelTableViewController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Sectioned Model" subtitle:@"Sectioned table view models"]
                   navigationBlock:NIPushControllerAction([AUUSectionedTableModelViewController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Indexed Model" subtitle:@"Indexed table view models"]
                   navigationBlock:NIPushControllerAction([AUUIndexedTableModelViewController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Actions" subtitle:@"Handling actions in table views"]
                   navigationBlock:NIPushControllerAction([AUUActionsTableModelViewController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Radio Group" subtitle:@"How to use radio groups"]
                   navigationBlock:NIPushControllerAction([AUURadioGroupTableViewModelController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Nested Radio Group" subtitle:@"How to nest radio groups"]
                   navigationBlock:NIPushControllerAction([AUUNestedRadioGroupViewModelController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Modal Radio Group" subtitle:@"Customizing presentation"]
                   navigationBlock:NIPushControllerAction([AUUModalRadioGroupTableViewModelController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Form Cell Catalog" subtitle:@"Table view cell for forms"]
                   navigationBlock:NIPushControllerAction([AUUFormCellCatalogViewController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Block Cells" subtitle:@"Rendering cells with blocks"]
                   navigationBlock:NIPushControllerAction([AUUBlockCellsViewController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Snapshot Rotation" subtitle:@"Rotating table views with snapshots"]
                   navigationBlock:NIPushControllerAction([AUUSnapshotRotationTableViewModelController class])],
      
      [self.actions attachToObject:[NISubtitleCellObject objectWithTitle:@"Mutable Models" subtitle:@"Mutating table view models"]
                   navigationBlock:NIPushControllerAction([AUUMutableTableViewModelController class])]
      ];
    
    self.model = [[NITableViewModel alloc] initWithSectionedArray:sectionedObjects delegate:(id)[NICellFactory class]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

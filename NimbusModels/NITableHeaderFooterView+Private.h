//
//  NITableHeaderFooterView+Private.h
//  Nimbus
//
//  Created by JyHu on 2017/3/12.
//
//

#import "NITableViewActions.h"
#import "NITableHeaderFooterView.h"

@interface NITableHeaderFooterView ()

@property (weak, nonatomic) UITableView *pri_tableView;

@property (assign, nonatomic) NSUInteger pri_sectionIndex;

@property (assign, nonatomic) id <NITableHeaderFooterDelegate> pri_headerFooterDelegate;

@end

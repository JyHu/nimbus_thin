//
//  NITableViewHeightAction.m
//  NimbusModels
//
//  Created by 胡金友 on 2018/6/27.
//

#import "NITableViewHeightAction.h"
#import "NIActions.h"
#import "NICellFactory.h"

@implementation NITableViewHeightAction

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = tableView.rowHeight;
    if ([tableView.dataSource conformsToProtocol:@protocol(NIActionsDataSource)]) {
        id object = [(id<NIActionsDataSource>)tableView.dataSource objectAtIndexPath:indexPath];
        id class = [object cellClass];
        if ([class respondsToSelector:@selector(heightForObject:atIndexPath:tableView:)]) {
            height = [class heightForObject:object atIndexPath:indexPath tableView:tableView];
        }
    }
    
    return height;
}

@end

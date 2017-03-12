//
//  NITableHeaderFooterView.h
//  Nimbus
//
//  Created by 胡金友 on 2017/3/1.
//
//

#import <UIKit/UIKit.h>

@protocol NITableHeaderFooterView <NSObject>

@required
- (BOOL)shouldUpdateHeaderFooterWithObject:(nullable id)object;

@optional
+ (BOOL)reuseable;
+ (CGFloat)heightForObject:(nullable id)object atSection:(NSUInteger)section tableView:(nullable UITableView *)tableView;

@end

@protocol NITableHeaderFooterDelegate <NSObject>

- (void)tableView:(nullable UITableView *)tableView didSelectSectionHeaderAtIndex:(NSUInteger)sectionIndex;
- (void)tableView:(nullable UITableView *)tableView didSelectSectionFooterAtIndex:(NSUInteger)sectionIndex;

@end

typedef NS_ENUM(NSUInteger, NITableViewHeaderFooterType) {
    NITableViewHeaderFooterTypeHeader,
    NITableViewHeaderFooterTypeFooter
};



@interface NITableHeaderFooterView : UITableViewHeaderFooterView <NITableHeaderFooterView>

@property (assign, nonatomic) NITableViewHeaderFooterType type;

@property (retain, nonatomic, readonly)  UITapGestureRecognizer * _Nullable tapGesture;

- (void)handleForTap;

@end

@interface NITableCommonViewHeaderFooterView : NITableHeaderFooterView

@end

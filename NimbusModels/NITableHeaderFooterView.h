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

/**
 用于参数的传递，更新视图
 */
- (BOOL)shouldUpdateHeaderFooterWithObject:(nullable id)object;

@optional
+ (BOOL)reuseable;

/**
 用于获取header、footer的高度

 @param object header、footer的数据
 @param section header、footer的索引
 @param tableView 所在的table
 @return 高度
 */
+ (CGFloat)heightForObject:(nullable id)object atSection:(NSUInteger)section tableView:(nullable UITableView *)tableView;

@end

@protocol NITableHeaderFooterDelegate <NSObject>

/**
 事件传递的方法，用于将header、footer上的点击事件传递到viewController，只需要实现这个代理方法即可

 @param tableView header、footer在的table
 @param sectionIndex 索引
 */
- (void)tableView:(nullable UITableView *)tableView didSelectSectionHeaderAtIndex:(NSUInteger)sectionIndex;
- (void)tableView:(nullable UITableView *)tableView didSelectSectionFooterAtIndex:(NSUInteger)sectionIndex;

@end

typedef NS_ENUM(NSUInteger, NITableViewHeaderFooterType) {
    NITableViewHeaderFooterTypeHeader,  // section header
    NITableViewHeaderFooterTypeFooter   // section footer
};



@interface NITableHeaderFooterView : UITableViewHeaderFooterView <NITableHeaderFooterView>

/**
 当前视图的类型，是header、还是footer
 */
@property (assign, nonatomic) NITableViewHeaderFooterType type;

/**
 header、footer上得点击手势，只读，可以禁止这个手势
 */
@property (retain, nonatomic, readonly)  UITapGestureRecognizer * _Nullable tapGesture;

/**
 将点击事件传递到header、footer视图里，重写这个方法即可
 */
- (void)handleForTap;

@end

/**
 自定义视图的header、footer视图，单独写是因为需要在这里做一个复用的清理
 */
@interface NITableCommonViewHeaderFooterView : NITableHeaderFooterView

@end

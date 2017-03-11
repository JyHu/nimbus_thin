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



typedef NS_ENUM(NSUInteger, NITableViewHeaderFooterType) {
    NITableViewHeaderFooterTypeHeader,
    NITableViewHeaderFooterTypeFooter
};




@interface NITableHeaderFooterView : UITableViewHeaderFooterView <NITableHeaderFooterView>

@property (assign, nonatomic) NITableViewHeaderFooterType type;

@property (retain, nonatomic) _Nullable id headerFooterObject;

@property (retain, nonatomic, readonly)  UITapGestureRecognizer * _Nullable tapGesture;

+ (nullable instancetype)headerWithReuseIdentifier:(nullable NSString *)reuseIdentifier;
+ (nullable instancetype)footerWithReuseIdentifier:(nullable NSString *)reuseIdentifier;

- (void)handleForTap;

@end


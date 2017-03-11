//
//  NITableHeaderFooterView.m
//  Nimbus
//
//  Created by 胡金友 on 2017/3/1.
//
//

#import "NITableHeaderFooterView.h"
#import "NITableHeaderFooterFactory.h"

@interface NITableHeaderFooterView()

@property (retain, nonatomic) UITapGestureRecognizer *pri_tapGesture;

@end

@implementation NITableHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addGestureRecognizer:self.pri_tapGesture];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self addGestureRecognizer:self.pri_tapGesture];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addGestureRecognizer:self.pri_tapGesture];
    }
    return self;
}

+ (instancetype)headerWithReuseIdentifier:(NSString *)reuseIdentifier
{
    NITableHeaderFooterView *header = [[NITableHeaderFooterView alloc] initWithReuseIdentifier:reuseIdentifier];
    return header;
}

+ (instancetype)footerWithReuseIdentifier:(NSString *)reuseIdentifier
{
    NITableHeaderFooterView *footer = [[NITableHeaderFooterView alloc] initWithReuseIdentifier:reuseIdentifier];
    return footer;
}

- (BOOL)shouldUpdateHeaderFooterWithObject:(id)object
{
    if ([object isKindOfClass:[NITitleHeaderObject class]])
    {
        NITitleHeaderObject *titleHeaderObject = (NITitleHeaderObject *)object;
        self.textLabel.text = titleHeaderObject.title;
    }
    else if ([object isKindOfClass:[NITitleFooterObject class]])
    {
        NITitleFooterObject *titleFooterObject = (NITitleFooterObject *)object;
        self.textLabel.text = titleFooterObject.title;
    }
    else if ([object isKindOfClass:[NICommonHeaderViewObject class]])
    {
        NICommonHeaderViewObject *commonViewHeaderObject = (NICommonHeaderViewObject *)object;
        UIView *commonHeaderView = commonViewHeaderObject.commonView;
        if (commonHeaderView)
        {
            commonHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(commonHeaderView.frame), CGRectGetHeight(commonHeaderView.frame));
            [self.contentView addSubview:commonHeaderView];
        }
    }
    else if ([object isKindOfClass:[NICommonFooterViewObject class]])
    {
        NICommonFooterViewObject *commonFooterViewObject = (NICommonFooterViewObject *)object;
        UIView *commonFooterView = commonFooterViewObject.commonView;
        if (commonFooterView)
        {
            commonFooterView.frame = CGRectMake(0, 0, CGRectGetWidth(commonFooterView.frame), CGRectGetHeight(commonFooterView.frame));
            [self.contentView addSubview:commonFooterView];
        }
    }
    else if ([object isKindOfClass:[NISubTitleHeaderObject class]])
    {
        NISubTitleHeaderObject *detailHeaderObject = (NISubTitleHeaderObject *)object;
        self.textLabel.text = detailHeaderObject.title;
        self.detailTextLabel.text = detailHeaderObject.detail;
    }
    else if ([object isKindOfClass:[NISubTitleFooterObject class]])
    {
        NISubTitleFooterObject *detailFooterObject = (NISubTitleFooterObject *)object;
        self.textLabel.text = detailFooterObject.title;
        self.detailTextLabel.text = detailFooterObject.detail;
    }
    
    self.headerFooterObject = object;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atSection:(NSUInteger)section tableView:(UITableView *)tableView
{
    if ([object isKindOfClass:[NICommonHeaderViewObject class]]) {
        NICommonHeaderViewObject *commonHeaderViewObject = (NICommonHeaderViewObject *)object;
        return commonHeaderViewObject.commonView.frame.size.height;
    } else if ([object isKindOfClass:[NICommonFooterViewObject class]]) {
        NICommonFooterViewObject *commonFooterViewObject = (NICommonFooterViewObject *)object;
        return commonFooterViewObject.commonView.frame.size.height;
    } else if ([object isKindOfClass:[NITitleHeaderObject class]] || [object isKindOfClass:[NITitleFooterObject class]]) {
        return 30;
    }
    
    return tableView.sectionHeaderHeight;
}

- (UITapGestureRecognizer *)pri_tapGesture
{
    if (!_pri_tapGesture)
    {
        _pri_tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(handleForTap)];
    }
    
    return _pri_tapGesture;
}

- (void)handleForTap {}

@end

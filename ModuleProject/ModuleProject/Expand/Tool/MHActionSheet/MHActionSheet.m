//
//  HMActionSheet.m
//  MHActionSheet
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.

#import "MHActionSheet.h"
#import "MHSheetView.h"
#import "MHSheetHead.h"
#import "MHSheetFoot.h"

#define kPushTime 0.3
#define kDismissTime 0.3
#define kWH ([[UIScreen mainScreen] bounds].size.height)
#define kWW ([[UIScreen mainScreen] bounds].size.width)
#define kCellH (kWH<500?45:(kWH<600?47:(kWH<700?49:50)))
#define kMW (kWW-2*kMargin)
#define kCornerRadius 5
#define kMargin 6

@interface MHActionSheet()<MHSheetViewDelegate>

@property (strong, nonatomic) UIButton *bgButton;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) MHSheetView *sheetView;
@property (strong, nonatomic) MHSheetHead *titleView;
@property (strong, nonatomic) MHSheetFoot *footView;
@property (strong, nonatomic) UIView *marginView;
@property (assign, nonatomic) CGFloat contentVH;
@property (assign, nonatomic) CGFloat contentViewY;
@property (assign, nonatomic) CGFloat footViewY;

@property (strong, nonatomic) NSIndexPath *selectIndex;
@property (strong, nonatomic) SelectIndexBlock selectBlock;
@property (strong, nonatomic) NSArray *dataSource;
@property (assign, nonatomic) MHSheetStyle sheetStyle;
@end

@implementation MHActionSheet

- (id)initSheetWithTitle:(NSString *)title
                   style:(MHSheetStyle)style
              itemTitles:(NSArray *)itemTitles
{
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {

        self.sheetStyle = style;
        self.dataSource = itemTitles;
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        //半透明背景按钮
        self.bgButton = [[UIButton alloc] init];
        [self addSubview:self.bgButton];
        self.bgButton.backgroundColor = [UIColor blackColor];
        self.bgButton.alpha = 0.35;
        //title和sheetView的容器View
        self.contentView = [[UIView alloc] init];
        [self addSubview:self.contentView];
        //取消按钮View
        self.footView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MHSheetFoot class]) owner:self options:nil].lastObject;
        [self addSubview:self.footView];
        //选择TableView
        self.sheetView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MHSheetView class]) owner:self options:nil].lastObject;
        self.sheetView.cellHeight = kCellH;
        self.sheetView.delegate = self;
        self.sheetView.dataSource = self.dataSource;
        [self.contentView addSubview:self.sheetView];

        //选择样式
        if (style == MHSheetStyleDefault) {
            self = [self upDefaultStyeWithItems:itemTitles title:title selfView:self];
            [self pushDefaultStyeSheetView];
        }
        else if (style == MHSheetStyleWeiChat) {
            self = [self upWeiChatStyeWithItems:itemTitles title:title selfView:self];
            [self pushWeiChatStyeSheetView];
        }
        else if (style == MHSheetStyleTable) {
            self = [self upTableStyeWithItems:itemTitles title:title selfView:self];
            [self pushTableStyeSheetView];
        }
    }
    return self;
}

///初始化默认样式
- (id)upDefaultStyeWithItems:(NSArray *)itemTitles title:(NSString *)title selfView:(MHActionSheet *)selfView
{
    //半透明背景按钮
    [selfView.bgButton addTarget:self action:@selector(dismissDefaulfSheetView) forControlEvents:UIControlEventTouchUpInside];
    selfView.bgButton.frame = CGRectMake(0, 0, kWW, kWH);
    //标题
    BOOL isTitle = NO;
    if (title.length > 0) {
        selfView.titleView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MHSheetHead class]) owner:selfView options:nil].lastObject;
        selfView.titleView.headLabel.text = title;
        isTitle = YES;
        [selfView.contentView addSubview:selfView.titleView];
    }
    //布局子控件
    int cellCount = (int)itemTitles.count;
    selfView.contentVH = kCellH * (cellCount + isTitle);
    CGFloat maxH = kWH - 50 - (kCellH + kMargin * 2);
    if (selfView.contentVH > maxH) {
        selfView.contentVH = maxH;
        selfView.sheetView.tableView.scrollEnabled = YES;
    } else {
        selfView.sheetView.tableView.scrollEnabled = NO;
    }
    
    selfView.footViewY = kWH - kCellH - kMargin;
    selfView.footView.frame = CGRectMake(kMargin, kWH + selfView.contentVH + kMargin, kMW, kCellH);
    selfView.contentViewY = kWH - CGRectGetHeight(selfView.footView.frame) - selfView.contentVH - kMargin * 2;
    selfView.contentView.frame = CGRectMake(kMargin, kWH, kMW, selfView.contentVH);
    
    CGFloat sheetY = 0;
    CGFloat sheetH = CGRectGetHeight(selfView.contentView.frame);
    if (isTitle) {
        selfView.titleView.frame = CGRectMake(0, 0, kMW, kCellH);
        sheetY = CGRectGetHeight(selfView.titleView.frame);
        sheetH = CGRectGetHeight(selfView.contentView.frame) - CGRectGetHeight(selfView.titleView.frame);
    }
    selfView.sheetView.frame = CGRectMake(0, sheetY, kMW, sheetH);
    //设置圆角
    selfView.contentView.layer.cornerRadius = kCornerRadius;
    selfView.contentView.layer.masksToBounds = YES;
    selfView.footView.layer.cornerRadius = kCornerRadius;
    selfView.footView.layer.masksToBounds = YES;
    [selfView.footView.footButton addTarget:selfView action:@selector(dismissDefaulfSheetView) forControlEvents:UIControlEventTouchUpInside];
    return selfView;
}

///初始化微信样式
- (id)upWeiChatStyeWithItems:(NSArray *)itemTitles title:(NSString *)title selfView:(MHActionSheet *)selfView
{
    [selfView.bgButton addTarget:selfView action:@selector(dismissWeiChatStyeSheetView) forControlEvents:UIControlEventTouchUpInside];
    selfView.bgButton.frame = CGRectMake(0, 0, kWW, kWH);
    [selfView.footView.footButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selfView.footView.footButton.titleLabel.font = [UIFont systemFontOfSize:18];
    if ([[UIScreen mainScreen] bounds].size.height == 667) {
        selfView.footView.footButton.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    else if ([[UIScreen mainScreen] bounds].size.height > 667) {
        selfView.footView.footButton.titleLabel.font = [UIFont systemFontOfSize:21];
    }
    
    //中间空隙
    selfView.marginView = [[UIView alloc] init];
    selfView.marginView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    selfView.marginView.alpha = 0.0;
    [selfView addSubview:selfView.marginView];
    
    //标题
    BOOL isTitle = NO;
    if (title.length > 0) {
        selfView.titleView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MHSheetHead class]) owner:selfView options:nil].lastObject;
        selfView.titleView.headLabel.text = title;
        isTitle = YES;
        [selfView.contentView addSubview:selfView.titleView];
    }
    selfView.sheetView.cellTextColor = [UIColor blackColor];
    
    //布局子控件
    int cellCount = (int)itemTitles.count;
    selfView.contentVH = kCellH * (cellCount + isTitle);
    CGFloat maxH = kWH - 50 - (kCellH + kMargin);
    if (selfView.contentVH > maxH) {
        selfView.contentVH = maxH;
        selfView.sheetView.tableView.scrollEnabled = YES;
    } else {
        selfView.sheetView.tableView.scrollEnabled = NO;
    }
    
    selfView.footViewY = kWH - kCellH;
    selfView.footView.frame = CGRectMake(0, selfView.footViewY + selfView.contentVH, kWW, kCellH);
    
    selfView.contentViewY = kWH - CGRectGetHeight(selfView.footView.frame) - selfView.contentVH - kMargin;
    selfView.contentView.frame = CGRectMake(0, kWH, kWW, selfView.contentVH);
    
    CGFloat sheetY = 0;
    CGFloat sheetH = CGRectGetHeight(selfView.contentView.frame);
    if (isTitle) {
        selfView.titleView.frame = CGRectMake(0, 0, kWW, kCellH);
        sheetY = CGRectGetHeight(selfView.titleView.frame);
        sheetH = CGRectGetHeight(selfView.contentView.frame) - CGRectGetHeight(selfView.titleView.frame);
    }
    selfView.sheetView.frame = CGRectMake(0, sheetY, kWW, sheetH);
    selfView.marginView.frame = CGRectMake(0, kWH + sheetH, kWW, kMargin);
    
    [selfView.footView.footButton addTarget:self action:@selector(dismissWeiChatStyeSheetView) forControlEvents:UIControlEventTouchUpInside];
    return selfView;
}

///初始化TableView样式
- (id)upTableStyeWithItems:(NSArray *)itemTitles title:(NSString *)title selfView:(MHActionSheet *)selfView
{
    if (selfView.footView) {
        [selfView.footView removeFromSuperview];
    }
    [selfView.bgButton addTarget:selfView action:@selector(dismissTableStyeSheetView) forControlEvents:UIControlEventTouchUpInside];
    selfView.bgButton.frame = CGRectMake(0, 0, kWW, kWH);

    //标题
    BOOL isTitle = NO;
    if (title.length > 0) {
        selfView.titleView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MHSheetHead class]) owner:selfView options:nil].lastObject;
        selfView.titleView.headLabel.text = title;
        selfView.titleView.headLabel.textAlignment = NSTextAlignmentLeft;
        isTitle = YES;
        [selfView.contentView addSubview:selfView.titleView];
    }
    selfView.sheetView.cellTextColor = [UIColor blackColor];
    selfView.sheetView.cellTextStyle = NSTextStyleLeft;
    selfView.sheetView.tableView.scrollEnabled = YES;
    selfView.sheetView.showTableDivLine = YES;
    
    //布局子控件
    int cellCount = (int)itemTitles.count;
    selfView.contentVH = kCellH * (cellCount + isTitle);
    CGFloat maxH = kWH - 100;
    if (selfView.contentVH > maxH) {
        selfView.contentVH = maxH;
    }

    selfView.contentViewY = kWH - selfView.contentVH;
    selfView.contentView.frame = CGRectMake(0, kWH, kWW, selfView.contentVH);

    CGFloat sheetY = 0;
    CGFloat sheetH = CGRectGetHeight(selfView.contentView.frame);
    if (isTitle) {
        selfView.titleView.frame = CGRectMake(0, 0, kWW, kCellH);
        sheetY = CGRectGetHeight(selfView.titleView.frame);
        sheetH = CGRectGetHeight(selfView.contentView.frame) - CGRectGetHeight(selfView.titleView.frame);
    }
    selfView.sheetView.frame = CGRectMake(0, sheetY, kWW, sheetH);
    return selfView;
}

//显示默认样式
- (void)pushDefaultStyeSheetView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kPushTime animations:^{
        weakSelf.contentView.frame = CGRectMake(kMargin, weakSelf.contentViewY, kMW, weakSelf.contentVH);
        weakSelf.footView.frame = CGRectMake(kMargin, weakSelf.footViewY, kMW, kCellH);
        weakSelf.bgButton.alpha = 0.35;
    }];
}

//显示像微信的样式
- (void)pushWeiChatStyeSheetView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kPushTime animations:^{
        weakSelf.contentView.frame = CGRectMake(0, weakSelf.contentViewY, kWW, weakSelf.contentVH);
        weakSelf.footView.frame = CGRectMake(0, weakSelf.footViewY, kWW, kCellH);
        weakSelf.marginView.frame = CGRectMake(0, weakSelf.footViewY - kMargin, kWW, kMargin);
        weakSelf.bgButton.alpha = 0.35;
        weakSelf.marginView.alpha = 1.0;
    }];
}

//显示TableView的样式
- (void)pushTableStyeSheetView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kPushTime animations:^{
        weakSelf.contentView.frame = CGRectMake(0, weakSelf.contentViewY, kWW, weakSelf.contentVH);
        weakSelf.bgButton.alpha = 0.35;
    }];
}

//显示
- (void)show
{
    if (_sheetStyle == MHSheetStyleDefault) {
        [self pushDefaultStyeSheetView];
    }
    else if (_sheetStyle == MHSheetStyleWeiChat) {
        [self pushWeiChatStyeSheetView];
    }
    else if (_sheetStyle == MHSheetStyleTable) {
        [self pushTableStyeSheetView];
    }
}


//消失默认样式
- (void)dismissDefaulfSheetView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kDismissTime animations:^{
        weakSelf.contentView.frame = CGRectMake(kMargin, kWH, kMW, weakSelf.contentVH);
        weakSelf.footView.frame = CGRectMake(kMargin, kWH + weakSelf.contentVH, kMW, kCellH);
        weakSelf.bgButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf.contentView removeFromSuperview];
        [weakSelf.footView removeFromSuperview];
        [weakSelf.bgButton removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

//消失微信样式
- (void)dismissWeiChatStyeSheetView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kDismissTime animations:^{
        weakSelf.contentView.frame = CGRectMake(0, kWH, kWW, weakSelf.contentVH);
        weakSelf.footView.frame = CGRectMake(0, weakSelf.footViewY + weakSelf.contentVH, kWW, kCellH);
        weakSelf.marginView.frame = CGRectMake(0, kWH + CGRectGetHeight(weakSelf.contentView.frame) + CGRectGetHeight(weakSelf.titleView.frame), kWW, kMargin);
        weakSelf.bgButton.alpha = 0.0;
        weakSelf.marginView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf.contentView removeFromSuperview];
        [weakSelf.footView removeFromSuperview];
        [weakSelf.marginView removeFromSuperview];
        [weakSelf.bgButton removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

//消失TableView样式
- (void)dismissTableStyeSheetView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:kDismissTime animations:^{
        weakSelf.contentView.frame = CGRectMake(0, kWH, kWW, weakSelf.contentVH);
        weakSelf.bgButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf.contentView removeFromSuperview];
        [weakSelf.bgButton removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

- (void)setTitleTextFont:(UIFont *)titleTextFont
{
    _titleView.headLabel.font = titleTextFont;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
    if (titleTextColor) {
        _titleView.headLabel.textColor = titleTextColor;
    }
}

- (void)setItemTextFont:(UIFont *)itemTextFont
{
    if (itemTextFont) {
        _sheetView.cellTextFont = itemTextFont;
    }
}

- (void)setItemTextColor:(UIColor *)itemTextColor
{
    if (itemTextColor) {
        _sheetView.cellTextColor = itemTextColor;
    }
}

- (void)setCancleTextFont:(UIFont *)cancleTextFont
{
    if (cancleTextFont) {
        [_footView.footButton.titleLabel setFont:cancleTextFont];
    }
}

- (void)setCancleTextColor:(UIColor *)cancleTextColor
{
    if (cancleTextColor) {
        [_footView.footButton setTitleColor:cancleTextColor forState:UIControlStateNormal];
    }
}

- (void)setCancleTitle:(NSString *)cancleTitle
{
    if (cancleTitle) {
        [_footView.footButton setTitle:cancleTitle forState:UIControlStateNormal];
    }
}

- (void)setIsUnifyCancleAction:(BOOL)isUnifyCancleAction
{
    if (isUnifyCancleAction) {
        [self.footView.footButton addTarget:self action:@selector(footButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)didFinishSelectIndex:(SelectIndexBlock)block
{
    _selectBlock = block;
}

//把取消按钮的点击加入TableView的事件中统一处理
- (void)footButtonAction:(id)sender
{
    NSInteger indexsCount = (NSInteger)self.dataSource.count;
    if (indexsCount) {
        [self sheetViewDidSelectIndex:indexsCount selectTitle:_footView.footButton.titleLabel.text];
    }
}

//点击了TableView的哪行
- (void)sheetViewDidSelectIndex:(NSInteger)Index selectTitle:(NSString *)title
{
    if (_selectBlock) {
        _selectBlock(Index,title);
    }
    
    if ([self.delegate respondsToSelector:@selector(sheetViewDidSelectIndex:title:)]) {
        [self.delegate sheetViewDidSelectIndex:Index title:title];
    }
    
    if ([self.delegate respondsToSelector:@selector(sheetViewDidSelectIndex:title:sender:)]) {
        [self.delegate sheetViewDidSelectIndex:Index title:title sender:self];
    }
    if (_sheetStyle == MHSheetStyleDefault) {
        [self dismissDefaulfSheetView];
    }
    else if (_sheetStyle == MHSheetStyleWeiChat) {
        [self dismissWeiChatStyeSheetView];
    }
    else if (_sheetStyle == MHSheetStyleTable) {
        [self dismissTableStyeSheetView];
    }
}

@end

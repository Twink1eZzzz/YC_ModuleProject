//
//  YXCustomActionSheet.m
//  YXCustomActionSheet
//
//  Created by Houhua Yan on 16/7/14.
//  Copyright © 2016年 YanHouhua. All rights reserved.
//

#import "YXCustomActionSheet.h"
#import "XMShareWeiboUtil.h"
#import "XMShareWechatUtil.h"
#import "XMShareQQUtil.h"
#define ColumnNum 4

@interface YXCustomActionSheet()
{
    UIView *_backView;
}
@end

@implementation YXCustomActionSheet

- (BOOL)filterDataName:(NSString *)name
{
    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    BOOL hadInstalledWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]];
    
    if ([name isEqualToString:@"微信"] && (hadInstalledWeixin == YES)) {
        return YES;
    }else if ([name isEqualToString:@"朋友圈"] && (hadInstalledWeixin == YES)){
        return YES;
    }else if ([name isEqualToString:@"QQ"] && (hadInstalledQQ == YES)) {
        return YES;
    }else if ([name isEqualToString:@"QQ空间"] && (hadInstalledQQ == YES)) {
        return YES;
    }else if ([name isEqualToString:@"新浪微博"] || (hadInstalledWeibo == YES)){
        return YES;
    }else {
        return NO;
    }
}


- (void) showInView:(UIView *)superView contentArray:(NSArray *)contentArray
{
    NSMutableArray *InstallArray = [NSMutableArray arrayWithCapacity:0];
    if (contentArray == nil || contentArray.count < 1) {
        return;
    }else {
        for (int i = 0; i < contentArray.count; i++) {
            NSDictionary *dic = [contentArray objectAtIndex:i];
            NSString *name = dic[@"name"];
            if ([self filterDataName:name] == YES) {
                [InstallArray addObject:contentArray[i]];
            }
        }
        
        if (InstallArray.count == 0) {
            showAlert(@"请下载分享相关应用");
            return;
        }
    }
    self.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    
    [self addBackView:superView];

    CGFloat btnW = 60;
    CGFloat btnH = 60;
    int marginY = 15;
    CGFloat firstY = 50;
    
    for (int i = 0; i < InstallArray.count; i++) {
        NSDictionary *dic = [InstallArray objectAtIndex:i];
        NSString *name = dic[@"name"];
        NSString *icon = dic[@"icon"];
        YXActionSheetButton *btn = [YXActionSheetButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        CGFloat marginX = (self.frame.size.width - ColumnNum * btnW) / (ColumnNum + 1);
        int col = i % ColumnNum;
        int row = i / ColumnNum;
        CGFloat btnX = marginX + (marginX + btnW) * col;
        CGFloat btnY = firstY + (marginY + btnH) * row;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        if ([self filterDataName:name] == YES) {
            
            [self addSubview:btn];
        }
    }
    
    //分享到
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"分 享";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGB(81, 95, 108);
    titleLabel.frame = CGRectMake(0, 10, self.frame.size.width, 30);
    [self addSubview:titleLabel];
    
    
    //计算frame
    [superView addSubview:self];
    
    NSUInteger row = (InstallArray.count - 1) / ColumnNum;
    CGFloat height = firstY + 50 + (row +1) * (btnH + marginY);
    
    CGFloat originY = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, originY, 0, height);
    [UIView animateWithDuration:0.25 animations:^{
        CGRect sF = self.frame;
        sF.origin.y = [UIScreen mainScreen].bounds.size.height - sF.size.height;
        self.frame = sF;
    }];

    //取消
    UIButton *canleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat canW = self.frame.size.width;
    CGFloat canH = 44;
    CGFloat canY = self.frame.size.height - canH;
    canleBtn.frame = CGRectMake(0, canY, canW, canH);
    [canleBtn setTitle:@"取 消" forState:UIControlStateNormal];
    canleBtn.titleLabel.font = titleLabel.font;
    [canleBtn setTitleColor:titleLabel.textColor forState:UIControlStateNormal];
    [canleBtn addTarget:self action:@selector(tapBg) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:canleBtn];
    
    //分割线
    UIView *line = [[UIView alloc] init];
    CGFloat lineY = CGRectGetMinY(canleBtn.frame)  - 2;
    line.frame = CGRectMake(40, lineY, [UIScreen mainScreen].bounds.size.width-80, 0.5);
    line.backgroundColor = RGB(180, 180, 180);
    [self addSubview:line];
   
}

- (void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    if (frame.size.height <= 0) {
        frame.size.height = 00;
    }
    frame.origin.x = 0;
    [super setFrame:frame];
}


#pragma mark - 添加背景视图
- (void) addBackView:(UIView *) superView
{
    _backView = [[UIView alloc] init];
    _backView.frame = superView.bounds;
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.4;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBg)];
    [_backView addGestureRecognizer:tap];
    [superView addSubview:_backView];
  
}

#pragma mark 点击背景阴影视图触发的方法
- (void)tapBg{
    [_backView removeFromSuperview];
    _backView = nil;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect sf = self.frame;
        sf.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = sf;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark 按钮被点击了
- (void)btnClick:(YXActionSheetButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"微信"]) {
        XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
        util.shareTitle = self.shareTitle;
        util.shareText = self.shareText;
        util.shareUrl = self.shareUrl;
        [util shareToWeixinSession];
    }else if ([btn.titleLabel.text isEqualToString:@"朋友圈"]) {
        XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
        util.shareTitle = self.shareTitle;
        util.shareText = self.shareText;
        util.shareUrl = self.shareUrl;
        [util shareToWeixinTimeline];
    }else if ([btn.titleLabel.text isEqualToString:@"QQ"]) {
        XMShareQQUtil *util = [XMShareQQUtil sharedInstance];
        util.shareTitle = self.shareTitle;
        util.shareText = self.shareText;
        util.shareUrl = self.shareUrl;
        [util shareToQQ];
    }else if ([btn.titleLabel.text isEqualToString:@"QQ空间"]) {
        XMShareQQUtil *util = [XMShareQQUtil sharedInstance];
        util.shareTitle = self.shareTitle;
        util.shareText = self.shareText;
        util.shareUrl = self.shareUrl;
        
        [util shareToQzone];
    }else if ([btn.titleLabel.text isEqualToString:@"新浪微博"]) {
        XMShareWeiboUtil *util = [XMShareWeiboUtil sharedInstance];
        util.shareTitle = self.shareTitle;
        util.shareText = self.shareText;
        util.shareUrl = self.shareUrl;
        
        [util shareToWeibo];
    }
    
    [self tapBg];
}



@end

//
//  YXCustomActionSheet.h
//  YXCustomActionSheet
//
//  Created by Houhua Yan on 16/7/14.
//  Copyright © 2016年 YanHouhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXActionSheetButton.h"

//@protocol YXCustomActionSheetDelegate <NSObject>
//
//@optional
//
//- (void) customActionSheetButtonClick:(YXActionSheetButton *) btn;
//
//@end


@interface YXCustomActionSheet : UIView

/**展示*/
- (void)showInView:(UIView *)superView contentArray:(NSArray *)contentArray;

//@property (nonatomic, weak) id<YXCustomActionSheetDelegate> delegate;

//  分享标题
@property (nonatomic, strong) NSString *shareTitle;

//  分享文本
@property (nonatomic, strong) NSString *shareText;

//  分享链接
@property (nonatomic, strong) NSString *shareUrl;


@end

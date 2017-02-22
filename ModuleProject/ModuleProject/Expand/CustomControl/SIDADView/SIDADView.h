//
//  SIDADView.h
//  SIDAdView
//
//  Created by XU JUNJIE on 13/7/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIDADView : UIView

/**
 *  带NavigationBar呈现方法：
 *  @param info        使用一登登录后回调的Info，广告视窗的title会根据Info内容使用不同的文案，传入的内容为用户回调信息的persona部分
 *  @param image       开发者的广告图
 *  @param color       弹出视窗的边框颜色
 *
 */
- (void)showInView:(UIView *)view FaceInfo: (NSDictionary *)info advertisementImage: (UIImage *)image borderColor: (UIColor *)color;

@end

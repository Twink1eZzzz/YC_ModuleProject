//
//  JHUD+WaitView.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/23.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "JHUD.h"

@interface JHUD (WaitView)


/**
 * 自定义
 * @param imageprefixname 图片的前缀名称 如：Loading_
 * @param firstindex 第一张图片的编号
 * @param lastIndex  最后一张图片的编号
 * @param msg 加载文字描述
 */
+ (void)showCustomAnimationWithImagePrefixName:(NSString *)imageprefixname FirstIndex:(int)firstindex LastIndex:(int)lastIndex Msg:(NSString *)msg;

// CircleAnimation样式
+ (void)showCircleAnimation;

+ (void)hideView;

@end

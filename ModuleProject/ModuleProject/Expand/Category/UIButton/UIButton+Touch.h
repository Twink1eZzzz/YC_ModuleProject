//
//  UIButton+Touch.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/3/10.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultInterval .5  //默认时间间隔

@interface UIButton (Touch)

/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;

@end

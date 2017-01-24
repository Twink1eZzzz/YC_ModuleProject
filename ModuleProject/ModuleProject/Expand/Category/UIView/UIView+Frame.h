//
//  UIView+Frame.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
// shortcuts for frame properties
@property (nonatomic, assign) CGPoint YC_origin;
@property (nonatomic, assign) CGSize YC_size;

// shortcuts for positions
@property (nonatomic) CGFloat YC_centerX;
@property (nonatomic) CGFloat YC_centerY;


@property (nonatomic) CGFloat YC_top;
@property (nonatomic) CGFloat YC_bottom;
@property (nonatomic) CGFloat YC_right;
@property (nonatomic) CGFloat YC_left;

@property (nonatomic) CGFloat YC_width;
@property (nonatomic) CGFloat YC_height;
@end

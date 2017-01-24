//
//  UIView+Frame.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
#pragma mark - Shortcuts for the coords


- (CGFloat)YC_top
{
    return self.frame.origin.y;
}

- (void)setYC_top:(CGFloat)YC_top
{
    CGRect frame = self.frame;
    frame.origin.y = YC_top;
    self.frame = frame;
}


- (CGFloat)YC_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYC_right:(CGFloat)YC_right
{
    CGRect frame = self.frame;
    frame.origin.x = YC_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)YC_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYC_bottom:(CGFloat)YC_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = YC_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)YC_left
{
    return self.frame.origin.x;
}

- (void)setYC_left:(CGFloat)YC_left
{
    CGRect frame = self.frame;
    frame.origin.x = YC_left;
    self.frame = frame;
}

- (CGFloat)YC_width
{
    return self.frame.size.width;
}

- (void)setYC_width:(CGFloat)YC_width
{
    CGRect frame = self.frame;
    frame.size.width = YC_width;
    self.frame = frame;
}

- (CGFloat)YC_height
{
    return self.frame.size.height;
}

- (void)setYC_height:(CGFloat)YC_height
{
    CGRect frame = self.frame;
    frame.size.height = YC_height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)YC_origin {
    return self.frame.origin;
}

- (void)setYC_origin:(CGPoint)YC_origin {
    CGRect frame = self.frame;
    frame.origin = YC_origin;
    self.frame = frame;
}

- (CGSize)YC_size {
    return self.frame.size;
}

- (void)setYC_size:(CGSize)YC_size {
    CGRect frame = self.frame;
    frame.size = YC_size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)YC_centerX {
    return self.center.x;
}

- (void)setYC_centerX:(CGFloat)YC_centerX {
    self.center = CGPointMake(YC_centerX, self.center.y);
}

- (CGFloat)YC_centerY {
    return self.center.y;
}

- (void)setYC_centerY:(CGFloat)YC_centerY {
    self.center = CGPointMake(self.center.x, YC_centerY);
}

@end

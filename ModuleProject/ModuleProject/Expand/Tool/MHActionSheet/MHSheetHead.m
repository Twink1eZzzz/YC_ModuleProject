//
//  MHSheetHead.m
//  MHActionSheet
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.

#import "MHSheetHead.h"

@implementation MHSheetHead

- (void)awakeFromNib
{
    [super awakeFromNib];
    _headLabel.backgroundColor = [UIColor whiteColor];
    _headLabel.textColor = [UIColor darkGrayColor];
    _headLabel.font = [UIFont systemFontOfSize:18];
    
    if ([[UIScreen mainScreen] bounds].size.height == 667) {
        _headLabel.font = [UIFont systemFontOfSize:20];
    }
    else if ([[UIScreen mainScreen] bounds].size.height > 667) {
        _headLabel.font = [UIFont systemFontOfSize:21];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}

@end

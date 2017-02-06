//
//  MHSheetCell.m
//  MHActionSheet
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.

#import "MHSheetCell.h"

@interface MHSheetCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *divLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableDivLineHeight;
@end

@implementation MHSheetCell

- (void)awakeFromNib {
    _divLineHeight.constant = 0.5;
    _tableDivLineHeight.constant = 0.5;
    _myLabel.backgroundColor = [UIColor whiteColor];
    _myLabel.textColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    _myLabel.font = [UIFont systemFontOfSize:18];
    if ([[UIScreen mainScreen] bounds].size.height == 667) {
        _myLabel.font = [UIFont systemFontOfSize:20];
    }
    else if ([[UIScreen mainScreen] bounds].size.height > 667) {
        _myLabel.font = [UIFont systemFontOfSize:21];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

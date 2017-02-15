//
//  YCTestCell.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/15.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCTestCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *gifLable;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

- (UIView *)snapshotView;
@end

//
//  YCCornerRadiusViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/22.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YCCornerRadiusViewController.h"
#import "UIImageView+CornerRadius.h"

@interface YCCornerRadiusViewController ()

@end

@implementation YCCornerRadiusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"高效圆角";
    
    self.view.backgroundColor = FlatOrange;
    
    UIImageView *imageView = [[UIImageView alloc] initWithRoundingRectImageView];
    [imageView setFrame:CGRectMake(100, 80, 150, 150)];
//     UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.layer.cornerRadius = 50;
//    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    
    UIImageView *imageViewSecond = [[UIImageView alloc] initWithCornerRadiusAdvance:20.f rectCornerType:UIRectCornerBottomLeft | UIRectCornerTopRight];
    [imageViewSecond setFrame:CGRectMake(100, 240, 150, 150)];
    //    UIImageView *imageViewSecond = [[UIImageView alloc] init];
//    imageViewSecond.layer.cornerRadius = 50;
//    imageViewSecond.layer.masksToBounds = YES;
    [self.view addSubview:imageViewSecond];
    
    
    UIImageView *imageViewThird = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 150, 150)];
    [imageViewThird zy_cornerRadiusAdvance:20.f rectCornerType:UIRectCornerBottomRight | UIRectCornerTopLeft];
    [imageViewThird zy_attachBorderWidth:5.f color:[UIColor blackColor]];
//    UIImageView *imageViewThird = [[UIImageView alloc] init];
//    imageViewThird.frame = CGRectMake(100, 400, 150, 150);
//    imageViewThird.layer.cornerRadius = 50;
//    imageViewThird.layer.masksToBounds = YES;
    [self.view addSubview:imageViewThird];
    
    imageView.image = [UIImage imageNamed:@"adImage"];
    imageViewSecond.image = [UIImage imageNamed:@"adImage"];
    imageViewThird.image = [UIImage imageNamed:@"adImage"];
}

@end

//
//  YCVectoringInstructionsViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/17.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YCVectoringInstructionsViewController.h"
#import "MPCoachMarks.h"

@interface YCVectoringInstructionsViewController ()

@end

@implementation YCVectoringInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"界面引导指示";
    self.view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) andColors:@[FlatRed,FlatPink,FlatYellow]];
    [self settingUI];
    
    [self showTutorial];
}

- (void)settingUI
{
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_wisdom"]];
    [self.view addSubview:iconImageView];
    [iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
    }];
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:customButton];
    customButton.backgroundColor = FlatGreenDark;
    [customButton setTitle:@"Button" forState:0];
    [customButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(iconImageView).offset(iconImageView.image.size.height + 50);
        make.size.equalTo(CGSizeMake(250, 40));
    }];
}

#pragma mark - Tutorial
-(void) showTutorial{
    
    CGRect coachmark1 = CGRectMake((Main_Screen_Width - 125) / 2, 80, 125, 125);
    CGRect coachmark2 = CGRectMake((Main_Screen_Width - 300) / 2, coachmark1.origin.y + coachmark1.size.height + 10, 300, 80);
    CGRect coachmark3 = CGRectMake(2, 20, 45, 45);
    
    // Setup coach marks
    NSArray *coachMarks = @[
                            @{
                                @"rect": [NSValue valueWithCGRect:coachmark1],
                                @"caption": @"随意点一下",
                                @"shape": [NSNumber numberWithInteger:SHAPE_CIRCLE],
                                @"position":[NSNumber numberWithInteger:LABEL_POSITION_BOTTOM],
                                @"alignment":[NSNumber numberWithInteger:LABEL_ALIGNMENT_RIGHT],
                                @"showArrow":[NSNumber numberWithBool:YES]
                                },
                            @{
                                @"rect": [NSValue valueWithCGRect:coachmark2],
                                @"caption": @"点击按钮"
                                },
                            @{
                                @"rect": [NSValue valueWithCGRect:coachmark3],
                                @"caption": @"导航栏上的按钮",
                                @"shape": [NSNumber numberWithInteger:SHAPE_SQUARE],
                                }
                            ];
    
    MPCoachMarks *coachMarksView = [[MPCoachMarks alloc] initWithFrame:self.navigationController.view.bounds coachMarks:coachMarks];
    [self.navigationController.view addSubview:coachMarksView];
    [coachMarksView start];
    
}

//设置左边按键
-(UIButton*)set_leftButton
{
    UIButton *left_button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    return left_button;
}

// 点击左边事件
- (void)left_button_event:(UIButton *)sender
{
    YCLog(@"点击事件");
}


@end

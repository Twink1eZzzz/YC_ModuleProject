//
//  YCLoginViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/16.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YCLoginViewController.h"
#import "HyTransitions.h"
#import "HyLoginButton.h"
#import "UIImage+Color.h"

@interface YCLoginViewController ()
@property (strong, nonatomic) UISwitch *switchButton;

@property (strong, nonatomic) UITextField *userNameTextField;

@property (strong, nonatomic) UITextField *pwdTextField;

@end

@implementation YCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)settingUI
{
    // 背景
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"street"]];
    [self.view addSubview:bgImage];
    [bgImage makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    // 关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.left.equalTo(self.view).offset(20);
    }];
    
    // 用户名输入框
    _userNameTextField = [self createTextFieldFont:[UIFont systemFontOfSize:14] placeholder:@"请输入手机号"];
    [self.view addSubview:_userNameTextField];
    _userNameTextField.keyboardType=UIKeyboardTypeNumberPad;
    _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_userNameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(140);
        make.height.equalTo(40);
        make.width.equalTo(Main_Screen_Width * 0.7);
    }];
    
    // 用户名图标
    UIImageView *userIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_landing_nickname"]];
    [self.view addSubview:userIcon];
    [userIcon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(145);
        make.left.equalTo(self.view).offset(20);
        make.size.equalTo(CGSizeMake(userIcon.image.size.width, userIcon.image.size.height));
    }];
    
    // 密码输入框
    _pwdTextField = [self createTextFieldFont:[UIFont systemFontOfSize:14] placeholder:@"请输入密码"];
    [self.view addSubview:_pwdTextField];
    _pwdTextField.secureTextEntry=YES;
    _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_pwdTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(180);
        make.height.equalTo(_userNameTextField);
        make.width.equalTo(_userNameTextField);
    }];
    // 密码图标
    UIImageView *pwdIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mm_normal"]];
    [self.view addSubview:pwdIcon];
    [pwdIcon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(185);
        make.left.equalTo(self.view).offset(20);
        make.size.equalTo(CGSizeMake(userIcon.image.size.width, userIcon.image.size.height));
    }];
    

    // 登录按钮
    HyLoginButton *loginButton = [[HyLoginButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.bounds) - (40 + 80), [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [loginButton setBackgroundColor:[UIColor colorWithRed:1 green:0.f/255.0f blue:128.0f/255.0f alpha:1]];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(PresentViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_pwdTextField).offset(60);
        make.height.equalTo(_pwdTextField);
        make.width.equalTo(Main_Screen_Width * 0.8);
    }];

    // Swith
    _switchButton = [[UISwitch alloc] init];
    [self.view addSubview:_switchButton];
    _switchButton.on = YES;
    [_switchButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageWithColor:RGBA(180, 180, 180, 0.3)]];
    line1.frame = CGRectMake(20, 180, Main_Screen_Width - 40, 1);
    [self.view addSubview:line1];
    
    UIImageView *line3 = [[UIImageView alloc]initWithImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    line3.frame = CGRectMake(2, 400, 100, 1);
    UIImageView *line4 = [[UIImageView alloc]initWithImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    line4.frame = CGRectMake(self.view.frame.size.width-100-4, 400, 100, 1);
    [self.view addSubview:line3];
    [self.view addSubview:line4];
    
}

-(UITextField *)createTextFieldFont:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]init];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

- (void)closeBtnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PresentViewController:(HyLoginButton *)button {
    MPWeakSelf(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_switchButton.on) {
            //网络正常 或者是密码账号正确跳转动画
            [button succeedAnimationWithCompletion:^{
                if (weakself.switchButton.on) {
                    [weakself showSuccessText:@"登录成功！"];
                    [weakself didPresentControllerButtonTouch];
                }
            }];
        } else {
            //网络错误 或者是密码不正确还原动画
            [button failedAnimationWithCompletion:^{
                if (weakself.switchButton.on) {
                    [weakself showErrorText:@"登录失败!"];
                    [weakself didPresentControllerButtonTouch];
                }
            }];
        }
    });
}

- (void)didPresentControllerButtonTouch {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_userNameTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_userNameTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
}

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
//                                                                  presentingController:(UIViewController *)presenting
//                                                                      sourceController:(UIViewController *)source {
//    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isPush:true];
//}
//
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isPush:false];
//}


@end

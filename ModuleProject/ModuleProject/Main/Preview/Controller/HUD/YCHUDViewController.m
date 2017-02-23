//
//  YCHUDViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/22.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YCHUDViewController.h"

@interface YCHUDViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *array;

@end

@implementation YCHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.navigationItem.title = @"HUD";
    self.array = @[@"MB-showTipMessageInWindow + Msg",
                   @"MB-showTipMessageInView + Msg",
                   @"MB-showTipMessageInWindow + timer",
                   @"MB-showTipMessageInView + timer",
                   @"MB-showActivityInWindow + Msg",
                   @"MB-showActivityInView + Msg",
                   @"MB-showActivityInWindow + Msg + timer",
                   @"MB-showActivityInView + Msg + timer",
                   @"showPendulumWithMessage",
                   @"showSuccessMessage",
                   @"showErrorMessage",
                   @"showInfoMessage"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [MBProgressHUD showTipMessageInWindow:self.array[indexPath.row]];
            break;
        case 1:
            [MBProgressHUD showTipMessageInView:self.array[indexPath.row]];
            break;
        case 2:
            [MBProgressHUD showTipMessageInWindow:self.array[indexPath.row] timer:2];
            break;
        case 3:
            [MBProgressHUD showTipMessageInView:self.array[indexPath.row] timer:2];
            break;
        case 4:
            [MBProgressHUD showActivityMessageInWindow:self.array[indexPath.row]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
            break;
        case 5:
            [MBProgressHUD showActivityMessageInView:self.array[indexPath.row]];
            break;
        case 6:
            [MBProgressHUD showActivityMessageInWindow:self.array[indexPath.row] timer:2];
            break;
        case 7:
            [MBProgressHUD showActivityMessageInView:self.array[indexPath.row] timer:2];
            break;
        case 8:
            [MBProgressHUD showPendulumWithMessage:@"加载中" isWindow:NO];
            break;
        case 9:
            [MBProgressHUD showSuccessMessage:@"操作成功"];
            break;
        case 10:
            [MBProgressHUD showErrorMessage:@"操作失败"];
            break;
        case 11:
            [MBProgressHUD showInfoMessage:@"提示信息"];
            break;
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UIButton *)set_rightButton
{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightButton setImage:[UIImage imageNamed:@"nav_complete"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"nav_complete"] forState:UIControlStateHighlighted];
    return rightButton;
}

- (void)right_button_event:(UIButton *)sender
{
    [MBProgressHUD hideHUD];
}


@end

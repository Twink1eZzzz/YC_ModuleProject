//
//  CustomAlterViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/4.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "CustomAlterViewController.h"
#import "LBXAlertAction.h"
#import "RAlertView.h"
#import "MHActionSheet.h"
#import <STPickerArea.h>
#import <STPickerDate.h>

@interface CustomAlterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

@property (nonatomic,strong) NSArray * itemArray;

@end

@implementation CustomAlterViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"自定义弹窗";
    
    self.itemArray = @[@"宏定义系统提示弹窗",
                       @"系统封装弹窗",
                       @"自定义弹窗-无按钮",
                       @"自定义弹窗-一个按钮",
                       @"自定义弹窗-两个按钮",
                       @"自定义ActionSheet",
                       @"地区选择器",
                       @"时间选择器"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.itemArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self systemAlterType1];
            break;
        case 1:
            [self systemAlterType2];
            break;
        case 2:
            [self customAlterNotButton];
            break;
        case 3:
            [self customAlterOneButton];
            break;
        case 4:
            [self customAlterTwoButton];
            break;
        case 5:
            [self customActionSheet];
            break;
        case 6:
            [self pickerArea];
            break;
        case 7:
            [self pickerTime];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 宏定义系统提示弹窗
- (void)systemAlterType1
{
    showAlert(@"好的");
}

#pragma mark - LBXAlertAction封装系统弹窗
- (void)systemAlterType2
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:@"操作文字" buttonsStatement:@[@"好的",@"取消"] chooseBlock:^(NSInteger buttonIdx) {
        YCLog(@"%ld",buttonIdx);
    }];
    
}

#pragma mark - 自定义弹窗-无按钮
- (void)customAlterNotButton
{
    RAlertView *alert = [[RAlertView alloc] initWithStyle:SimpleAlert width:0.8];
    alert.isClickBackgroundCloseWindow = YES;
    alert.contentTextLabel.text =@"SimpleAlert \nAlertView A pop-up framework, Can be simple and convenient to join your project";
}

#pragma mark - 自定义弹窗-一个按钮
- (void)customAlterOneButton
{
    RAlertView *alert = [[RAlertView alloc] initWithStyle:ConfirmAlert];
    alert.headerTitleLabel.text = @"ConfirmAlert";
    alert.contentTextLabel.attributedText = [TextHelper attributedStringForString:@"AlertView A pop-up framework, Can be simple and convenient to join your project" lineSpacing:5];
    [alert.confirmButton setTitle:@"好的" forState:UIControlStateNormal];
    alert.confirm = ^(){
        NSLog(@"Click on the Ok");
    };
}

#pragma mark - 自定义弹窗-两个按钮
- (void)customAlterTwoButton
{
    RAlertView *alert = [[RAlertView alloc] initWithStyle:CancelAndConfirmAlert];
    alert.headerTitleLabel.text = @"CancelAndConfirmAlert";
    alert.contentTextLabel.attributedText = [TextHelper attributedStringForString:@"AlertView A pop-up framework, Can be simple and convenient to join your project" lineSpacing:5];;
    [alert.confirmButton setTitle:@"好的" forState:UIControlStateNormal];
    [alert.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    alert.theme =[UIColor redColor];
    alert.confirm = ^(){
        NSLog(@"Click on the Ok");
    };
    alert.cancel = ^(){
        NSLog(@"Click on the Cancel");
    };
}

#pragma mark - 自定义Actionsheet
- (void)customActionSheet
{
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleWeiChat itemTitles:@[@"样式一",@"样式二",@"样式三",@"样式四",@"样式五",@"样式六"]];
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        YCLog(@"%@",title);
    }];
}

#pragma mark - 地区选择器 含代理
- (void)pickerArea
{
    STPickerArea *pickerArea = [[STPickerArea alloc]init];
//    [pickerArea setDelegate:self];
    [pickerArea setContentMode:STPickerContentModeBottom];
    [pickerArea show];
}


#pragma mark - 时间选择器 含代理
- (void)pickerTime
{
    STPickerDate *pickerDate = [[STPickerDate alloc]init];
//    [pickerDate setDelegate:self];
    [pickerDate show];
}


@end

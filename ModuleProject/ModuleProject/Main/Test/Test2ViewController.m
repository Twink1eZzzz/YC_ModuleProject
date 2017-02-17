//
//  Test2ViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/5.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "Test2ViewController.h"

#import "SubLBXScanViewController.h"
#import "ScanResultViewController.h"
#import "CustomAlterViewController.h"
#import "MyQRViewController.h"
#import "ConnectionFailureViewController.h"
#import "LoadDatashowInterfaceController.h"
#import "SearchControllerController.h"
#import "YCImagePickerViewController.h"
#import "YCPhotoBrowserViewController.h"
#import "YCLoginViewController.h"
#import "YCCoreDataViewController.h"
#import "MarqueeLabel.h"
#import "YCVectoringInstructionsViewController.h"



#import "LBXScanView.h"
#import <objc/message.h>
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"
#import "YXCustomActionSheet.h"
#import "UINavigationBar+Awesome.h"


@interface Test2ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSArray* arrayItems;

@end

@implementation Test2ViewController

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
    self.navigationItem.title = @"实例演示(Test2ViewController)";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    MarqueeLabel *marqueeView = [[MarqueeLabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 35) duration:15.0 andFadeLength:10.0f];
    marqueeView.text = @"事例演示,有什么好的建议请联系我哟！一起进步！邮箱📮:545002666@qq.com";
    marqueeView.backgroundColor = FlatSandDark;
    marqueeView.textColor = FlatBlue;
    marqueeView.leadingBuffer = 30.0f;
    marqueeView.trailingBuffer = 20.0f;
    marqueeView.animationCurve = UIViewAnimationOptionCurveEaseInOut;
    marqueeView.marqueeType = MLContinuous;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 35)];
    headerView.backgroundColor = FlatSandDark;
    
    [headerView addSubview:marqueeView];
    
    self.tableView.tableHeaderView = headerView;
    
    
    
    self.arrayItems = @[@"二维码扫描",
                        @"第三方分享",
                        @"自定义弹窗",
                        @"网络连接失败页面/无数据界面",
                        @"加载数据是显示占位页面",
                        @"搜索界面",
                        @"图片选择器",
                        @"图片浏览器",
                        @"登录界面",
                        @"Core Data 数据库",
                        @"界面引导指示"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (UIColor *)set_colorBackground
{
    return [UIColor whiteColor];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
     cell.textLabel.text = _arrayItems[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self cameraPemission])
    {
        [self showError:@"没有摄像机权限"];
        return;
    }
    
    switch (indexPath.row) {
        case 0:
            [self ScanQR];
            break;
        case 1:
            [self share];
            break;
        case 2:
            [self CustomAlter];
            break;
        case 3:
            [self NetworkConnectionFailureInterface];
            break;
        case 4:
            [self LoadDatashowInterface];
            break;
        case 5:
            [self searchController];
            break;
        case 6:
            [self ImagePickerController];
            break;
        case 7:
            [self PhotoBrowser];
            break;
        case 8:
            [self LoginView];
            break;
        case 9:
            [self CoreData];
            break;
        case 10:
            [self VectoringInstructions];
            break;
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (BOOL)cameraPemission
{
    
    BOOL isHavePemission = NO;
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                isHavePemission = YES;
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusNotDetermined:
                isHavePemission = YES;
                break;
        }
    }
    
    return isHavePemission;
}

- (void)showError:(NSString*)str
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了",nil];
}

#pragma mark - 二维码扫面 (还有多种样式)
- (void)ScanQR
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 第三方分享
- (void)share
{
    YXCustomActionSheet *cusSheet = [[YXCustomActionSheet alloc] init];
    NSArray *contentArray = @[@{@"name":@"微信",@"icon":@"sns_icon_7"},
                              @{@"name":@"朋友圈",@"icon":@"sns_icon_8"},
                              @{@"name":@"QQ空间",@"icon":@"sns_icon_5"},
                              @{@"name":@"QQ",@"icon":@"sns_icon_4"},
                              @{@"name":@"新浪微博",@"icon":@"sns_icon_3"}];
    
    cusSheet.shareText = @"打开的空间啊";
    cusSheet.shareTitle = @"但是肯定回家啊";
    cusSheet.shareUrl = @"https://www.baidu.com/";
    
    [cusSheet showInView:[UIApplication sharedApplication].keyWindow contentArray:contentArray];
}


#pragma mark - 自定义弹窗
- (void)CustomAlter
{
    CustomAlterViewController *customAlterVC = [[CustomAlterViewController alloc]init];
    [self.navigationController pushViewController:customAlterVC animated:YES];
}

#pragma mark - 网络连接失败界面
- (void)NetworkConnectionFailureInterface
{
    ConnectionFailureViewController *ConnectionFailureVC = [[ConnectionFailureViewController alloc]init];
    [self.navigationController pushViewController:ConnectionFailureVC animated:YES];
    
}

#pragma mark - 加载数据是显示的占位页面
- (void)LoadDatashowInterface
{
    LoadDatashowInterfaceController *LoadDataShowVC = [[LoadDatashowInterfaceController alloc] init];
    [self.navigationController pushViewController:LoadDataShowVC animated:YES];

}

#pragma mark - 搜索界面
- (void)searchController
{
    SearchControllerController *searchVC = [[SearchControllerController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - 图片选择器
- (void)ImagePickerController
{
    YCImagePickerViewController *imagePickerVC = [[YCImagePickerViewController alloc] init];
    [self.navigationController pushViewController:imagePickerVC animated:YES];
}

#pragma mark - 图片浏览器
- (void)PhotoBrowser
{
    YCPhotoBrowserViewController *PhotoBrowserVC = [[YCPhotoBrowserViewController alloc]init];
    [self.navigationController pushViewController:PhotoBrowserVC animated:YES];
}

#pragma mark - 登录界面
- (void)LoginView
{
    YCLoginViewController *LoginVC = [[YCLoginViewController alloc]init];
    [self presentViewController:LoginVC animated:YES completion:nil];
}

#pragma mark - CoreDatas数据库
- (void)CoreData
{
    YCCoreDataViewController *coreDataVC = [[YCCoreDataViewController alloc]init];
    [self.navigationController pushViewController:coreDataVC animated:YES];
}

#pragma mark - 界面引导指示
- (void)VectoringInstructions
{
    YCVectoringInstructionsViewController *VectoringInstructionsVC = [[YCVectoringInstructionsViewController alloc]init];
    [self.navigationController pushViewController:VectoringInstructionsVC animated:YES];
}


@end

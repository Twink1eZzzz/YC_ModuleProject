
//  Created by Twinkle on 15/10/21.
//  Copyright © 2015年 Twinkle. All rights reserved.
//

#import "LBXAlertAction.h"
#import "LBXScanViewController.h"


//继承LBXScanViewController,在界面上绘制想要的按钮，提示ChatTableView语等
@interface SubLBXScanViewController : LBXScanViewController

#pragma mark -模仿qq界面

@property (nonatomic, assign) BOOL isQQSimulator;

/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;

#pragma mark --增加拉近/远视频界面
@property (nonatomic, assign) BOOL isVideoZoom;

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
//底部显示的功能项
@property (nonatomic, strong) UIView *bottomItemsView;
//相册
@property (nonatomic, strong) UIButton *btnPhoto;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;
//我的二维码
@property (nonatomic, strong) UIButton *btnMyQR;


@end

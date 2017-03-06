//
//  YCShareAndLoginViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/3/6.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YCShareAndLoginViewController.h"
// 分享
#import "GSSelectView.h"
#import "GSShareChannelType.h"
#import "GSShareManager.h"
#import "GSShareResultProtocol.h"
#import "GSLoginResultProtocol.h"
#import "GSLoginManager.h"

@interface YCShareAndLoginViewController ()

@end

@implementation YCShareAndLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第三方分享和第三方登录";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 第三方分享
- (IBAction)share:(UIButton *)sender {
    [GSSelectView showShareViewWithChannels:@[
                                              @(GSShareChannelTypeSina),
                                              @(GSShareChannelTypeQQ),
                                              @(GSShareChannelTypeQzone),
                                              @(GSShareChannelTypeWechatSession),
                                              @(GSShareChannelTypeWechatTimeLine)
                                              ] completionBlock:^(BOOL isCancel, GSLogoReourcesType reourcesType) {
                                                  if (isCancel) {
                                                      
                                                  } else {
                                                      id<GSShareProtocol> share = [[GSShareManager share] getShareProtocolWithChannelType:[GSShareManager getShareChannelTypeWithLogoReourcesType:reourcesType]];
                                                      
                                                      // 测试分享纯文本
                                                      //                                                      [share shareSimpleText:@"good day"];
                                                      
                                                      // 分享图片
                                                      //                                                      [share shareSingleImage:[UIImage imageNamed:@"dropdown_loading_01"] title:@"分享图片title" description:@"分享图片description"];
                                                      //分享url
                                                      //                                                      [share shareURL:@"https://github.com/Twink1eZzzz" title:@"分享链接title" description:@"分享链接description" thumbnail:[UIImage imageNamed:@"dropdown_loading_01"]];
                                                      
                                                      
                                                      //分享音频链接
                                                      //                                                      [share shareMusicURL:@"http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT"
                                                      //                                                           musicLowBandURL:nil
                                                      //                                                              musicDataURL:nil
                                                      //                                                       musicLowBandDataURL:nil
                                                      //                                                                     title:@"Wish You Were Here"
                                                      //                                                               description:@"Avril Lavigne"
                                                      //                                                                 thumbnail:[UIImage imageNamed:@"dropdown_loading_01"]];
                                                      
                                                      
                                                      //分享视频链接
                                                      [share shareVideoURL:@"http://www.tudou.com/programs/view/_cVM3aAp270/"
                                                           videoLowBandURL:nil
                                                            videoStreamURL:nil
                                                     videoLowBandStreamURL:nil
                                                                     title:@"腾讯暗黑风动作新游《天刹》国服视频曝光"
                                                               description:@"你觉得正在玩的动作游戏的打击感不够好？战斗不够真实缺乏技巧？PVP索然无味完全是比谁装备好？那么现在有款新游戏或许能满足你的胃口！ 《天刹》是由韩国nse公司开发，腾讯全球代理中国首发的3D锁视角动作游戏，是一款有着暗黑写实风格、东方奇幻题材的游戏，具备打击感十足的动作体验、策略多变的战斗方式，游戏操作不难但有足够的深度，在动作游戏领域首次引入了手动格挡格斗机制，构建快速攻防转换体系。 官方网站：tian.qq.com 官方微博：http://t.qq.com/tiancha001"
                                                                 thumbnail:[UIImage imageNamed:@"dropdown_loading_01"]];
                                                      [share setShareCompletionBlock:^(id<GSShareResultProtocol> result) {
                                                          YCLog(@"%@",[result message]);
                                                          showAlert([result message]);
                                                      }];
                                                  }
                                              }];
    
}
#pragma mark - 微信登录
- (IBAction)wechatLogin:(id)sender {
    
    id<GSLoginProtocol> login = [[GSLoginManager share] getShareProtocolWithChannelType:[GSLoginManager getShareChannelTypeWithLogoReourcesType:GSLogoReourcesTypeWechatSession]];
    
    [login setLoginCompletionBlock:^(id<GSLoginResultProtocol> result) {
        YCLog(@"%@",[result message]);
        showAlert([result message]);
    }];
    
    [login doLogin];
    
}
#pragma mark - qq登录
- (IBAction)qqLogin:(id)sender {
    id<GSLoginProtocol> login = [[GSLoginManager share] getShareProtocolWithChannelType:[GSLoginManager getShareChannelTypeWithLogoReourcesType:GSLogoReourcesTypeQQ]];
    
    [login setLoginCompletionBlock:^(id<GSLoginResultProtocol> result) {
        YCLog(@"%@",[result message]);
        showAlert([result message]);
    }];
    
    [login doLogin];
}
#pragma mark - 新浪登录
- (IBAction)sinaLogin:(id)sender {
    id<GSLoginProtocol> login = [[GSLoginManager share] getShareProtocolWithChannelType:[GSLoginManager getShareChannelTypeWithLogoReourcesType:GSLogoReourcesTypeSina]];
    
    [login setLoginCompletionBlock:^(id<GSLoginResultProtocol> result) {
        YCLog(@"%@",[result message]);
        showAlert([result message]);
    }];
    
    [login doLogin];
    
}

@end

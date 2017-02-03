//
//  HomeViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/5.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "Test3ViewController.h"
#import "UINavigationBar+Awesome.h"
#import "YC_RefreshGifHeader.h"
#import "YC_RefreshGifFooter.h"
#import "YYFPSLabel.h"
#import "YXCustomActionSheet.h"
#import "ThirdMacros.h"

#define NAVBAR_CHANGE_POINT 50

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) SDCycleScrollView *HeaderCycleScrollView;


@end

@implementation HomeViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _HeaderCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Main_Screen_Width, 250) delegate:self placeholderImage:nil];
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 250)];
        [_headerView addSubview:_HeaderCycleScrollView];
        _tableView.tableHeaderView = _headerView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
    // 仿网络请求
    [self NetworkData];
    [self setupRefresh];
    YYFPSLabel *fps = [[YYFPSLabel alloc] initWithFrame:CGRectMake(5, 70, 60, 30)];
    [self.view addSubview:fps];

}

#pragma mark - 设置上拉加加载和下拉刷新
- (void)setupRefresh
{
    self.tableView.mj_header = [YC_RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [YC_RefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });

}

- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self.tableView.mj_footer endRefreshing];
    });

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    YCLog(@"viewWillAppear");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 自己定义要求的颜色即可
    UIColor * color = HEXCOLOR(0xFFD700);

    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        
    }
}

- (void)NetworkData
{
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
            @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
            @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
            @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
            @"http://b260.photo.store.qq.com/psb?/V133mtjf2EM6MS/YxI3ONpgKEx*Ki8l2e3Xd4Ib0EV4RqIhKuP5pvBNWMs!/b/dEI0CJu0UgAA&bo=.wFTAQAAAAABB4g!&rf=viewer_4"
    ];

    // 情景三：图片配文字
    NSArray *titles = @[@"ModuleProject",
            @"感谢您的支持，如果下载的",
            @"如果代码在使用过程中出现问题",
            @"您可以发邮件到545002666@qq.com"
    ];

    _HeaderCycleScrollView.imageURLStringsGroup = imagesURLStrings;
    _HeaderCycleScrollView.titlesGroup = titles;
    _HeaderCycleScrollView.autoScrollTimeInterval = 4.0;
    _HeaderCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [_tableView reloadData];
}


#pragma mark - 重写BaseViewController设置内容
// 设置导航栏背景色
- (UIColor *)set_colorBackground
{
    return [UIColor clearColor];
    // 42 154 250
}

//是否隐藏导航栏底部的黑线 默认也为NO
-(BOOL)hideNavigationBottomLine
{
    return YES;
}

//设置标题
-(NSMutableAttributedString*)setTitle
{
    return [self changeTitle:@"首页"];
}

//设置左边按键
-(UIButton*)set_leftButton
{
    UIButton *left_button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [left_button setImage:[UIImage imageNamed:@"nav_complete"] forState:UIControlStateNormal];
    [left_button setImage:[UIImage imageNamed:@"nav_complete"] forState:UIControlStateHighlighted];
    return left_button;
}

// 点击左边事件
- (void)left_button_event:(UIButton *)sender
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

//点击标题事件，不要可以不重写
-(void)title_click_event:(UIView*)sender
{
    Test3ViewController *test3 = [[Test3ViewController alloc] init];
    [self.navigationController pushViewController:test3 animated:YES];
    [self dismissLoading];
}

#pragma mark 自定义代码
-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle];
    [title addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x333333) range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:CHINESE_SYSTEM(18) range:NSMakeRange(0, title.length)];
    return title;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    YCLog(@"%ld",index);
}


@end

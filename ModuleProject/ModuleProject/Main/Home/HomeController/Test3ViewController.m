//
//  Test3ViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/9.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "Test3ViewController.h"
#import "commodityListModel.h"
#import "FeEqualize.h"
#import "UINavigationBar+Awesome.h"
#import "YC_RefreshGifHeader.h"
#import "YC_RefreshGifFooter.h"

@interface Test3ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * modelArr;

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) FeEqualize *equalizer;

@end

@implementation Test3ViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化设置
    [self initSetting];
    // 网络请求
//    [self NetworkData];
    [self setupRefresh];
}

#pragma mark - 设置上拉加加载和下拉刷新
- (void)setupRefresh
{

    YC_RefreshGifHeader *header = [YC_RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    YC_RefreshGifFooter *footer = [YC_RefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;

    // 隐藏状态
    header.stateLabel.hidden = YES;

    footer.stateLabel.hidden = YES;

    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
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
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY >= 44) {
            [self setNavigationBarTransformProgress:1];

        } else {
            [self setNavigationBarTransformProgress:(offsetY / 44)];

        }
    } else {
        [self setNavigationBarTransformProgress:0];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar lt_setTranslationY:(-44 * progress)];

    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
}

#pragma mark - init
- (void)initSetting {
    self.view.backgroundColor = [UIColor orangeColor];
    self.tableView.backgroundColor = MainColor;
    _equalizer = [[FeEqualize alloc] initWithView:self.view title:@"LOADING"];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.view addSubview:_equalizer];
    [_equalizer showWhileExecutingBlock:^{
        // 网络请求
        [self NetworkData];
    } completion:^{
        [_equalizer dismiss];
    }];

//    [_equalizer show];
}

#pragma mark - NetworkData
- (void)NetworkData
{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"userId"] = @"e549d1e054096f4701540992b516001b";
//    [[NetworkTool sharedNetworkTool] GETMethodWithApi:@"service/play/play/findPlayHomePage" Parameters:params Success:^(id response, NSString *str) {
//        if ([str isEqualToString:@"000000"]) {
//            self.modelArr = [NSArray yy_modelArrayWithClass:[commodityListModel class] json:response[@"data"][@"commodityList"]];
//            [self.tableView reloadData];
//            [_equalizer dismiss];
//        }else {
//            [_equalizer dismiss];
//        }
//        YCLog(@"%@-----%@",response,self.modelArr);
//    } Failure:^(NSError *error) {
//        YCLog(@"%@",error);
//        [_equalizer dismiss];
//    }];
    sleep(3);
}


- (NSMutableAttributedString *)setTitle {
    return [self changeTitle:@"Test3"];
}

- (UIColor *)set_colorBackground {
    return HEXCOLOR(0xFFD700);
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
@end

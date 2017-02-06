//
//  MHActionSheet.h
//  MHActionSheet
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.

#import <UIKit/UIKit.h>


///Block回调
typedef void (^SelectIndexBlock)(NSInteger index, NSString *title);

typedef NS_ENUM(NSUInteger, MHSheetStyle) {
    ///默认样式
    MHSheetStyleDefault = 0,
    ///像微信样式
    MHSheetStyleWeiChat,
    ///TableView样式(无取消按钮)
    MHSheetStyleTable,
};

@protocol MHActionSheetDelegate <NSObject>
///传递index和title,以及sender即MHActionSheet,可用tag等属性区别不同的MHActionSheet
- (void)sheetViewDidSelectIndex:(NSInteger)index
                          title:(NSString *)title
                         sender:(id)sender;

///简单传递出index和title
- (void)sheetViewDidSelectIndex:(NSInteger)index
                          title:(NSString *)title;
@end

@interface MHActionSheet : UIView

///标题颜色,默认是darkGrayColor
@property (strong, nonatomic) UIColor *titleTextColor;
///item字体颜色,默认是blueColor
@property (strong, nonatomic) UIColor *itemTextColor;
///取消字体颜色,默认是blueColor
@property (strong, nonatomic) UIColor *cancleTextColor;
///标题文字字体
@property (strong, nonatomic) UIFont *titleTextFont;
///item文字字体
@property (strong, nonatomic) UIFont *itemTextFont;
///取消文字字体
@property (strong, nonatomic) UIFont *cancleTextFont;
///取消按钮文字设置,默认是"取消"
@property (strong, nonatomic) NSString *cancleTitle;
///是否统一处理取消按钮事件
@property (assign, nonatomic) BOOL isUnifyCancleAction;

///设置代理,则有两个代理方法可供选择
@property (weak, nonatomic) id delegate;

///初始化方法,title不传则不显示,tableView当item显示不完的时候可以滑动,style默认是UIActionSheet样式
- (id)initSheetWithTitle:(NSString *)title
                   style:(MHSheetStyle)style
              itemTitles:(NSArray *)itemTitles;

///回调block中包含选中的index和title---也可实现代理方法获取选中的数据
- (void)didFinishSelectIndex:(SelectIndexBlock)block;

///显示
- (void)show;
@end

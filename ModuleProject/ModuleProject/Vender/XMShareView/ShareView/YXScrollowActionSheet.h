//
//  YXScrollowActionSheet.h
//  YXCustomActionSheet
//
//  Created by Houhua Yan on 16/7/14.
//  Copyright © 2016年 YanHouhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXActionSheetButton.h"

@protocol YXScrollowActionSheetDelegate <NSObject>

@optional

- (void) scrollowActionSheetButtonClick:(YXActionSheetButton *) btn;

@end


@interface YXScrollowActionSheet : UIView

/**展示*/
- (void)showInView:(UIView *)superView contentArray:(NSArray *)contentArray;

@property (nonatomic, weak) id<YXScrollowActionSheetDelegate> delegate;




@end

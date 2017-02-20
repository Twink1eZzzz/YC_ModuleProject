//
//  MHSheetView.m
//  MHActionSheet
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.

#import "MHSheetView.h"
#import "MHSheetCell.h"

#define kWH ([[UIScreen mainScreen] bounds].size.height)
#define kWW ([[UIScreen mainScreen] bounds].size.width)


@interface MHSheetView()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *divLineHeight;

@end

@implementation MHSheetView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _divLineHeight.constant = 0.5;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableView数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHSheetCell *cell= [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHSheetCell class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MHSheetCell class]) owner:self options:nil].lastObject;
        if (_cellTextColor) {
            cell.myLabel.textColor = _cellTextColor;
        }
    }
    cell.myLabel.text = _dataSource[indexPath.row];
    
    cell.myLabel.font = [UIFont systemFontOfSize:18];
    if (kWH == 667) {
        cell.myLabel.font = [UIFont systemFontOfSize:20];
    } else if (kWH > 667) {
        cell.myLabel.font = [UIFont systemFontOfSize:21];
    }
    
    if (_cellTextFont) {
        cell.myLabel.font = _cellTextFont;
    }
    
    if (_cellTextStyle == NSTextStyleLeft) {
        cell.myLabel.textAlignment = NSTextAlignmentLeft;
    } else if (_cellTextStyle == NSTextStyleRight){
        cell.myLabel.textAlignment = NSTextAlignmentRight;
    } else {
        cell.myLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    if (_showTableDivLine) {
        cell.divLine.hidden = YES;
        cell.tableDivLine.hidden = NO;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger index = indexPath.row;
    MHSheetCell *cell = (MHSheetCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *cellTitle = cell.myLabel.text;

    if ([self.delegate respondsToSelector:@selector(sheetViewDidSelectIndex:selectTitle:)]) {
        [self.delegate sheetViewDidSelectIndex:index selectTitle:cellTitle];
    }
}


@end

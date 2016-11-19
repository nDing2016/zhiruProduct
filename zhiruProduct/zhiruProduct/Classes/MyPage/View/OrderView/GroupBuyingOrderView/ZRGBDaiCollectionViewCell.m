//
//  ZRGBDaiCollectionViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGBDaiCollectionViewCell.h"
#import "ZRGBDaiTableViewCell.h"
@implementation ZRGBDaiCollectionViewCell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"gbdaishiyong";
    ZRGBDaiTableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (tableViewCell == nil) {
        tableViewCell = [[ZRGBDaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return tableViewCell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

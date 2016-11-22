//
//  ZRGBYiCollectionViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGBYiCollectionViewCell.h"
#import "ZRGBYiTableViewCell.h"
@interface ZRGBYiCollectionViewCell ()

@end
@implementation ZRGBYiCollectionViewCell



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"gbyishiyong";
    ZRGBYiTableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (tableViewCell == nil) {
        tableViewCell = [[ZRGBYiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

//
//  ZRGBTuiCollectionViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGBTuiCollectionViewCell.h"
#import "ZRGBTuiTableViewCell.h"
@implementation ZRGBTuiCollectionViewCell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"gbtuikuandan";
    ZRGBTuiTableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (tableViewCell == nil) {
        tableViewCell = [[ZRGBTuiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

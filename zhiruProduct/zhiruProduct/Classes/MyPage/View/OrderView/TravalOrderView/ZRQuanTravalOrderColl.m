//
//  ZRQuanTravalOrderColl.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRQuanTravalOrderColl.h"
#import "ZRQuanTravalCell.h"
@implementation ZRQuanTravalOrderColl

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"travalKechuxing";
    ZRQuanTravalCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRQuanTravalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

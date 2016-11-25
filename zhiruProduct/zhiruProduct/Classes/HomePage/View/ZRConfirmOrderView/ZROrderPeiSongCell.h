//
//  ZROrderPeiSongCell.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZROrderPeiSongCell : UITableViewCell
//是否是 我们配送 xx ,最后传
@property (nonatomic , assign) BOOL isXXDistribution;
//是否是 会员
@property (nonatomic , assign) BOOL isVip;
//配送费
@property (nonatomic , assign) float psMoney;

@property (nonatomic , copy) void(^peisongShuomingClick)();
@end

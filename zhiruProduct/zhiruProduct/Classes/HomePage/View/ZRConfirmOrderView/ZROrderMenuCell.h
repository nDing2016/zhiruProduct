//
//  ZROrderMenuCell.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZROrderMenuCell : UITableViewCell

@property (nonatomic , strong) NSArray * menuArr;

@property (nonatomic , copy) void(^upDataCount)();


// NO: 订餐
// YES: 超市
@property (nonatomic, assign)BOOL type;


@end

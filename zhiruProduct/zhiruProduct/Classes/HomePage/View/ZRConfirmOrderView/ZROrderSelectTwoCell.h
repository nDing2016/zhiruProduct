//
//  ZROrderSelectTwoCell.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZROrderSelectTwoCell : UITableViewCell

@property (nonatomic , strong) NSDictionary * titleDict;

@property (nonatomic , assign) BOOL isSpecialWeather;
//重量费
@property (nonatomic , copy)NSString * weightMoney;
//总重量
@property (nonatomic , assign) CGFloat allWeight;
@end

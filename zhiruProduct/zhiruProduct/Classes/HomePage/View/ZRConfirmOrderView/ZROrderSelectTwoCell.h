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
@property (nonatomic , copy)NSString * weight;
@end

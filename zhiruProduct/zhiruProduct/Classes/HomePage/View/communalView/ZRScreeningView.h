//
//  ZRScreeningView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  筛选界面

#import <UIKit/UIKit.h>

@interface ZRScreeningView : UIView

@property (nonatomic , strong) NSMutableArray * rootViewArr; //保存搜索条件根视图
@property (nonatomic , copy) void (^screeningViewClick)(NSString * infoStr);

//对象模型
- (instancetype)initWithFrame:(CGRect)frame andTitleArr :(NSArray *)titleArr;


@end

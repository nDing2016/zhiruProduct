//
//  ZRQueryView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  筛选界面的按钮,视图,通过init方法,传入对应筛选名字创建

#import <UIKit/UIKit.h>

@interface ZRQueryView : UIView

//筛选按钮点击
@property (nonatomic , copy) void(^queryBtnClick)(NSInteger index);
//记录当前选中 按钮
@property (nonatomic , strong) UIButton * selectBtn;
-(instancetype)initWithFrame:(CGRect)frame andTitleArr :(NSArray *)titleArr;


//数据字典
//@property (nonatomic , strong) NSDictionary * searchDict;
@end

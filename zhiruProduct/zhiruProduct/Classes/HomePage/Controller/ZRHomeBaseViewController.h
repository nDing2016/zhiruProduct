//
//  ZRHomeBaseViewController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  首页公用控制器

#import "ZRBaseViewController.h"
#import "ZRTableVIewHeadView.h"
#import "ZRScreeningView.h"
#import "ZRQueryView.h"


@interface ZRHomeBaseViewController : ZRBaseViewController
@property (nonatomic , strong) NSMutableArray * modelArr;
@property (nonatomic , strong) NSArray * titleArr;
@property (nonatomic , strong) NSDictionary * ScreeningDict;
@property (nonatomic , strong) NSArray * queryArr;
@property (nonatomic , strong) NSMutableArray * screeningMarr; //用于保存 筛选条件页
@property (nonatomic , weak) UITableView * myTableView;
@property (nonatomic , strong) ZRQueryView * queryView;
@property (nonatomic , strong) ZRScreeningView * screeningView;
@property (nonatomic , strong) NSArray * titleImgArr;

@property (nonatomic , assign) BOOL isClickNav; //是否 是点击分类.
@property (nonatomic , strong) NSMutableArray * data1;
@property (nonatomic , strong) NSMutableArray * data2;
@property (nonatomic , strong) NSMutableArray * data3;
@property (nonatomic , strong) NSMutableArray * data4;
@property (nonatomic , assign) NSInteger currentData1Index;
@property (nonatomic , assign) NSInteger currentData2Index;
@property (nonatomic , assign) NSInteger currentData3Index;
@property (nonatomic , assign) NSInteger currentData4Index;


//@property (nonatomic , copy) NSString * clickStr;

/**
 *  首页公用类初始化
 *
 *  @param titleArr      顶部按钮视图 按钮标题
 *  @param screeningDict 筛选条件 字典里是集合,每个集合里存放筛选条件
 *  @param queryTitleArr 筛选标题
 *
 *  @return self
 */
- (instancetype)initWithTitleArr :(NSArray *)titleArr andScreeningDict :(NSDictionary *)screeningDict andQueryTitleArr :(NSArray*)queryTitleArr  andTitleImgArr :(NSArray*)titleImgArr;


- (void)screenToolClick;

@end

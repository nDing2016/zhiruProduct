//
//  ZRShoppingCarController.m
//  zhiruProduct
//
//  Created by pj on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShoppingCarController.h"


#import "ZRShoppingCarTuanCell.h"
#import "ZRShoppingCarChaoCell.h"


#import "ZRShoppingCarGroupController.h"
#import "ZRShoppingCarMarketController.h"
#import "ZRMyOrderFooter.h"
#import "ZRFooterDetailView.h"
@interface ZRShoppingCarController ()<buttonDelegate>

//@property (nonatomic, strong)UITableView * tableView;
//@property (nonatomic, strong) NSMutableArray *dataArr;
//@property (nonatomic, assign)BOOL headerState;
//@property (nonatomic, assign)BOOL tuanCellState;
//@property (nonatomic, assign)BOOL chaoCellState;
@property (nonatomic, strong)ZRMyOrderFooter * headerView;
@property (nonatomic, strong)ZRShoppingCarGroupController * groupVC;
@property (nonatomic, strong)ZRShoppingCarMarketController * marketVC;


@end

@implementation ZRShoppingCarController

//- (UITableView *)tableView
//{
//    if (_tableView == nil) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50) style:UITableViewStylePlain];
//        [self.view addSubview:_tableView];
//        [_tableView setBackgroundColor:[UIColor clearColor]];
//        UIView * view = [[UIView alloc] init];
//        _tableView.tableFooterView = view;
//    }
//    return _tableView;
//}

 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的购物车"];
    self.view.backgroundColor =RGBCOLOR (240, 240, 240);
#pragma mark--- 等团购上来了解开注释
//    [self creatHeaderSelectView];
    [self createSubControllers];
    [self createRightNavigationButton];
    
}
- (void)createRightNavigationButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"完成" forState:UIControlStateSelected];
    [button setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
    [button setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateSelected];
    [button addTarget:self action:@selector(actionEditingButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)actionEditingButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
#pragma mark--- 等团购上来了解开注释
//        self.groupVC.state = YES;
        self.marketVC.state = YES;
    } else {
#pragma mark--- 等团购上来了解开注释
//        self.groupVC.state = NO;
        self.marketVC.state = NO;
    }
}
- (void)createSubControllers
{
    self.marketVC = [[ZRShoppingCarMarketController alloc] init];
#pragma mark--- 等团购上来了解开注释, 并替换大小
//    self.marketVC.view.frame = CGRectMake(0, 64 + 50 + 1, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -50);
    self.marketVC.view.frame = CGRectMake(0, 64 + 1, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [self.view addSubview:_marketVC.view];
#pragma mark--- 等团购上来了解开注释
//    self.groupVC = [[ZRShoppingCarGroupController alloc] init];
//    self.groupVC.view.frame = CGRectMake(0, 64 + 50 + 1, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50);
//    [self.view addSubview:_groupVC.view];
}
#pragma mark--- 等团购上来了解开注释
//- (void)creatHeaderSelectView
//{
//    self.headerView = [[ZRMyOrderFooter alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 50)];
//    [self.view addSubview:self.headerView];
//    NSMutableArray * dataArray = [NSMutableArray array];
//    NSArray * imageArray = [self returnImageArray];
//    NSArray * titleArray = [self returnTitleArray];
//    [dataArray addObject:imageArray];
//    [dataArray addObject:titleArray];
//    self.headerView.array = dataArray;
//    self.headerView.delegate = self;
//    
//    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 50, SCREEN_WIDTH, 1)];
//    [lineView setBackgroundColor:RGBCOLOR(187, 187, 187)];
//    [self.view addSubview:lineView];
//}
#pragma mark--- 等团购上来了解开注释
//- (NSArray *)returnImageArray
//{
//    //NSArray * array = [NSArray arrayWithObjects:@"tubiao1",@"tubiao2",@"tubiao3",@"tubiao4", nil];
//    NSArray * array = [NSArray arrayWithObjects:ZRImage(@"dd_tuangou"),ZRImage(@"dd_chaoshi"), nil];
//    return array;
//}
//- (NSArray *)returnTitleArray
//{
//    NSArray * array = [NSArray arrayWithObjects:@"团购",@"超市", nil];
//    return array;
//}
- (void)selectClickButton:(UIButton *)sender
{
    if (sender.tag == 1000) {
        for (ZRFooterDetailView * view in self.headerView.subviews) {
            if (view.tag == 2000) {
                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
                [self.view bringSubviewToFront:self.groupVC.view];
            } else {
                [view.titleLabel setTextColor:[UIColor blackColor]];
            }
        }
    } else if (sender.tag == 1001) {
        
        for (ZRFooterDetailView * view in self.headerView.subviews) {
            if (view.tag == 2001) {
                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
                [self.view bringSubviewToFront:self.marketVC.view];
            } else {
                [view.titleLabel setTextColor:[UIColor blackColor]];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

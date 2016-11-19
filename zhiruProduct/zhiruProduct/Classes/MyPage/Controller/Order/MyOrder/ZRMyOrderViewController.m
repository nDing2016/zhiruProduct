//
//  ZRMyOrderViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMyOrderViewController.h"
#import "ZRGroupBuyingOrderViewController.h"
#import "ZROrderingOrderViewController.h"
#import "ZRTravalOrderViewController.h"
#import "ZRSupermarketOrderViewController.h"
#import "ZRLunchOrderController.h"
@interface ZRMyOrderViewController ()<buttonDelegate>



@property (nonatomic, strong)ZRGroupBuyingOrderViewController * groupBuyingVC;
@property (nonatomic, strong)ZROrderingOrderViewController * orderingVC;
@property (nonatomic, strong)ZRTravalOrderViewController * travalVC;
@property (nonatomic, strong)ZRSupermarketOrderViewController * supermarketVC;
@property (nonatomic, strong)ZRLunchOrderController * lunchVC;

@end

@implementation ZRMyOrderViewController

//- (NSArray *)imageArray
//{
//    if (_imageArray == nil) {
//        _imageArray = [NSArray arrayWithObjects:@"tubiao1",@"tubiao2",@"tubiao3",@"tubiao4", nil];
//    }
//    return _imageArray;
//}
//- (NSArray *)titleArray
//{
//    if (_titleArray == nil) {
//        _titleArray = [NSArray arrayWithObjects:@"团购",@"订餐",@"旅游",@"超市", nil];
//    }
//    return _titleArray;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的订单"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    [self createFooterView];
    
    [self createViewController];
}
- (void)createViewController
{
//    self.orderingVC = [[ZROrderingOrderViewController alloc] init];
//    [self.orderingVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
//    [self.view addSubview:_orderingVC.view];
    
//    self.travalVC = [[ZRTravalOrderViewController alloc] init];
//    [self.travalVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
//    [self.view addSubview:_travalVC.view];
    
    self.supermarketVC = [[ZRSupermarketOrderViewController alloc] init];
    [self.supermarketVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
    [self.view addSubview:_supermarketVC.view];
    
    self.lunchVC = [[ZRLunchOrderController alloc] init];
    [self.lunchVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
    [self.view addSubview:_lunchVC.view];
    
    
    
    

    
//    self.groupBuyingVC = [[ZRGroupBuyingOrderViewController alloc] init];
//    [self.groupBuyingVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
//    [self.view addSubview:_groupBuyingVC.view];
}
- (void)createFooterView
{
    self.foot = [[ZRMyOrderFooter alloc] initWithFrame:CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50)];
    [self.view addSubview:_foot];
    NSMutableArray * dataArray = [NSMutableArray array];
    self.imageArray = [self returnImageArray];
    self.titleArray = [self returnTitleArray];
    [dataArray addObject:self.imageArray];
    [dataArray addObject:self.titleArray];
    self.foot.array = dataArray;
    self.foot.delegate = self;
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _foot.frame.origin.y, self.view.frame.size.width, 1)];
    [lineView setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self.view addSubview:lineView];
}
- (NSArray *)returnImageArray
{
#pragma mark - 暂时不开通团购订餐业务, 等开通之后再解开此注释,并替换下边的数组
//    NSArray * array = [NSArray arrayWithObjects:ZRImage(@"dd_tuangou"),ZRImage(@"dd_dingcan"),ZRImage(@"dd_lvyou"),ZRImage(@"dd_chaoshi"), nil];

    NSArray * array = [NSArray arrayWithObjects:ZRImage(@"wucantubiao"),ZRImage(@"dd_chaoshi"), nil];
    return array;
}
- (NSArray *)returnTitleArray
{
#pragma mark - 暂时不开通团购订餐业务, 等开通之后再解开此注释,并替换下边的数组
//    NSArray * array = [NSArray arrayWithObjects:@"团购",@"订餐",@"午餐",@"超市", nil];
    NSArray * array = [NSArray arrayWithObjects:@"午餐",@"超市", nil];
    return array;
}

- (void)selectClickButton:(UIButton *)sender
{
//    if (sender.tag == 1000) { // 点击团购标签
//        for (ZRFooterDetailView * view in self.foot.subviews) {
//            if (view.tag == 2000) {
//                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
//                [self.view bringSubviewToFront:self.groupBuyingVC.view];
//            } else {
//                [view.titleLabel setTextColor:[UIColor blackColor]];
//            }
//        }
//    } else if (sender.tag == 1001) { // 点击订餐标签
//        for (ZRFooterDetailView * view in self.foot.subviews) {
//            if (view.tag == 2001) {
//                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
//                [self.view bringSubviewToFront:self.orderingVC.view];
//            } else {
//                [view.titleLabel setTextColor:[UIColor blackColor]];
//            }
//        }
//    } else if (sender.tag == 1002) { // 点击午餐标签
//        for (ZRFooterDetailView * view in self.foot.subviews) {
//            if (view.tag == 2002) {
//                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
////                [self.view bringSubviewToFront:self.travalVC.view];
//                [self.view bringSubviewToFront:self.lunchVC.view];
//            } else {
//                [view.titleLabel setTextColor:[UIColor blackColor]];
//            }
//        }
//    
//    } else if (sender.tag == 1003) { // 点击超市标签
//        for (ZRFooterDetailView * view in self.foot.subviews) {
//            if (view.tag == 2003) {
//                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
//                [self.view bringSubviewToFront:self.supermarketVC.view];
//            } else {
//                [view.titleLabel setTextColor:[UIColor blackColor]];
//            }
//        }
//    }
    if (sender.tag == 1000) { // 点击团购标签
        for (ZRFooterDetailView * view in self.foot.subviews) {
            if (view.tag == 2000) {
                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
                [self.view bringSubviewToFront:self.lunchVC.view];
            } else {
                [view.titleLabel setTextColor:RGBCOLOR(85, 85, 85)];
            }
        }
    } else if (sender.tag == 1001) { // 点击订餐标签
        for (ZRFooterDetailView * view in self.foot.subviews) {
            if (view.tag == 2001) {
                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
                [self.view bringSubviewToFront:self.supermarketVC.view];
            } else {
                [view.titleLabel setTextColor:RGBCOLOR(85, 85, 85)];
            }
        }
    }
//    else if (sender.tag == 1002) { // 点击午餐标签
//        for (ZRFooterDetailView * view in self.foot.subviews) {
//            if (view.tag == 2002) {
//                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
//                //                [self.view bringSubviewToFront:self.travalVC.view];
//                [self.view bringSubviewToFront:self.lunchVC.view];
//            } else {
//                [view.titleLabel setTextColor:[UIColor blackColor]];
//            }
//        }
//        
//    } else if (sender.tag == 1003) { // 点击超市标签
//        for (ZRFooterDetailView * view in self.foot.subviews) {
//            if (view.tag == 2003) {
//                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
//                [self.view bringSubviewToFront:self.supermarketVC.view];
//            } else {
//                [view.titleLabel setTextColor:[UIColor blackColor]];
//            }
//        }
//    }

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

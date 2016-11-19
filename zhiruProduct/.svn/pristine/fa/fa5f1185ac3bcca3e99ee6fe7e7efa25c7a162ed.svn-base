//
//  ZRStoreupRootViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRStoreupRootViewController.h"
#import "ZRStoreupShopController.h"
#import "ZRStoreupTravalController.h"
#import "ZRStorupGroupController.h"
#import "ZRStoreupOrderingController.h"
@interface ZRStoreupRootViewController ()

@property (nonatomic, strong)ZRStoreupShopController * shopVC; // 收藏商户
@property (nonatomic, strong)ZRStorupGroupController * groupVC;// 收藏团购
@property (nonatomic, strong)ZRStoreupOrderingController * orderingVC; // 订餐收藏
@property (nonatomic, strong)ZRStoreupTravalController * travalsVC;// 收藏旅游
@end

@implementation ZRStoreupRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的收藏"];
}
- (NSArray *)returnImageArray
{
    NSArray * array = [NSArray arrayWithObjects:ZRImage(@"dd_lvyou"),ZRImage(@"dd_tuangou"),ZRImage(@"dd_dingcan"), nil];
    return array;
}
- (NSArray *)returnTitleArray
{
    NSArray * array = [NSArray arrayWithObjects:@"商户",@"团购",@"订餐", nil];
    return array;
}
- (void)createViewController
{
    
    // 团购
//    self.groupVC = [[ZRStorupGroupController alloc] init];
//    [self.groupVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
//    [self.view addSubview:_groupVC.view];
    
    // 订餐
//    self.orderingVC = [[ZRStoreupOrderingController alloc] init];
//    [self.orderingVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
//    [self.view addSubview:_orderingVC.view];
    
//    // 旅游
//    self.travalsVC = [[ZRStoreupTravalController alloc] init];
//    [self.travalsVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
//    [self.view addSubview:_travalsVC.view];
    
    
    // 商户
    self.shopVC = [[ZRStoreupShopController alloc] init];
    [self.shopVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
    [self.view addSubview:_shopVC.view];
}
- (void)selectClickButton:(UIButton *)sender
{
    if (sender.tag == 1000) { // 点击商户标签
        for (ZRFooterDetailView * view in self.foot.subviews) {
            if (view.tag == 2000) {
                self.shopVC.shopState = YES;
                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
                [self.view bringSubviewToFront:self.shopVC.view];
            } else {
                self.groupVC.groupState = NO;
                [view.titleLabel setTextColor:[UIColor blackColor]];
            }
        }
    } else if (sender.tag == 1001) { // 点击团购标签
        for (ZRFooterDetailView * view in self.foot.subviews) {
            if (view.tag == 2001) {
                self.groupVC.groupState = YES;
                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
                [self.view bringSubviewToFront:self.groupVC.view];
            } else {
                self.shopVC.shopState = NO;
                [view.titleLabel setTextColor:[UIColor blackColor]];
            }
        }
    } else if (sender.tag == 1002) { // 点击订餐标签
        for (ZRFooterDetailView * view in self.foot.subviews) {
            if (view.tag == 2002) {
                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
                [self.view bringSubviewToFront:self.orderingVC.view];
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

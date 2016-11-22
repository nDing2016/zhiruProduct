//
//  ZRGBKeCollectionViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGBKeCollectionViewCell.h"
#import "ZRGBKeTableViewCell.h"
#import "ZRMyWalletViewController.h"
#import "ZRGroupBuyingOrderFormDetailsController.h"
#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "ZRMyOrderViewController.h"


@interface ZRGBKeCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZRGBKeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, frame.size.height) style:UITableViewStylePlain];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [tableView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:tableView];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"gbkeshiyong";
    ZRGBKeTableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (tableViewCell == nil) {
        tableViewCell = [[ZRGBKeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [tableViewCell setBackgroundColor:[UIColor colorWithRed:arc4random()%256 / 255 green:arc4random()%256 / 255 blue:arc4random()%256 / 255 alpha:1.0]];
//    [tableViewCell setBackgroundColor:RGBCOLOR(255, 255, 255)];
    return tableViewCell;
    
}

#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRGroupBuyingOrderFormDetailsController *orderDetailsVC = [[ZRGroupBuyingOrderFormDetailsController alloc] init];
    
    ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZRNavigationController *nav  = tab.childViewControllers[2];
    ZRMyOrderViewController *myOrdreVC = nav.viewControllers[1];
    
    [myOrdreVC.navigationController pushViewController:orderDetailsVC animated:YES];
}


@end

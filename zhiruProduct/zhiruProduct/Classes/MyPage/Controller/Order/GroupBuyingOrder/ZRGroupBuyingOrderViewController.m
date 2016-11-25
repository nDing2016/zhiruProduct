//
//  ZRGroupBuyingOrderViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingOrderViewController.h"
#import "ZRGBKeCollectionViewCell.h"
#import "ZRGBYiCollectionViewCell.h"
#import "ZRGBDaiCollectionViewCell.h"
#import "ZRGBTuiCollectionViewCell.h"
#import "ZRGBQuanCollectionViewCell.h"

#import "ZRGroupBuyingOrderFormDetailsController.h"
#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "ZRMyOrderViewController.h"


@interface ZRGroupBuyingOrderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, senderDelegate, UICollectionViewDelegateFlowLayout>




@end

@implementation ZRGroupBuyingOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    [self createHeaderView];
    [self createContentView];
}
- (void)createHeaderView
{
    self.headerView = [[ZRHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//    self.array = [NSArray arrayWithObjects:@"可使用",@"已使用",@"待付款",@"退款单",@"全部订单", nil];
    self.array = [self setHeaderArray];
    self.headerView.array = self.array;
    [self.headerView setDelegate:self];
    [self.view addSubview:_headerView];
}
- (NSArray *)setHeaderArray
{
    NSArray * array = [NSArray arrayWithObjects:@"可使用",@"已使用",@"待付款",@"退款单",@"全部订单", nil];
    return array;
}
- (void)createContentView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 64 - 40 - 50);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing = -0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight - 64 - 40 - 50) collectionViewLayout:flowLayout];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_collectionView];
    [self.collectionView setBounces:NO];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    
    [self setRegisterClass];
}
- (void)setRegisterClass
{
    [self.collectionView registerClass:[ZRGBKeCollectionViewCell class] forCellWithReuseIdentifier:@"keshiyong"];
    [self.collectionView registerClass:[ZRGBYiCollectionViewCell class] forCellWithReuseIdentifier:@"yishiyong"];
    [self.collectionView registerClass:[ZRGBDaiCollectionViewCell class] forCellWithReuseIdentifier:@"daishiyong"];
    [self.collectionView registerClass:[ZRGBTuiCollectionViewCell class] forCellWithReuseIdentifier:@"tuikuandan"];
    [self.collectionView registerClass:[ZRGBQuanCollectionViewCell class] forCellWithReuseIdentifier:@"quanbu"];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZRGBKeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"keshiyong" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == 1) {
        ZRGBYiCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"yishiyong" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == 2){
        ZRGBDaiCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"daishiyong" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row == 3) {
        ZRGBTuiCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tuikuandan" forIndexPath:indexPath];
        return cell;
    } else {
        ZRGBQuanCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"quanbu" forIndexPath:indexPath];
        return cell;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%f", scrollView.contentOffset.x);
    CGFloat x = scrollView.contentOffset.x / self.array.count;
    [self.headerView.viewLabel setFrame:CGRectMake(x, 36, ScreenWidth * 1.0 / self.array.count, 40)];
    if (scrollView.contentOffset.x == 0) {
        [self forinHeaderView:scrollView.contentOffset.x / ScreenWidth];
    } else if (scrollView.contentOffset.x == ScreenWidth) {
        [self forinHeaderView:scrollView.contentOffset.x / ScreenWidth];
    } else if (scrollView.contentOffset.x == ScreenWidth * 2) {
        [self forinHeaderView:scrollView.contentOffset.x / ScreenWidth];
    } else if (scrollView.contentOffset.x == ScreenWidth * 3) {
        [self forinHeaderView:scrollView.contentOffset.x / ScreenWidth];
    } else if (scrollView.contentOffset.x == ScreenWidth * 4) {
        [self forinHeaderView:scrollView.contentOffset.x / ScreenWidth];
    }
}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    
//}
- (void)forinHeaderView:(NSInteger)temp
{
    for (UIButton * button in self.headerView.backView.subviews) {
        if (button.tag == 1000 + temp) {
            [button setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}
- (void)selectSender:(UIButton *)button
{
    //NSLog(@"%ld", (long)button.tag);
    NSInteger tagX = button.tag - 1000;
    if (button.tag == 1000) {
        [self.collectionView setContentOffset:CGPointMake(ScreenWidth * tagX, 0) animated:YES];
    } else if (button.tag == 1001) {
        [self.collectionView setContentOffset:CGPointMake(ScreenWidth * tagX, 0) animated:YES];
    } else if (button.tag == 1002) {
        [self.collectionView setContentOffset:CGPointMake(ScreenWidth * tagX, 0) animated:YES];
    } else if (button.tag == 1003) {
        [self.collectionView setContentOffset:CGPointMake(ScreenWidth * tagX, 0) animated:YES];
    } else if (button.tag == 1004) {
        [self.collectionView setContentOffset:CGPointMake(ScreenWidth * tagX, 0) animated:YES];
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
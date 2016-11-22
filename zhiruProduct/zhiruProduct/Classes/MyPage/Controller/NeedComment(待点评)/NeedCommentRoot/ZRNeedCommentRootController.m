//
//  ZRNeedCommentRootController.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRNeedCommentRootController.h"
#import "ZRNeedCommentGroupController.h"
#import "ZRNeedCommentOrderingController.h"
@interface ZRNeedCommentRootController ()<buttonDelegate>

@property (nonatomic, strong)ZRNeedCommentGroupController * groupVC;
@property (nonatomic, strong)ZRNeedCommentOrderingController * orderingVC;
@end

@implementation ZRNeedCommentRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"待点评"];
    
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    [self createNoOpenImage];
}
- (void)createNoOpenImage
{
    UIImageView * image = [[UIImageView alloc] init];
    [image setImage:ZRImage(@"qingqidai")];
    [self.view addSubview:image];
    WS(weakSelf);
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(64);
        make.bottom.equalTo(weakSelf.view).with.offset(0);
        make.left.equalTo(weakSelf.view).with.offset(0);
        make.right.equalTo(weakSelf.view).with.offset(0);
    }];
}
- (NSArray *)returnImageArray
{
    NSArray * array = [NSArray arrayWithObjects:ZRImage(@"dd_tuangou"),ZRImage(@"dd_dingcan"), nil];
    return array;
}
- (NSArray *)returnTitleArray
{
    NSArray * array = [NSArray arrayWithObjects:@"团购",@"订餐", nil];
    return array;
}
- (void)createViewController
{
//    self.orderingVC = [[ZRNeedCommentOrderingController alloc] init];
//    [self.orderingVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
//    [self.view addSubview:_orderingVC.view];
//    
//    self.groupVC = [[ZRNeedCommentGroupController alloc] init];
//    [self.groupVC.view setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50)];
//    [self.view addSubview:_groupVC.view];
//    
}
- (void)selectClickButton:(UIButton *)sender
{
    if (sender.tag == 1000) { // 点击团购标签
        for (ZRFooterDetailView * view in self.foot.subviews) {
            if (view.tag == 2000) {
                [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
                [self.view bringSubviewToFront:self.groupVC.view];
            } else {
                [view.titleLabel setTextColor:[UIColor blackColor]];
            }
        }
    } else if (sender.tag == 1001) { // 点击订餐标签
        for (ZRFooterDetailView * view in self.foot.subviews) {
            if (view.tag == 2001) {
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

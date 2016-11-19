//
//  ZRBillViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

// 账单详情
#import "ZRBillViewController.h"
#import "ZRBillView.h"
@interface ZRBillViewController ()

@property (nonatomic, strong)ZRBillView * billView;
@end

@implementation ZRBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"账单详情"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    self.billView = [[ZRBillView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 226)];
    [_billView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_billView];
    
    [self.billView.manner setTitleLabel:@"付款方式" contentLabel:@"Paypal"];
    [self.billView.explain setTitleLabel:@"商品说明" contentLabel:@"XX订单-32109381030128"];
    [self.billView.date setTitleLabel:@"创建说明" contentLabel:@"2016-06-25 18:29"];
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

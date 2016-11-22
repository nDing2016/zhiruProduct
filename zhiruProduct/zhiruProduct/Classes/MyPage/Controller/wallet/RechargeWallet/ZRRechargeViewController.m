//
//  ZRRechargeViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

// 购买充值劵
#import "ZRRechargeViewController.h"
#import "ZRRegisterView.h"
#import "ZRSelectViewController.h"
#import "ZRRechargeOrderController.h"
#import "ZRCustomRechargeBtn.h"
@interface ZRRechargeViewController ()

@property (nonatomic, strong)ZRRegisterView * moneyView;
@property (nonatomic, strong)UIView * lineView1;
@property (nonatomic, strong)UIView * lineView2;
@property (nonatomic, strong)UIButton * button;

@property (nonatomic, strong)NSArray *OriginalPricArr;
@property (nonatomic, strong)NSArray *PresentPrice;

@property (nonatomic, strong)NSMutableArray * btnMarr;

@property (nonatomic, strong)ZRCustomRechargeBtn * customBtn;
@end

@implementation ZRRechargeViewController

-(NSMutableArray *)btnMarr{
    if (_btnMarr == nil) {
        _btnMarr = [NSMutableArray array];
    }
    return _btnMarr;
}

-(NSArray *)OriginalPricArr{
    if (_OriginalPricArr == nil) {
        _OriginalPricArr = @[@"50",@"100",@"200",@"300",@"500",@"1000"];
    }
    return _OriginalPricArr;
}

-(NSArray *)PresentPrice{
    if (_PresentPrice == nil) {
        _PresentPrice = @[@"50",@"100",@"200",@"300",@"500",@"1000"];
    }
    return _PresentPrice;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"购买充值劵"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    [self createView];
    
}

- (void)createView
{
   //创建按钮View 214
    UIView * btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 260)];
    btnView.backgroundColor = [ UIColor whiteColor];
    
    [self.view addSubview:btnView];
    
    CGFloat  btnW = (ScreenWidth - 15 * 4) / 3;
    CGFloat  btnH = 80 ;
    CGFloat  btnY = 15;
    CGFloat  btnX = 0;
    for (int i = 0;  i < 6; i ++) {
        
        if (i == 3) {
            btnY = btnH + 15 + 10;
            btnX = 0;
        }
        
        ZRCustomRechargeBtn * btn = [[ZRCustomRechargeBtn alloc] initWithFrame:CGRectMake( 15+ btnX*(btnW+15), btnY, btnW, btnH) andOriginalPrice:self.OriginalPricArr[i] andPresentPrice:self.PresentPrice[i]];
        
        [btnView addSubview:btn];
    
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = R_G_B_16(0xbbbbbb).CGColor;
        
        [self.btnMarr addObject:btn];
        
        if (i== 0) {
            btn.layer.borderWidth = 2;
            btn.layer.borderColor = R_G_B_16(0xff5252).CGColor;
            btn.selected = YES;
            _customBtn = btn;
        }
        
        btn.tag = i;
        
        [btn addTarget:self action:@selector(btnClick: ) forControlEvents:UIControlEventTouchUpInside];
        
        
        btnX++;
    }
    
    //立即购买
    UIButton * lastBtn = [self.btnMarr lastObject];
    UIButton * buyBtn = [MyControl createButtonWithFrame:CGRectMake(15, CGRectGetMaxY(lastBtn.frame) + 20, ScreenWidth - 30, 40) ImageName:nil Target:self Action:@selector(btnClick:) Title:@"立即购买"];
    
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:R_G_B_16(0xff5252) forState:UIControlStateNormal];
    buyBtn.layer.cornerRadius = 5;
    buyBtn.layer.masksToBounds = YES;
    
    buyBtn.tag = 10;
    
    [btnView addSubview:buyBtn];
    
}

- (void)btnClick :(UIButton *)btn{
      //btn.tag = 10 = 立即购买
    if (btn.tag == 10) {
//        立即购买
        ZRRechargeOrderController * orderVC = [[ZRRechargeOrderController alloc] init];
        orderVC.moneyCount = _customBtn.price;
        orderVC.title = @"确认订单";
        [self.navigationController pushViewController:orderVC animated:YES];
        
        return;
    }
    
    for (UIButton * myBtn in self.btnMarr) {
        myBtn.selected = NO;
        myBtn.layer.borderWidth = 1;
        myBtn.layer.borderColor = R_G_B_16(0xbbbbbb).CGColor;
    }
    
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = R_G_B_16(0xff5252).CGColor;
    btn.selected = YES;
    _customBtn = (ZRCustomRechargeBtn*)btn;
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
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

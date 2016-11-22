//
//  ZRRechargeOrderController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
// //购买余额劵订单详情

#import "ZRRechargeOrderController.h"
#import "ZRUpDataIphoneNumbController.h"

@interface ZRRechargeOrderController ()
@property (nonatomic , strong) UILabel * countLB;
@property (nonatomic , strong) UILabel * xiaojiLB;
@property (nonatomic , assign) CGRect lastViewRect;
@end

@implementation ZRRechargeOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ZRBackgroundColor;
    
    [self setTitle:@"提交订单"];
    
    [self createRechargeOrderInfo];
}



//-(void)setMoneyCount:(NSString *)moneyCount{
//    _moneyCount = moneyCount;
//    
//    
//}

- (void)createRechargeOrderInfo{
    
    CGFloat viewH = 40;
    CGFloat viewW = ScreenWidth;
    CGFloat viewY = 15 + 64;
    
    for (int i = 0; i < 3; i++) {
        
        UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, viewY + viewH * i, viewW, viewH)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: backView];
        
        switch (i) {
            case 0:
            {
                UILabel * titleLB = [UILabel new];
                
                if (self.type == 1) { // 团购
                    titleLB.text = _orderName;
                } else if (self.type == 2) { // 会员卡
                    titleLB.text = _orderName;
                }
//                titleLB.text = [NSString stringWithFormat:@"%@元余额劵",_moneyCount];
                titleLB.font = [UIFont systemFontOfSize:14];
                [backView addSubview:titleLB];
                
                UILabel * moneyLB = [UILabel new];
                moneyLB.text = [NSString stringWithFormat:@"$%@",_moneyCount];
                moneyLB.font = [UIFont systemFontOfSize:14];
                [backView addSubview:moneyLB];
                
                [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(backView.mas_centerY);
                    make.left.equalTo(backView.mas_left).offset(15);
                    
                }];
                
                [moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(backView.mas_centerY);
                    make.right.equalTo(backView.mas_right).offset(-15);
                }];
                
            }
                break;
            case 1:
            {
                UILabel * titleLB = [UILabel new];
                titleLB.text = @"数量:";
                titleLB.font = [UIFont systemFontOfSize:14];
                [backView addSubview:titleLB];
                
                UIView * countView = [self createCountView];
                [backView addSubview:countView];
                
                
                
                
                [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(backView.mas_left).offset(15);
                    make.centerY.equalTo(backView.mas_centerY);
                    
                }];
                
                [countView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(backView.mas_centerY);
                    make.right.equalTo(backView.mas_right).offset(-15);
                    make.width.equalTo(@98);
                    make.height.equalTo(@28);
                }];
            }
                break;
                case 2:
            {
                UILabel * titleLB = [UILabel new];
                titleLB.text = @"小计";
                titleLB.font = [UIFont systemFontOfSize:14];
                
                
                [backView addSubview:titleLB];
                
                UILabel * moneyLB = [UILabel new];
                CGFloat money = [_moneyCount floatValue] * [_countLB.text integerValue];
                
                moneyLB.text = [NSString stringWithFormat:@"$%.2f",money];
                moneyLB.font = [UIFont systemFontOfSize:14];
                moneyLB.textColor = [UIColor redColor];
                _xiaojiLB = moneyLB;
                
                [backView addSubview:moneyLB];
                
                [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(backView.mas_left).offset(15);
                    make.centerY.equalTo(backView.mas_centerY);
                }];
                
                [moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(backView.mas_right).offset(-15);
                    make.centerY.equalTo(backView.mas_centerY);
                }];
                
                _lastViewRect = backView.frame;
            }
                break;
            default:
                break;
        }
        
        if (i == 0) {
            UIView * lineView = [UIView new];
            lineView.backgroundColor = R_G_B_16(0xbbbbbb);
            [backView addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(backView.mas_left);
                make.right.equalTo(backView.mas_right);
                make.top.equalTo(backView.mas_top);
                make.height.equalTo(@1);
            }];
        }
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = R_G_B_16(0xbbbbbb);
        [backView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backView.mas_left);
            make.right.equalTo(backView.mas_right);
            make.bottom.equalTo(backView.mas_bottom);
            make.height.equalTo(@1);
        }];
    }
    
//    //创建下方视图 , 绑定手机号, 提交订单
//    for (int i = 0; i<2; i++) {
//        
//        UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_lastViewRect)+ 20 + i * 40, ScreenWidth, 40)];
//        
//        backView.backgroundColor = [UIColor whiteColor];
//        
//        [self.view addSubview:backView];
//        switch (i) {
//            case 0:
//            {
//                UILabel * titleLB = [UILabel new];
//                
//                titleLB.text = @"您绑定的手机号";
//                titleLB.font = [UIFont  systemFontOfSize:14];
//                
//                [backView addSubview:titleLB];
//                
//                UIView * lineView = [UIView new];
//                lineView.backgroundColor = R_G_B_16(0xbbbbbb);
//                [backView addSubview:lineView];
//                
//                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(backView.mas_left);
//                    make.right.equalTo(backView.mas_right);
//                    make.top.equalTo(backView.mas_top);
//                    make.height.equalTo(@1);
//                }];
//                
//                [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(backView.mas_left).offset(15);
//                    make.centerY.equalTo(backView.mas_centerY);
//                }];
//                
//                
//            }
//                break;
//                case 1:
//            {
//                UILabel * phoneNum = [UILabel new];
//                phoneNum.text = @"177****1846";
//                phoneNum.font = [UIFont systemFontOfSize:14];
//                
//                [backView addSubview:phoneNum];
//                
//                UILabel * newNum = [UILabel new];
//                newNum.text = @"绑定新号码";
//                newNum.font = [UIFont systemFontOfSize:14];
//                newNum.textColor = R_G_B_16(0xbbbbbb);
//                [backView addSubview:newNum];
//                
//                UIImageView * jiantouImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou-you"]];
//                
//                [jiantouImg sizeToFit];
//                
//                [backView addSubview:jiantouImg];
//                
//                //按钮
//                UIButton * clickBtn = [UIButton new];
//                
//                [clickBtn addTarget:self action:@selector(countBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//                clickBtn.tag = 103;
//                
//                [backView addSubview:clickBtn];
//                
//                //约束
//                [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(backView.mas_left).offset(15);
//                    make.centerY.equalTo(backView.mas_centerY);
//                }];
//                
//                [jiantouImg mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.equalTo(backView.mas_right).offset(-15);
//                    make.centerY.equalTo(backView.mas_centerY);
//                }];
//                
//                [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.equalTo(backView.mas_right);
//                    make.left.equalTo(backView.mas_left);
//                    make.right.equalTo(backView.mas_right);
//                    make.bottom.equalTo(backView.mas_bottom);
//                }];
//                
//                [newNum mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.equalTo(backView.mas_centerY);
//                    make.right.equalTo(jiantouImg.mas_left).offset(-15);
//                }];
//                
//                _lastViewRect = backView.frame;
//            }
//                break;
//            default:
//                break;
//        }
//        
//        UIView * lineView = [UIView new];
//        lineView.backgroundColor = R_G_B_16(0xbbbbbb);
//        [backView addSubview:lineView];
//        
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(backView.mas_left);
//            make.right.equalTo(backView.mas_right);
//            make.bottom.equalTo(backView.mas_bottom);
//            make.height.equalTo(@1);
//        }];
//    }
    
    
    //创建 提交按钮

    UIButton * submitBtn = [MyControl createButtonWithFrame:CGRectMake(35, CGRectGetMaxY(_lastViewRect) + 30, ScreenWidth - 70, 40) ImageName:nil Target:self Action:@selector(countBtnClick:) Title:@"提交订单"];
    
    submitBtn.tag = 100;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [submitBtn setBackgroundColor:R_G_B_16(0xff5252) forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    [self.view addSubview:submitBtn];
    
}

- (UIView*)createCountView{
    
    if (self.type == 1) { // 团购
        UIView * countView = [[UIView alloc] init];
        countView.layer.cornerRadius = 5;
        countView.layer.masksToBounds = YES;
        countView.layer.borderWidth = 1;
        countView.layer.borderColor = R_G_B_16(0xbbbbbb).CGColor;
        
        UIButton * reduceBtn = [[UIButton alloc] init];
        [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
        [reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        reduceBtn.tag = 101;
        [reduceBtn addTarget:self action:@selector(countBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [countView addSubview:reduceBtn];
        
        [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(countView.mas_top);
            make.left.equalTo(countView.mas_left);
            make.bottom.equalTo(countView.mas_bottom);
            make.width.equalTo(@30);
        }];
        
        UIButton * addBtn = [[UIButton alloc] init];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        addBtn.tag = 102;
        [addBtn addTarget:self action:@selector(countBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [countView addSubview:addBtn];
        
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(countView.mas_right);
            make.top.equalTo(countView.mas_top);
            make.bottom.equalTo(countView.mas_bottom);
            make.width.equalTo(@30);
        }];
        
        UILabel * countLB = [[UILabel alloc]init];
        countLB.text = @"1";
        countLB.font = [UIFont systemFontOfSize:15];
        countLB.textAlignment = NSTextAlignmentCenter;
        
        countLB.layer.borderWidth = 1;
        countLB.layer.borderColor = R_G_B_16(0xbbbbbb).CGColor;
        
        [countView addSubview:countLB];
        _countLB = countLB;
        
        [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(countView.mas_top);
            make.left.equalTo(reduceBtn.mas_right);
            make.right.equalTo(addBtn.mas_left);
            make.bottom.equalTo(countView.mas_bottom);
        }];
        
        return countView;
    } else if (self.type == 2) { // 购买会员
        
        UIView * countView = [[UIView alloc] init];
        
        UILabel * countLB = [[UILabel alloc]init];
        countLB.text = @"1";
        _countLB = countLB;
        countLB.font = [UIFont systemFontOfSize:15];
        countLB.textAlignment = NSTextAlignmentCenter;
        [countView addSubview:countLB];
        [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(countView.mas_top);
            make.right.equalTo(countView.mas_right);
            make.bottom.equalTo(countView.mas_bottom);
        }];
        return countView;
    }
    return nil;
    
}

- (void)countBtnClick :(UIButton *)btn{
    //tag 100 提交订单   101 -  102+
    switch (btn.tag) {
        case 100:
         //提交订单
            break;
        case 101:
        {
            //减
            if ([_countLB.text isEqualToString:@"1"]) {
                return;
            }
            NSInteger count = [_countLB.text integerValue];
            count -= 1;
            _countLB.text = [NSString stringWithFormat:@"%ld",(long)count];
            
            CGFloat money = [_moneyCount floatValue] * [_countLB.text integerValue];
            _xiaojiLB.text = [NSString stringWithFormat:@"$%.2f",money];
        }
            break;
        case 102:
        {
            //加
            NSInteger count = [_countLB.text integerValue];
            count += 1;
            _countLB.text = [NSString stringWithFormat:@"%ld",(long)count];
            CGFloat money = [_moneyCount floatValue] * [_countLB.text integerValue];
            _xiaojiLB.text = [NSString stringWithFormat:@"$%.2f",money];
        }
            break;
        case 103:
            //修改绑定手机号
        {
            ZRUpDataIphoneNumbController * upDataVC = [[ZRUpDataIphoneNumbController alloc] init];
            [self.navigationController pushViewController:upDataVC animated:YES];
            upDataVC.title = @"更改手机号";
        }
        default:
            break;
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

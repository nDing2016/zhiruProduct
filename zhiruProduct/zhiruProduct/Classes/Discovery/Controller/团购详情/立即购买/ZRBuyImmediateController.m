//
//  ZRBuyImmediateController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/23.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBuyImmediateController.h"
#import "ZRGroupBuyDetailModel.h"
#import "ZRPaymentOrderController.h"

@interface ZRBuyImmediateController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *submmitOrderBtn;

@end

@implementation ZRBuyImmediateController

#pragma mark - 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView addSubview:self.submmitOrderBtn];
        
        
    }
    return _tableView;
}

-(UIButton *)submmitOrderBtn
{
    if (!_submmitOrderBtn) {
        _submmitOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 44*SCREEN_HEIGHT/667*8, SCREEN_WIDTH-60, 40)];
        _submmitOrderBtn.backgroundColor = RGBCOLOR(255, 82, 82);
        _submmitOrderBtn.layer.cornerRadius = 5.0f;
        [_submmitOrderBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submmitOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submmitOrderBtn.titleLabel.font = CustomFont(15);
        _submmitOrderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_submmitOrderBtn addTarget:self action:@selector(submmitOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _submmitOrderBtn;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"提交订单";
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else
        return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.textLabel.text = nil;
    cell.accessoryView = nil;
    cell.detailTextLabel.text = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            cell.textLabel.text = _groupBuyDetailModel.groupName;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, cell.height-10)];
            label.text = [NSString stringWithFormat:@"$%@",_groupBuyDetailModel.nowPrice];
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = RGBCOLOR(85, 85, 85);
            cell.accessoryView = label;
            
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"数量";
            //右侧加号
            UIButton *rightPlusBtn = [MyControl createButtonWithFrame:CGRectMake(SCREEN_WIDTH-15-27*SCREEN_HEIGHT/667, (cell.height-27*SCREEN_HEIGHT/667)/2, 27*SCREEN_HEIGHT/667, 27*SCREEN_HEIGHT/667) ImageName:@"youjia" Target:self Action:@selector(rightPlusBtnClick:) Title:nil];
            [cell.contentView addSubview:rightPlusBtn];
            
            //中间数据
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(rightPlusBtn.frame)-35*SCREEN_WIDTH/375, (cell.height-27*SCREEN_HEIGHT/667)/2, 35*SCREEN_WIDTH/375, 27*SCREEN_HEIGHT/667)];
            label.layer.borderColor = RGBCOLOR(240, 239, 245).CGColor;
            label.layer.borderWidth = 1.0;
            label.text = @"1";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = CustomFont(15);
            label.textColor = RGBCOLOR(85, 85, 85);
            //cell.accessoryView = label;
            [cell.contentView addSubview:label];
            
            //左侧减号
            UIButton *leftMinusBtn = [MyControl createButtonWithFrame:CGRectMake(CGRectGetMinX(label.frame)-27*SCREEN_HEIGHT/667, (cell.height-27*SCREEN_HEIGHT/667)/2, 27*SCREEN_HEIGHT/667, 27*SCREEN_HEIGHT/667) ImageName:@"zuojian-" Target:self Action:@selector(leftMinusBtnClick:) Title:nil];
            [cell.contentView addSubview:leftMinusBtn];
            
            
            
        }else{
            cell.textLabel.text = @"小计";
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, cell.height-10)];
            label.text = [NSString stringWithFormat:@"$%@",_groupBuyDetailModel.nowPrice];
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = RGBCOLOR(255, 82, 82);
            cell.accessoryView = label;
        }
        
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"您绑定的手机号码";
            
        }else{
#warning 绑定手机号码需要从朴健登录信息中获取
            cell.textLabel.text = @"177****1846";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"绑定新号码";
        }
    }
    cell.textLabel.textColor = RGBCOLOR(85, 85, 85);
    cell.textLabel.font = CustomFont(15);
    return cell;
}



#pragma mark - manage memory methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - click methods
/**
 *  提交订单点击事件
 */
- (void)submmitOrderBtnClick:(UIButton *)sender
{
    ZRPaymentOrderController *paymentOrderCtl = [[ZRPaymentOrderController alloc] init];
    [self.navigationController pushViewController:paymentOrderCtl animated:YES];
    //paymentOrderCtl.payPrice =
#warning 佳楠传总价
    paymentOrderCtl.groupBuyDetailModel = _groupBuyDetailModel;
}

/**
 *  右侧数量增加按钮
 */
- (void)rightPlusBtnClick:(UIButton *)sender
{
    
}

/**
 *  左侧数量减少按钮
 */
- (void)leftMinusBtnClick:(UIButton *)sender
{
    
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

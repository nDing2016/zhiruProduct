//
//  ZRGroupBuyingOrderFormDetailsController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingOrderFormDetailsController.h"

@interface ZRGroupBuyingOrderFormDetailsController ()

@end

@implementation ZRGroupBuyingOrderFormDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单详情";
    
    
    NSArray *arr1 = @[@[ZRImage(@"Default"),@"双人烤肉套餐",@"价格",@"$200"],@[ZRImage(@"duihao_big"),@"未消费,随时退,过期退"]];
    NSArray *arr2 = @[@[@"团购券",@"有效期:2016-12-30 23:59"],@[@"9553 5874 8745",@"未使用"]];
    NSArray *arr3 = @[@[@"订单明细"],@[@"订单编号",@"1150926248"],@[@"下单时间",@"2016-04-08 16:36"],@[@"手机号",@"185*****720"],@[@"数量",@"1"],@[@"总价",@"$200"],@[@"支付方式",@"Paypal支付"]];
    NSArray *arr4 = @[@[@"团购详情",@"更多图文详情"],@[@"铁板煎小黄花鱼",@"1份",@"$5"],@[@"江南小炒肉",@"1份",@"$26"],@[@"茴香蚕豆",@"1份",@"$5"],@[@"双味肘花",@"1份",@"$26"],@[@"干锅土豆海带",@"1份",@"$5"],@[@"西湖莼菜",@"1份",@"$26"],@[@"最高价值",@"$250"],@[@"团购价",@"$110"],@[@"赠送积分",@"110分"]];
    
    NSArray *arr5 = @[@[@"购买须知"],@[@"有效期",@"·2016-05-19至2016-07-18",@"除外日期",@"·有效期内周末、法定节假日可用",@"使用时间",@"·团购券使用时间:10:00-22:00",@"预约提醒",@"·无需预约，消费高峰时可能需要等位",@"规则提醒",@"·每张最多使用1张团购券",@"商家服务",@"·提供服务"]];
    
    
    NSArray *dataArr = @[arr1,arr2,arr3,arr4,arr5];
    
    self.orderFormArr = dataArr;
    
    self.sectionNum = 5;
    
    self.orderDetailsType = OrderDetailsGroupBuying;
    
    
//    self.orderStatus = OrderHasFinished;
//    self.orderTime = @"2016-06-27 08:06";
//    self.nameStr = @"大统华超市(North York)";
//    self.productsArr = @[@[@"XXXXXXXXXXXX",@"x1",@"$5"],@[@"XXXXXXXXXXXX",@"x1",@"$5"],@[@"XXXXXXXXXXXX",@"x1",@"$5"]];
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

//
//  ZRPointDetailOneCell.m
//  zhiruProduct
//
//  Created by pj on 16/12/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointDetailOneCell.h"

@interface ZRPointDetailOneCell ()
// 兑换信息
@property (weak, nonatomic) IBOutlet UILabel *orderTitle;
// 第一条线
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView1;
@property (weak, nonatomic) IBOutlet UILabel *orderTitleId;
@property (weak, nonatomic) IBOutlet UILabel *orderId;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView2;
@property (weak, nonatomic) IBOutlet UILabel *orederTitleName;
@property (weak, nonatomic) IBOutlet UILabel *orderName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView3;
@property (weak, nonatomic) IBOutlet UILabel *orderTitleState;
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView4;
@property (weak, nonatomic) IBOutlet UILabel *orderTitleTime;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView5;
@property (weak, nonatomic) IBOutlet UILabel *orderTitlePoint;
@property (weak, nonatomic) IBOutlet UILabel *orderPoint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView6;
@property (weak, nonatomic) IBOutlet UILabel *orderTitleNum;
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@end

@implementation ZRPointDetailOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ZRPointOrderDetailModel *)model
{
    _model = model;
    [self.orderId setText:_model.order_id];
    [self.orderName setText:_model.commodity_name];
    if ([_model.status isEqualToString:@"0"]) {
        [self.orderState setText:@"进行中"];
    } else if ([_model.status isEqualToString:@"1"]) {
        [self.orderState setText:@"已完成"];
    }
    [self.orderTime setText:_model.create_date];
    [self.orderPoint setText:_model.points];
    [self.orderNum setText:_model.num];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ZRPointDetailOneCell.m
//  zhiruProduct
//
//  Created by pj on 16/12/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointDetailOneCell.h"

@implementation ZRPointDetailOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
- (void)createView
{
    self.titlaLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 40)];
    [self.titlaLabel setFont:[UIFont systemFontOfSize:16]];
    [self.titlaLabel setTextColor:RGBCOLOR(85, 85, 85)];
    [self.titlaLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titlaLabel setText:@"兑换信息"];
    [self.contentView addSubview:_titlaLabel];
    
    self.orderId = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _titlaLabel.frame.origin.y + 40, ScreenWidth, 40)];
    [self.orderId.titleLabel setText:@"订单号:"];
    [self.contentView addSubview:_orderId];
    
    self.orderName = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _orderId.frame.origin.y + 40, ScreenWidth, 40)];
    [self.orderName.titleLabel setText:@"商品名称:"];
    [self.contentView addSubview:_orderName];
    
    self.orderState = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _orderName.frame.origin.y + 40, ScreenWidth, 40)];
    [self.orderState.titleLabel setText:@"订单状态:"];
    [self.contentView addSubview:_orderState];
    
    self.orderTime = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _orderState.frame.origin.y + 40, ScreenWidth, 40)];
    [self.orderTime.titleLabel setText:@"兑换时间:"];
    [self.contentView addSubview:_orderTime];
    
    self.orderPoint = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _orderTime.frame.origin.y + 40, ScreenWidth, 40)];
    [self.orderPoint.titleLabel setText:@"兑换积分:"];
    [self.contentView addSubview:_orderPoint];
    
    self.orderNum = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _orderPoint.frame.origin.y + 40, ScreenWidth, 40)];
    [self.orderNum.titleLabel setText:@"兑换数量:"];
    [self.contentView addSubview:_orderNum];
}
- (void)setModel:(ZRPointOrderDetailModel *)model
{
    _model = model;
    [self.orderId.contentLabel setText:_model.order_id];
    [self.orderName.contentLabel setText:_model.commodity_name];
    if ([_model.status isEqualToString:@"0"]) {
        [self.orderState.contentLabel setText:@"进行中"];
    } else if ([_model.status isEqualToString:@"1"]) {
        [self.orderState.contentLabel setText:@"已完成"];
    }
    [self.orderTime.contentLabel setText:_model.create_date];
    [self.orderPoint.contentLabel setText:_model.points];
    [self.orderNum.contentLabel setText:_model.num];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

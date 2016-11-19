//
//  ZRLunchFourCell.m
//  zhiruProduct
//
//  Created by pj on 16/10/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLunchFourCell.h"
@implementation ZRLunchFourCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView setBackgroundColor:RGBCOLOR(240, 240, 240)];
    }
    return self;
}
- (void)createView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 320)];
    [self.backView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_backView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 40)];
    [self.titleLabel setText:@"订单详情"];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.backView addSubview:_titleLabel];
    [self.titleLabel setTextColor:RGBCOLOR(85, 85, 85)];
    
    self.orderNumber = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 40)];
    [self.orderNumber.titleLabel setText:@"订单号:"];
    [self.backView addSubview:_orderNumber];
    
    
    self.name = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _orderNumber.frame.origin.y + _orderNumber.frame.size.height, ScreenWidth, 40)];
    [self.name.titleLabel setText:@"联系人:"];
    [self.backView addSubview:_name];
    
    self.phone = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _name.frame.origin.y + _name.frame.size.height, ScreenWidth, 40)];
    [self.phone.titleLabel setText:@"联系电话:"];
    [self.backView addSubview:_phone];
    
    self.address = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _phone.frame.origin.y + _phone.frame.size.height, ScreenWidth, 40)];
    [self.address.titleLabel setText:@"取餐地址:"];
    [self.backView addSubview:_address];
    
    self.pay = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _address.frame.origin.y + _address.frame.size.height, ScreenWidth, 40)];
    [self.pay.titleLabel setText:@"支付方式:"];
    [self.backView addSubview:_pay];
    
    self.timer1 = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _pay.frame.origin.y + _pay.frame.size.height, ScreenWidth, 40)];
    [self.timer1.titleLabel setText:@"下单时间:"];
    [self.backView addSubview:_timer1];
    
    self.timer2 = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _timer1.frame.origin.y + _timer1.frame.size.height, ScreenWidth, 40)];
    [self.timer2.titleLabel setText:@"取餐时间:"];
    [self.backView addSubview:_timer2];
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

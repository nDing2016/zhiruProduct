//
//  ZRPointDetailTwoCell.m
//  zhiruProduct
//
//  Created by pj on 16/12/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointDetailTwoCell.h"

@implementation ZRPointDetailTwoCell
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
    [self.titlaLabel setText:@"联系人信息"];
    [self.contentView addSubview:_titlaLabel];
    
    
    self.orderName = [[ZRPointView alloc] initWithFrame:CGRectMake(0, _titlaLabel.frame.origin.y + 40, ScreenWidth, 40)];
    [self.orderName.titleLabel setText:@"联系人名称:"];
    [self.contentView addSubview:_orderName];
    
    self.orderPhone = [[ZRPointView alloc] initWithFrame:CGRectMake(0, _orderName.frame.origin.y + 40, ScreenWidth, 40)];
    [self.orderPhone.titleLabel setText:@"联系人电话:"];
    [self.contentView addSubview:_orderPhone];

    self.orderAddress = [[ZRLunchView alloc] initWithFrame:CGRectMake(0, _orderPhone.frame.origin.y + 40, ScreenWidth, 40)];
    [self.orderAddress.titleLabel setText:@"送货地址:"];
    [self.contentView addSubview:_orderAddress];
}
- (void)setModel:(ZRPointOrderDetailModel *)model
{
    _model = model;
    [self.orderName.contentLabel setText:_model.receipt_name];
    [self.orderPhone.contentLabel setText:_model.receipt_phone];
    [self.orderAddress.contentLabel setText:_model.receipt_address];
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

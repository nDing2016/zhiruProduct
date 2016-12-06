//
//  ZRPointDetailThreeCell.m
//  zhiruProduct
//
//  Created by pj on 16/12/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointDetailThreeCell.h"

@implementation ZRPointDetailThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.orderTitle = [[UILabel alloc] init];
    [self.orderTitle setTextColor:RGBCOLOR(85, 85, 85)];
    [self.orderTitle setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_orderTitle];
    [self.orderTitle setText:@"订单备注"];
    
    self.lineView1 = [[UIView alloc] init];
    [self.lineView1 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.contentView addSubview:_lineView1];
    
    self.orderRemark = [[UILabel alloc] init];
    [self.orderRemark setNumberOfLines:0];
    [self.orderRemark setTextColor:RGBCOLOR(85, 85, 85)];
    [self.orderRemark setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_orderRemark];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.orderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.top.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(@40);
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.right.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(@1);
        make.top.equalTo(weakSelf.orderTitle.mas_bottom).with.offset(0);
    }];
    [self.orderRemark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.top.equalTo(weakSelf.lineView1.mas_bottom).with.offset(10);
        make.right.equalTo(weakSelf.contentView).with.offset(-15);
        make.bottom.equalTo(weakSelf.contentView).with.offset(-10);
    }];
}
- (void)setModel:(ZRPointOrderDetailModel *)model
{
    _model = model;
    if (_model.remarks.length == 0) {
        [self.orderRemark setText:@"暂无"];
    } else {
        [self.orderRemark setText:_model.remarks];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

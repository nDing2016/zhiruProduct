//
//  ZRPointDetailTwoCell.m
//  zhiruProduct
//
//  Created by pj on 16/12/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointDetailTwoCell.h"

@interface ZRPointDetailTwoCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView1;
@property (weak, nonatomic) IBOutlet UILabel *orderTitleName;
@property (weak, nonatomic) IBOutlet UILabel *orderName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView2;
@property (weak, nonatomic) IBOutlet UILabel *orderTitlePhone;
@property (weak, nonatomic) IBOutlet UILabel *orderPhone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView3;
@property (weak, nonatomic) IBOutlet UILabel *orderTitleAddress;
@property (weak, nonatomic) IBOutlet UILabel *orderAddress;

@end

@implementation ZRPointDetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ZRPointOrderDetailModel *)model
{
    _model = model;
    [self.orderName setText:_model.receipt_name];
    [self.orderPhone setText:_model.receipt_phone];
    [self.orderAddress setText:_model.receipt_address];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ZRSelectTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSelectTableViewCell.h"

@implementation ZRSelectTableViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.payImage = [[UIImageView alloc] init];
    [self addSubview:_payImage];
    [self.payImage setImage:[UIImage imageNamed:@"chaos"]];
    
    self.payLabel = [[UILabel alloc] init];
    [self addSubview:_payLabel];
//    [self.payLabel setBackgroundColor:[UIColor yellowColor]];
    [self.payLabel setFont:[UIFont systemFontOfSize:16]];
    [self.payLabel setTextAlignment:NSTextAlignmentLeft];
    [self.payLabel setText:@"Paypal"];
    
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_selectButton];
    [self.selectButton setImage:[UIImage imageNamed:@"jiantoushang"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"jiantouxia"] forState:UIControlStateSelected];
    
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.payImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.mas_equalTo(weakSelf);
    }];
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.payImage.mas_right).with.offset(15);
        make.centerY.mas_equalTo(weakSelf);
    }];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.mas_equalTo(weakSelf);
    }];
}
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end

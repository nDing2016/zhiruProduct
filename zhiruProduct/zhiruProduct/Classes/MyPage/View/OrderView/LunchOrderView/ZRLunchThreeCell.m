//
//  ZRLunchThreeCell.m
//  zhiruProduct
//
//  Created by pj on 16/10/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLunchThreeCell.h"

@implementation ZRLunchThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        [self setViewMasonary];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView setBackgroundColor:RGBCOLOR(240, 240, 240)];
    }
    return self;
}
- (void)createView
{
    self.backView = [[UIView alloc] init];
    [self.backView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_backView];
    
    self.title = [[UILabel alloc] init];
    [self.title setText:@"取餐信息"];
    [self.title setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_title];
//    [self.title setBackgroundColor:[UIColor yellowColor]];
    [self.title setTextColor:RGBCOLOR(85, 85, 85)];
    
    self.lineView1 = [[UIView alloc] init];
    [self.lineView1 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.backView addSubview:_lineView1];
    
    self.nameLabel = [[UILabel alloc] init];
//    [self.nameLabel setText:@"负责人名称: ××"];
    [self.nameLabel setFont:[UIFont systemFontOfSize:15]];
    [self.backView addSubview:_nameLabel];
    [self.nameLabel setTextColor:RGBCOLOR(85, 85, 85)];
    
    self.lineView2 = [[UIView alloc] init];
    [self.lineView2 setBackgroundColor:RGBCOLOR(240, 239, 245)];
    [self.backView addSubview:_lineView2];
    
    self.phoneLabel = [[UILabel alloc] init];
//    [self.phoneLabel setText:@"联系方式: 0000000000"];
    [self.phoneLabel setFont:[UIFont systemFontOfSize:15]];
    [self.backView addSubview:_phoneLabel];
    [self.phoneLabel setTextColor:RGBCOLOR(85, 85, 85)];

}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.right.equalTo(weakSelf.contentView).with.offset(0);
        make.bottom.equalTo(weakSelf.contentView).with.offset(-15);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView).with.offset(15);
        make.top.equalTo(weakSelf.backView).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.title.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.lineView1.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.lineView2.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@40);
    }];
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

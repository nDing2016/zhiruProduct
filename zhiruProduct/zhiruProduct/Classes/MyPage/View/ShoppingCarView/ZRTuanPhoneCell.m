//
//  ZRTuanPhoneCell.m
//  zhiruProduct
//
//  Created by pj on 16/9/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRTuanPhoneCell.h"

@implementation ZRTuanPhoneCell

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
    self.lineView1 = [[UIView alloc] init];
    [self.lineView1 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView1];
    
    self.headerLabel = [[UILabel alloc] init];
    [self.headerLabel setText:@"您绑定的手机号码"];
    [self.headerLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_headerLabel];
    
    self.lineView2 = [[UIView alloc] init];
    [self.lineView2 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView2];
    
    self.phoneLabel = [[UILabel alloc] init];
    [self.phoneLabel setText:@"177****0912"];
    [self.phoneLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_phoneLabel];
    
    self.imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    [self.imgView setImage:[UIImage imageNamed:@"jiantou-you2"]];
    
    self.footerLabel = [[UILabel alloc] init];
    [self.footerLabel setText:@"绑定新号码"];
    [self.footerLabel setFont:[UIFont systemFontOfSize:16]];
    [self addSubview:_footerLabel];
    
    self.lineView3 = [[UIView alloc] init];
    [self.lineView3 setBackgroundColor:RGBCOLOR(187, 187, 187)];
    [self addSubview:_lineView3];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.height.mas_equalTo(@1);
    }];

    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.lineView1.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.headerLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.lineView2.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(weakSelf.phoneLabel);
    }];
    
    [self.footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.imgView.mas_left).with.offset(-10);
        make.top.equalTo(weakSelf.lineView2.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@39);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf.phoneLabel.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
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

//
//  ZRRefundCell.m
//  zhiruProduct
//
//  Created by pj on 16/9/21.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRRefundCell.h"

@implementation ZRRefundCell

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
    self.headerLine = [[UIView alloc] initWithFrame:CGRectMake(24, 0, 2, 10)];
    [self.headerLine setBackgroundColor:RGBCOLOR(156, 156, 156)];
    [self addSubview:_headerLine];
    
    self.roundView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    self.roundView.layer.cornerRadius = 10;
    [self.roundView setBackgroundColor:RGBCOLOR(156, 156, 156)];
    [self addSubview:_roundView];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(24, 30, 2, 80)];
    [self.lineView setBackgroundColor:RGBCOLOR(156, 156, 156)];
    [self addSubview:_lineView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.titleLabel setText:@"退款流程"];
    [self addSubview:_titleLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel setText:@"您的退款申请以受理"];
    [self.contentLabel setNumberOfLines:0];
    [self.contentLabel setTextColor:RGBCOLOR(16, 16, 16)];
    [self.contentLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_contentLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.timeLabel setTextColor:RGBCOLOR(255, 82, 82)];
    [self.timeLabel setText:@"2016-01-11 15:47"];
    [self.timeLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_timeLabel];
    
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.roundView.mas_right).with.offset(15);
        make.top.equalTo(weakSelf.roundView);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(weakSelf.titleLabel);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(5);
        make.right.equalTo(weakSelf).with.offset(-15);
    }];
    
}
- (void)setState1:(BOOL)state1
{
    _state1 = state1;
    if (_state1 == YES) {
        [self.headerLine setHidden:YES];
    }
}
- (void)setState2:(BOOL)state2
{
    _state2 = state2;
    if (_state2 == YES) {
        [self.lineView setHidden:YES];
    }
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

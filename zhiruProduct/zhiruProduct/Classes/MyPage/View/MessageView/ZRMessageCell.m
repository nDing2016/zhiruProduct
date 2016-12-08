//
//  ZRMessageCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMessageCell.h"

@implementation ZRMessageCell

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
    self.titleImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_titleImage];
    [self.titleImage setImage:[UIImage imageNamed:@"xiaoxixiangqing"]];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [self.titleLabel setText:@"TEST1"];
    
    self.dateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_dateLabel];
    [self.dateLabel setFont:[UIFont systemFontOfSize:15]];
//    [self.dateLabel setText:@"6月11日"];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_contentLabel];
    [self.contentLabel setNumberOfLines:0];
    [self.contentLabel setFont:[UIFont systemFontOfSize:13]];
    [self.contentLabel setTextColor:RGBCOLOR(136, 136, 136)];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf.contentView).with.offset(10);
//        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleImage.mas_top).with.offset(2);
        make.left.equalTo(weakSelf.titleImage.mas_right).with.offset(10);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.titleLabel.mas_bottom);
        make.right.equalTo(weakSelf).with.offset(-15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel);
        make.top.equalTo(weakSelf.dateLabel.mas_bottom).with.offset(8);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.bottom.equalTo(weakSelf.contentView).with.offset(-8);
    }];
    
}
- (void)setModel:(ZRMessageModel *)model
{
    _model = model;
    [self.titleLabel setText:_model.title];
    [self.contentLabel setText:_model.content];
    [self.dateLabel setText:_model.create_time];
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

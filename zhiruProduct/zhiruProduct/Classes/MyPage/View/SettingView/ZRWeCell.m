//
//  ZRWeCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRWeCell.h"

@implementation ZRWeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.titleLabel setTextColor:RGBCOLOR(85, 85, 85)];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
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

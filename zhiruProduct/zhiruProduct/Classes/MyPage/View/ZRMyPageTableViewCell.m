//
//  ZRMyPageTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMyPageTableViewCell.h"

@implementation ZRMyPageTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createContentView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createContentView
{
    self.identificationImage = [[UIImageView alloc] init];
    self.identificationLabel = [[UILabel alloc] init];
    
    [self addSubview:self.identificationImage];
    [self addSubview:self.identificationLabel];
    //[self.identificationImage setImage:[UIImage imageNamed:@"youhui"]];
    [self.identificationLabel setFont:[UIFont systemFontOfSize:14]];
    [self.identificationLabel setTextColor:R_G_B_16(0x555555)];
   
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.identificationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.mas_equalTo(weakSelf);
//        make.size.mas_equalTo(CGSizeMake(30.0 / 667.0 * ScreenHeight, 30.0 / 667.0 * ScreenHeight));
    }];
    
    
    [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.identificationImage.mas_right).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-0);
//        make.width.mas_equalTo(@100);
    }];
    //    [self.identificationLabel setBackgroundColor:[UIColor yellowColor]];
    
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

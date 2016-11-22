//
//  ZRUserContentTableViewCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUserContentTableViewCell.h"

@implementation ZRUserContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createContentView];
    }
    return self;
}
- (void)createContentView
{
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setTextColor:RGBCOLOR(85, 85, 85)];
    [self addSubview:_titleLabel];
    
    WS(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-0);
        make.width.mas_equalTo(@100);
    }];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
//    [self.titleLabel setBackgroundColor:[UIColor blackColor]];
    
    
    self.rightImage = [[UIImageView alloc] init];
    [self addSubview:_rightImage];
    
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(7.0, 15.0));
    }];
//    [self.rightImage setBackgroundColor:[UIColor blackColor]];
    [self.rightImage setImage:[UIImage imageNamed:@"jiantou-you"]];
    
    
    
    self.contentLabel = [[UILabel alloc] init];
    [self addSubview:_contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.rightImage.mas_left).with.offset(-2);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-0);
        make.width.mas_equalTo(@125);
        
    }];
    [self.contentLabel setTextAlignment:NSTextAlignmentRight];
    [self.contentLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self.contentLabel setTextColor:RGBCOLOR(30, 174, 227)];
//    [self.contentLabel setBackgroundColor:[UIColor yellowColor]];
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

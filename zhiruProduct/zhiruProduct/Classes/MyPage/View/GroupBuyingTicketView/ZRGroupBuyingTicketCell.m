//
//  ZRGroupBuyingTicketCell.m
//  zhiruProduct
//
//  Created by pj on 16/8/10.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingTicketCell.h"

@implementation ZRGroupBuyingTicketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createView];
        [self setViewMasonary];
        
    }
    return self;
}
- (void)createView
{
    self.backImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_backImage];
    [self.backImage setImage:[UIImage imageNamed:@"tuangouquanditu"]];
    
    self.groupImage = [[UIImageView alloc] init];
    [self.backImage addSubview:_groupImage];
    [self.groupImage setImage:[UIImage imageNamed:@"hanbao"]];
    
    self.titleLabels = [[UILabel alloc] init];
    [self.backImage addSubview:_titleLabels];
    [self.titleLabels setFont:[UIFont systemFontOfSize:15]];
    
    self.dateLabel = [[UILabel alloc] init];
    [self.backImage addSubview:_dateLabel];
    [self.dateLabel setFont:[UIFont systemFontOfSize:14]];
    [self.dateLabel setTextColor:RGBCOLOR(156, 156, 156)];
    
    self.ticketLabel = [[UILabel alloc] init];
    [self.backImage addSubview:_ticketLabel];
    [self.ticketLabel setFont:[UIFont systemFontOfSize:15]];
    
    [self.titleLabels setText:@"双人烤肉套餐"];
    [self.ticketLabel setText:@"团购码: 2341 2376 9821"];
    [self.dateLabel setText:@"有效期至2016/07/02"];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.top.equalTo(weakSelf).with.offset(15);
//        make.centerY.equalTo(weakSelf);
    }];
    
    [self.groupImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backImage).with.offset(15);
        make.centerY.equalTo(weakSelf.backImage);
        make.size.mas_equalTo(CGSizeMake(100, 80));
    }];
    
    [self.titleLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.groupImage.mas_right).with.offset(20);
        make.top.equalTo(weakSelf.groupImage.mas_top).with.offset(3);
        make.right.equalTo(weakSelf.backImage).with.offset(-15);
    }];
    
    [self.ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabels);
        make.bottom.equalTo(weakSelf.groupImage.mas_bottom).with.offset(-3);
        make.right.equalTo(weakSelf.backImage).with.offset(-15);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabels);
//        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(2);
//        make.bottom.equalTo(weakSelf.ticketLabel.mas_top).with.offset(-2);
        make.right.equalTo(weakSelf.backImage).with.offset(-15);
        make.centerY.equalTo(weakSelf.backImage);
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

//
//  ZRSettingMessageCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSettingMessageCell.h"

@implementation ZRSettingMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        [self setViewMasonary];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)createView
{
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    
    
    self.switchControl = [[UISwitch alloc] init];
    [self.contentView addSubview:_switchControl];
//    self.switchControl.onTintColor = RGBCOLOR(255, 82, 82);
    [self.switchControl addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.switchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(weakSelf);
    }];
}
- (void)switchChange:(UISwitch *)sender
{
    [self.delegate setSwitch:sender];
//    if (sender.isOn == YES) {
//        NSLog(@"1");
//    } else {
//        NSLog(@"2");
//    }
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

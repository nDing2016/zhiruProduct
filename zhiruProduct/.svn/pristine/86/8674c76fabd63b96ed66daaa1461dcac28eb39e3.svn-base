//
//  ZRBecomeVipCell.m
//  zhiruProduct
//
//  Created by pj on 16/9/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBecomeVipCell.h"

@implementation ZRBecomeVipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self createView];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.imgView = [[UIImageView alloc] init];
//    [self.imgView setBackgroundColor:[UIColor yellowColor]];
    [self.contentView addSubview:_imgView];
    [self.imgView setImage:[UIImage imageNamed:@"vip-92"]];
//    self.imgView.layer.masksToBounds = YES;
//    self.imgView.layer.cornerRadius = 10;
//
//    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.selectButton setImage:ZRImage(@"DUIHAOHUI") forState:UIControlStateNormal];
//    [self.selectButton setImage:ZRImage(@"DUIHAO") forState:UIControlStateSelected];
//    [self.contentView addSubview:_selectButton];

}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(25);
        make.right.equalTo(weakSelf).with.offset(-25);
        make.top.equalTo(weakSelf).with.offset(15);
        make.bottom.equalTo(weakSelf).with.offset(-15);
    }];
//    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.imgView.mas_left).with.offset(10);
//        make.bottom.equalTo(weakSelf.imgView.mas_bottom).with.offset(-10);
//    }];
}
//- (void)setState:(NSString *)state
//{
//    _state = state;
//    if ([_state isEqualToString:@"1"]) {
//        self.selectButton.selected = YES;
//    } else if ([_state isEqualToString:@"0"]) {
//        self.selectButton.selected = NO;
//    }
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ZRShoppingCarTuanCell.m
//  zhiruProduct
//
//  Created by pj on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShoppingCarTuanCell.h"

@implementation ZRShoppingCarTuanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//        [self.contentView setBackgroundColor:RGBCOLOR(249, 249, 249)];
        [self createView];
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_selectButton];
    [self.selectButton setImage:[UIImage imageNamed:@"daixuan"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateSelected];
    [self.selectButton addTarget:self action:@selector(actionSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleImage = [[UIImageView alloc] init];
//    [self.titleImage setImage:[UIImage imageNamed:@"hanbao"]];
    [self addSubview:_titleImage];
    
    
    self.backView2 = [[UIView alloc] init];
    [self.backView2 setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_backView2];
    self.backView2.hidden = YES;
    
    self.subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.subtractButton setTitle:@"－" forState:UIControlStateNormal];
    [self.subtractButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.subtractButton addTarget:self action:@selector(actionSubtractButton) forControlEvents:UIControlEventTouchUpInside];
    [self.backView2 addSubview:_subtractButton];
    
    self.numberLabel = [[UILabel alloc] init];
    [self.numberLabel setText:@"3"];
    [self.numberLabel setFont:[UIFont systemFontOfSize:16]];
    [self.numberLabel setTextAlignment:NSTextAlignmentCenter];
    [self.backView2 addSubview:_numberLabel];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton setTitle:@"＋" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(actionAddButton) forControlEvents:UIControlEventTouchUpInside];
    [self.backView2 addSubview:_addButton];
    
    
    self.backView1 = [[UIView alloc] init];
    [self.backView1 setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_backView1];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.backView1 addSubview:_titleLabel];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    
    self.moneyLabel = [[UILabel alloc] init];
    [self.backView1 addSubview:_moneyLabel];
    [self.moneyLabel setFont:[UIFont systemFontOfSize:15]];
    [self.moneyLabel setTextColor:RGBCOLOR(255, 82, 82)];
    
    self.partLabel = [[UILabel alloc] init];
    [self.backView1 addSubview:_partLabel];
    [self.partLabel setFont:[UIFont systemFontOfSize:15]];
    
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.selectButton.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(100, 80));
    }];
    
    
    [self.backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleImage.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.titleImage.mas_top);
        make.bottom.equalTo(weakSelf.titleImage.mas_bottom);
        make.right.equalTo(weakSelf).with.offset(-15);
    }];
    [self.subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView2);
        make.centerY.equalTo(weakSelf.backView2);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.backView2);
        make.centerY.equalTo(weakSelf.backView2);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.subtractButton.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.addButton.mas_left).with.offset(-5);
        make.centerY.equalTo(weakSelf.backView2);
    }];
    
    
    
    [self.backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleImage.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.titleImage.mas_top);
        make.bottom.equalTo(weakSelf.titleImage.mas_bottom);
        make.right.equalTo(weakSelf).with.offset(-15);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView1);
        make.top.equalTo(weakSelf.backView1);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel);
        make.bottom.equalTo(weakSelf.backView1);
    }];
    [self.partLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.backView1);
        make.bottom.equalTo(weakSelf.backView1);
    }];
}
- (void)actionSelectButton:(UIButton *)sender
{
    [self.delegate selectButtonClick:sender andSection:self.section andRow:self.row];
}
- (void)actionSubtractButton
{
    [self.delegate deleteGroupNumSection:self.section andRow:self.row];
}
- (void)actionAddButton
{
    [self.delegate addGroupNumSection:self.section andRow:self.row];
}
- (void)setModel:(ZRShoppingCarDetailModel *)model
{
    _model = model;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:model.groupImg] placeholderImage:ZRPlaceholderImage];
    [self.titleLabel setText:model.groupName];
    [self.moneyLabel setText:[NSString stringWithFormat:@"$%@", model.nowPrice]];
    [self.partLabel setText:[NSString stringWithFormat:@"×%@", model.num]];
    
    self.backView1.hidden = _model.edtitngState;
    self.backView2.hidden = !_model.edtitngState;
    self.selectButton.selected = _model.state;
    
    
    [self.numberLabel setText:model.num];
    
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

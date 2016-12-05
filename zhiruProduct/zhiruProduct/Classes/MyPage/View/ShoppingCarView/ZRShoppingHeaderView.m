//
//  ZRShoppingHeaderView.m
//  zhiruProduct
//
//  Created by pj on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShoppingHeaderView.h"

@implementation ZRShoppingHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createView];
        [self setViewMasonary];
//        UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionDo)];
//        
//        [self addGestureRecognizer:tapGeture];
    }
    return self;
}
- (void)createView
{
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_selectButton];
    [self.selectButton setImage:[UIImage imageNamed:@"daixuan"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateSelected];
//    [self.selectButton addTarget:self action:@selector(actionSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.titleLabel setTextColor:RGBCOLOR(85, 85, 85)];
    
    self.rightImage = [[UIImageView alloc] init];
    [self.rightImage setImage:[UIImage imageNamed:@"jiantou-you2"]];
    [self addSubview:_rightImage];
    
    self.edtintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.edtintButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.edtintButton setTitle:@"完成" forState:UIControlStateSelected];
    [self.edtintButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.edtintButton setTitleColor:RGBCOLOR(85, 85, 85) forState:UIControlStateNormal];
//    [self.edtintButton addTarget:self action:@selector(actionEdtintButon:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.edtintButton];
    
    self.lineView = [[UIView alloc] init];
    [self addSubview:_lineView];
    [_lineView setBackgroundColor:RGBCOLOR(187, 187, 187)];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearButton setBackgroundColor:[UIColor clearColor]];
    [self.clearButton addTarget:self action:@selector(ActionDo) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clearButton];
    
}
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.selectButton.mas_right).with.offset(15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.edtintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel.mas_left).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf.rightImage.mas_right).with.offset(-10);
    }];
}
- (void)setModel:(ZRShoppingCarModel *)model
{
    _model = model;
    self.selectButton.selected = model.headerSelectState;
    self.edtintButton.selected = model.editingState;
    [self.titleLabel setText:model.businessName];
}
- (void)setMarketModel:(ZRMarketModel *)marketModel
{
    _marketModel = marketModel;
    self.edtintButton.selected = _marketModel.editingState;
    self.selectButton.selected = _marketModel.headerSelectState;
    [self.titleLabel setText:_marketModel.kaName];
}
- (void)ActionDo
{
    [self.delegate actionSectionHeaderView:self.section];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  ZRProductSectionCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProductSectionCell.h"

@interface ZRProductSectionCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnConstraint;
@property (weak, nonatomic) IBOutlet UIView *btnBaseView;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (nonatomic , strong ) UIButton * selectBtn;

@property (nonatomic , strong )NSArray * commentTitle;
@end

@implementation ZRProductSectionCell

-(void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLB.text = title;
    self.btnConstraint.constant = 0;
    
}

-(NSArray *)commentTitle{
    if (_commentTitle==nil) {
        _commentTitle =@[@"全部",@"好评",@"差评",@"有图"];
    }
    return _commentTitle;
}

-(void)setIsHideBtnView:(BOOL)isHideBtnView{
    
    _isHideBtnView = isHideBtnView;
    self.btnBaseView.hidden = NO;
    self.btnConstraint.constant = 88;
    if (isHideBtnView == YES) {
        [self createBottomBtn];
    }
}

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createBottomBtn{
    CGFloat spacing = 15;
    CGFloat btnSpacing = 23;
    CGFloat btnW =( ScreenWidth - 2 * spacing - 2 * btnSpacing ) * 0.33;
    CGFloat btnH = 30;
    CGFloat btnY = 10;
    for (int i = 0; i < 4; i++) {
        
        CGFloat btnX = 15 + i * btnW + i * btnSpacing;
        
        if (i==3) {
            btnY = 2 * btnY + btnH;
            btnX = 15;
        }
        UIButton * bottomBtn = [MyControl createButtonWithFrame:CGRectMake(btnX, btnY, btnW, btnH) ImageName:nil Target:self Action:@selector(bottomBtnClick:) Title:[NSString stringWithFormat:@"%@(%@)",self.commentTitle[i],self.titleNumbArr[i]]];
        
        bottomBtn.layer.cornerRadius = 3;
        bottomBtn.layer.masksToBounds = YES;
        
        bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        
        [bottomBtn setBackgroundColor:R_G_B_16(0xd1d1d1) forState:UIControlStateNormal];
        [bottomBtn setBackgroundColor:R_G_B_16(0x8fd3ff) forState:UIControlStateSelected];
        
        if (i == _selectIndex) {
            bottomBtn.selected = YES;
            _selectBtn = bottomBtn;
        }
        
        bottomBtn.tag = 100 + i;
        
        [self.btnBaseView addSubview:bottomBtn];
    }
}


- (void)bottomBtnClick :(UIButton *)btn{
    //执行回调
    _selectBtn.selected = NO;
    
    btn.selected = YES;
    
    _selectBtn = btn;
    
    _SectionClick(btn.tag);
}
@end

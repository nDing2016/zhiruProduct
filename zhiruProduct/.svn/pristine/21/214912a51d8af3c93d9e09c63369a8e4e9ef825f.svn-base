//
//  ZROrderingComment.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingComment.h"

@interface ZROrderingComment ()
@property (weak, nonatomic) IBOutlet UILabel *score; //评分

@property (weak, nonatomic) IBOutlet UIImageView *tasteScoreImg; //口味评分图片

@property (weak, nonatomic) IBOutlet UILabel *tasteScore; //口味评分


@property (weak, nonatomic) IBOutlet UIImageView *serviceScoreImg; //服务评分图片
@property (weak, nonatomic) IBOutlet UILabel *serviceScore; // 服务评分

@property (weak, nonatomic) IBOutlet UIView *bottomView;  //底部view 添加button

@property (nonatomic , strong ) UIButton * selectBtn;
@property (nonatomic , strong ) NSMutableArray * butMarr;
@end

@implementation ZROrderingComment

- (NSMutableArray *)butMarr{
    if (_butMarr == nil) {
        _butMarr = [NSMutableArray array];
        
        
    }
    return _butMarr;
}

-(void)setModel:(ZRCommentListModel *)model{
    _model = model;
    
    _score.text = model.commentGrade;
    
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self createBottomBtn];
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
        UIButton * bottomBtn = [MyControl createButtonWithFrame:CGRectMake(btnX, btnY, btnW, btnH) ImageName:nil Target:self Action:@selector(bottomBtnClick:) Title:@"全部 (210)"];
        
        bottomBtn.layer.cornerRadius = 3;
        bottomBtn.layer.masksToBounds = YES;
        
        bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        
        [bottomBtn setBackgroundColor:R_G_B_16(0xd1d1d1) forState:UIControlStateNormal];
        [bottomBtn setBackgroundColor:R_G_B_16(0x8fd3ff) forState:UIControlStateSelected];
        
        if (i ==1) {
            bottomBtn.selected = YES;
            _selectBtn = bottomBtn;
        }
        
        bottomBtn.tag = 100 + i;
        
        [self.bottomView addSubview:bottomBtn];
    }
}

#pragma mark - 底部按钮点击事件
- (void)bottomBtnClick :(UIButton *)btn{
    _selectBtn.selected = NO;
    
    btn.selected = YES;
    
    _selectBtn = btn;
}
@end

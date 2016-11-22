//
//  ZRKindsOfReview.m
//  zhiruProduct
//
//  Created by nanding on 16/7/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRKindsOfReview.h"

@interface ZRKindsOfReview ()
////全部
//@property (nonatomic, strong) UIButton *allBtn;
////好评
//@property (nonatomic, strong) UIButton *goodReviewBtn;
////差评
//@property (nonatomic, strong) UIButton *badReviewBtn;
////带图
//@property (nonatomic, strong) UIButton *withImageBtn;

@end

@implementation ZRKindsOfReview

#pragma mark - init
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat x = 15;
        CGFloat width = (SCREEN_WIDTH-15*6)/3;
        CGFloat height = (90*SCREEN_HEIGHT/667-10*3)/2;
        for (int i=0; i<4; i++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(x*(i+1)+width*i, 10, width, height);
            btn.backgroundColor = RGBCOLOR(199, 199, 199);
            if (i==3) {
                btn.frame = CGRectMake(x, 10*2+height, width, height);
                [btn setTitle:@"有图(20)" forState:UIControlStateNormal];
            }else if (i == 0) {
                btn.backgroundColor = RGBCOLOR(127, 199, 254);
                [btn setTitle:@"全部(246)" forState:UIControlStateNormal];
            }else if (i == 1){
                [btn setTitle:@"好评(246)" forState:UIControlStateNormal];
            }else{
                [btn setTitle:@"差评(246)" forState:UIControlStateNormal];
            }
            btn.tag = 111+i;
            btn.layer.cornerRadius = 5;
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(reviewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }

    }
    return self;
}


#pragma mark - click methods
/**
 *  网友点评
 */
- (void)reviewBtnClick:(UIButton *)sender
{
    for (int i=0; i<4; i++) {
        int t = 111+i;
        UIButton *btn = [self viewWithTag:t];
        if (t == sender.tag) {
            btn.backgroundColor = RGBCOLOR(127, 199, 254);
        }else{
            btn.backgroundColor = RGBCOLOR(199, 199, 199);
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  ZRScreeningView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRScreeningView.h"

@interface ZRScreeningView ()

@property (nonatomic , strong) UIView * maskView;
@property (nonatomic , strong) NSArray * titleArr ;
@end

@implementation ZRScreeningView

-(NSMutableArray *)rootViewArr{
    if (_rootViewArr == nil) {
        _rootViewArr = [NSMutableArray array];
    }
    return _rootViewArr ;
}

- (instancetype)initWithFrame:(CGRect)frame andTitleArr :(NSArray *)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleArr = titleArr;
        //蒙版
        UIView * maskingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-40)];
        
        maskingView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
        
        _maskView = maskingView;
        
        self.hidden = YES;
        
        [self addSubview:maskingView];
        
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton * searchInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, i * 40, ScreenWidth, 40)];

        [searchInfoBtn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [searchInfoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [searchInfoBtn setBackgroundColor:[UIColor whiteColor]];
        [searchInfoBtn addTarget:self action:@selector(searchInfoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_maskView addSubview:searchInfoBtn];
    }


}

- (void)searchInfoBtnClick :(UIButton *)btn{
    //NSLog(@"点击筛选");
    self.hidden = YES;
    //回调
    if (self.screeningViewClick) {
        self.screeningViewClick(btn.titleLabel.text);
    }
}
@end

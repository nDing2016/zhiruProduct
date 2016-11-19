//
//  ZRQueryView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRQueryView.h"

@interface ZRQueryView ()
@property (nonatomic , strong) NSArray * titleArr;


@property (nonatomic , strong) UIView * selectView; //记录当前选中 view
@property (nonatomic , strong) UIButton * searchBtn; //记录按钮位置


@end

@implementation ZRQueryView



-(instancetype)initWithFrame:(CGRect)frame andTitleArr :(NSArray *)titleArr {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _titleArr = titleArr;
        //暂时写着,后期后台有数据 这个方法 要换位置调用
        [self createSearchBox];
        //暂时写着,后期后台有数据 这个方法 要换位置调用
//        [self createSearchInfo];
    }
    return self;
}

#pragma mark -- 创建视图
- (void)createSearchBox{
    
    CGFloat SearchBtnH = 40 ;
    CGFloat SearchBtnW = ScreenWidth / _titleArr.count ;

    
    for (int i = 0 ; i < _titleArr.count; i++) {
        
        UIButton * searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * SearchBtnW, 0, SearchBtnW, SearchBtnH) ];
        searchBtn.tag = i;
      
        [searchBtn setImage:[UIImage imageNamed:@"jiantouxia"] forState:UIControlStateNormal];
        [searchBtn setImage:[UIImage imageNamed:@"jiantoushang"] forState:UIControlStateSelected];
        
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [searchBtn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [searchBtn setTitle:self.titleArr[i] forState:UIControlStateSelected];
        
        CGFloat spacing = 3.0;
        
        // 图片右移
        CGSize imageSize = searchBtn.imageView.frame.size;
        searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width * 2 - spacing, 0.0, 0.0);
        
        // 文字左移
        CGSize titleSize = searchBtn.titleLabel.frame.size;
        searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - titleSize.width * 2 - spacing);
        [searchBtn setBackgroundColor:[UIColor whiteColor]];
        searchBtn.layer.borderWidth = 1;
        searchBtn.layer.borderColor = R_G_B_16(0xf0eff5).CGColor;
        
        [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:searchBtn];
        

        _searchBtn = searchBtn;
    }
}




#pragma mark -- 按钮点击事件
- (void)searchBtnClick:(UIButton *)btn{
    if (btn != _selectBtn) {
        _selectBtn.selected = NO;
        _selectBtn = btn;
    }

    btn.selected = !btn.selected;

    
    if (self.queryBtnClick) {
        self.queryBtnClick(btn.tag);
    }
}

//
//- (void)animationView :(UIView *)selectView{
//    CGRect viewFrame = selectView.frame;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        if (viewFrame.origin.y!=-selectView.height) {
//            selectView.y = -viewFrame.size.height;
//
//        }else{
//            selectView.y = 40;
//
//        }
//    }completion:^(BOOL finished) {
//        
//    }];
//    
//}
@end

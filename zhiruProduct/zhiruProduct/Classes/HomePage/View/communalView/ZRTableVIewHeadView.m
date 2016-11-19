//
//  ZRTableVIewHeadView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/2.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRTableVIewHeadView.h"

@interface ZRTableVIewHeadView ()


@property (nonatomic , strong) NSArray * titleArr; //* 保存标题*/
@property (nonatomic , weak) UIView * baseView; //* 父视图*/

@property (nonatomic , strong) NSMutableArray * btnMarr ; //* 保存本视图按钮*/
/**
 *  头部视图图片 url 集合
 */
@property (nonatomic , strong)NSArray * titleImgArr;
@end

@implementation ZRTableVIewHeadView

-(NSMutableArray *)btnMarr{
    if (_btnMarr == nil) {
        _btnMarr = [NSMutableArray array];
    }
    return _btnMarr;
}

- (instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray * )titleArr andTitleImgArr :(NSArray*)titleImgArr
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleImgArr = titleImgArr;
        _titleArr = titleArr;
        //添加子视图
        UIView * baseView = [[UIView alloc] init];
        _baseView = baseView;
        
        [self addSubview: baseView];
        
        
        [self createSubView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (_titleArr.count > 4) {
        _baseView.frame = CGRectMake(0, 0, ScreenWidth, 200);
    }else{
        _baseView.frame = CGRectMake(0, 0, ScreenWidth, 110);
    }
    
    
}


- (void)createSubView{
    
    //创建 按钮
    CGFloat rowCount = 0;
    CGFloat count = 0;
    CGFloat btnWH = 44.f;
    CGFloat btnSpacing = (ScreenWidth - 4 * btnWH) / 5;
    for ( int i = 0  ; i < _titleArr.count; i++) {
        
        if (i == 4) {
            rowCount +=1;
            count = 0;
        }
        
        CGFloat btnX = count * btnWH + count * btnSpacing + btnSpacing;
        CGFloat btnY = rowCount * 40 + rowCount * 44  + 20;
        
//        //创建手势
//        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImgView:)];

        //创建图片V
        UIButton * imgV = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnWH, btnWH)];
        imgV.tag = i;

//        imgV.image = [self imageWithColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]];
//        imgV setImage:[UIImage imageNamed:] forState:<#(UIControlState)#>
        if (_titleImgArr.count>0) {
            [imgV setImage:[UIImage imageNamed:self.titleImgArr[i] ] forState:UIControlStateNormal];
        }else{

//            [imgV setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1] forState:UIControlStateNormal] ;
            NSURL * url = [NSURL URLWithString:self.titleImgArr[i]] ;
            [imgV sd_setImageWithURL:url forState:UIControlStateNormal];
        }
       
        [imgV addTarget:self action:@selector(clickImgView:) forControlEvents:UIControlEventTouchUpInside];
        //添加点击手势
//        [imgV addGestureRecognizer:tapGesture];
        
        [_baseView addSubview:imgV];
        //将图片view保存,等待网络请求到 图片,设置图片
        [self.btnMarr addObject:imgV];
        
        //创建 下方文字
        UILabel * btnTitle = [[UILabel alloc] init];
        btnTitle.text = self.titleArr[i];
        btnTitle.font = [UIFont systemFontOfSize:12];
        btnTitle.textAlignment =  NSTextAlignmentCenter ;
        
        [_baseView addSubview:btnTitle];
        
        [btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imgV.mas_centerX);
            make.top.equalTo(imgV.mas_bottom).offset(10);
        }];
        
        count ++;
        
    }
    
    
    UIView * lineV = [[UIView alloc] init];
    
    lineV.backgroundColor = ZRBackgroundColor;
    
    [self addSubview:lineV];
    
    WS(ws)
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left);
        make.right.equalTo(ws.mas_right);
        make.height.equalTo(@15);
        make.top.equalTo(ws.baseView.mas_bottom);
    }];
    
    
}

#pragma mark -- 设置图片数据
-(void)setTitleImgArr:(NSArray *)titleImgArr{
    
    _titleImgArr = titleImgArr;
    
    for (int i = 0; i < titleImgArr.count; i++) {
        
        UIImageView * imgV = self.btnMarr[i];
        
        [imgV sd_setImageWithURL:titleImgArr[i] placeholderImage:ZRPlaceholderImage];
        
    }
}

#pragma mark -- 图片点击
- (void)clickImgView :(UIButton *)btn {
    
    if (self.clickImgView) {
        
        self.clickImgView (btn.tag);

    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    //[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

@end

//
//  ZRGroupBuyingDetailsToolView.m
//  zhiruProduct
//
//  Created by nanding on 16/7/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingDetailsToolView.h"

#define buyWidth                    (75*SCREEN_WIDTH/375)
#define addWidth                    (100*SCREEN_WIDTH/375)
#define SelfHeight                  (40*SCREEN_WIDTH/375)


@interface ZRGroupBuyingDetailsToolView ()

@property (nonatomic, strong) UIButton *buyBtn;
@property (nonatomic, strong) UIButton *addShoppingCarBtn;

@end

@implementation ZRGroupBuyingDetailsToolView

#pragma mark - 懒加载
/**
 *  立即购买
 */
-(UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-buyWidth-addWidth, 0, buyWidth, SelfHeight)];
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

/**
 *  加入购物车
 */
-(UIButton *)addShoppingCarBtn
{
    if (!_addShoppingCarBtn) {
        _addShoppingCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-addWidth, 0, addWidth, SelfHeight)];
        _addShoppingCarBtn.backgroundColor = [UIColor redColor];
        [_addShoppingCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addShoppingCarBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addShoppingCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addShoppingCarBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_addShoppingCarBtn addTarget:self action:@selector(addShoppingCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addShoppingCarBtn;
}

#pragma mark - click methods
/**
 *  加入购物车点击事件
 */
- (void)addShoppingCarBtnClick:(UIButton *)sender
{
    
}

/**
 *  立即购买点击事件
 */
- (void)buyBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(buyImmediate)]) {
        [self.delegate buyImmediate];
    }
}

#pragma mark - init 

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        [self addSubview:self.addShoppingCarBtn];
        [self addSubview:self.buyBtn];
    }
    return self;
}

#pragma mark - drawRect
-(void)drawRect:(CGRect)rect
{
    //现价
    CGSize size1 = [NSString getSize:_nowPrice strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, ScreenHeight)];
    [self drawWithStr:_nowPrice Font:[UIFont systemFontOfSize:15] Color:[UIColor redColor] Point:CGPointMake(15, (40*ScreenHeight/667-size1.height)/2)];
    
    //原价
    CGSize size2 = [NSString getSize:_originalPrice strFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(SCREEN_WIDTH, ScreenHeight)];
    [self drawWithStr:_originalPrice Font:[UIFont systemFontOfSize:13] Color:[UIColor whiteColor] Point:CGPointMake(15+size1.width+10, (40*ScreenHeight/667-size2.height)/2)];
    
    [self drawLineStartPoint:CGPointMake(15+size1.width+10, (40*ScreenHeight/667-size2.height)/2+size2.height/2) endPoint:CGPointMake(15+size1.width+10+size2.width, (40*ScreenHeight/667-size2.height)/2+size2.height/2) Color:[UIColor whiteColor]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

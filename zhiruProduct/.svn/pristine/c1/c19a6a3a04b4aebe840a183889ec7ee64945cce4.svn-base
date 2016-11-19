//
//  ZRNewFeatureCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//
#define DURATION 1.0f
#import "ZRNewFeatureCell.h"
#import "ZRTabBarViewController.h"
@interface ZRNewFeatureCell ()
@property (nonatomic, weak) UIButton *startButton;//立即体验按钮
@property (nonatomic, weak) UIImageView *imageV;
@end

@implementation ZRNewFeatureCell
//立即体验
- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [startBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [startBtn setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
        

        startBtn.backgroundColor = [UIColor clearColor];
        
//        startBtn.layer.borderWidth = 1.f;
//        startBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//        startBtn.layer.cornerRadius = 8;
//        startBtn.layer.masksToBounds = YES;
        
//        startBtn.width = ScreenWidth * 0.3;
//        startBtn.height = 34.f;
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
        
    }
    
    return _startButton;
}

#pragma mark - 点击立即体验的时候调用
- (void)start
{
    // 跳转到主页,tabBarVc
    ZRTabBarViewController *VC = [[ZRTabBarViewController alloc] init];
    
    // 切换根控制器
    AppKeyWindow.rootViewController = VC;
    
    // 转场动画:一定要跟转场代码放在一起
    CATransition *anim = [CATransition animation];
    anim.type = @"rippleEffect";
    //设置运动时间
    anim.duration = DURATION;
    //设置运动速度
    anim.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [AppKeyWindow.layer addAnimation:anim forKey:nil];
    
    
}

- (UIImageView *)imageV
{
    if (_imageV == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:imageV];
        _imageV = imageV;
    }
    
    return _imageV;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageV.image = image;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageV.frame = self.bounds;
    
    // 设置体验按钮的位置
    self.startButton.frame = CGRectMake(0, ScreenHeight - 70, ScreenWidth, 70);
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count
{
    if (indexPath.row == count - 1) { // 最后cell
        // 显示开始
        self.startButton.hidden = NO;
        
    }else{
        // 隐藏开始
        self.startButton.hidden = YES;
        
    }
}

@end

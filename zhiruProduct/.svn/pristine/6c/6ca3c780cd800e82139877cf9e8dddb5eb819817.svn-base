//
//  CustomHudView.m
//  OverseasShopping
//
//  Created by daozhang on 16/3/7.
//  Copyright © 2016年 ksfc. All rights reserved.
//

#import "CustomHudView.h"

@interface CustomHudView ()
{
    UIControl *overControl;               /**< 蒙版 */
}

@property (nonatomic,strong)UIImageView *rotationImgView;


@end


@implementation CustomHudView

- (instancetype)init{
    self = [super init];
    if (self) {  //self是滚轮视图
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.backgroundColor = R_G_B_16(0xeeeeee);

    //蒙版
    overControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
//    overControl.backgroundColor = [UIColor blackColor];
//    overControl.alpha = 0.1;
//    [overControl addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];

    
    self.rotationImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-20/2,ScreenHeight/2-20/2,20, 20)];
    self.rotationImgView.backgroundColor =[UIColor clearColor];
    self.rotationImgView.image = [UIImage imageNamed:@"loading1.png"];
    
    [overControl addSubview:self.rotationImgView];
    
    //切圆
    self.rotationImgView.layer.cornerRadius = self.rotationImgView.frame.size.width / 2;
    self.rotationImgView.layer.masksToBounds = YES;
    
    //两个动画组成一个动画组
    /* 动画1（绕Z轴中心旋转） */
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    animation.fromValue = @(0.0);  // 设定动画起始帧和结束帧
    animation.toValue = @(M_PI);
    animation.duration = 1;  //动画持续时间
    animation.cumulative = YES;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.repeatCount = 1e100;  //重复次数
    
    // 添加动画
    [self.rotationImgView.layer addAnimation:animation forKey:@"rotate-layer"];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 缩放倍数
    animation2.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation2.toValue = [NSNumber numberWithFloat:1.2];   // 结束时的倍率
    [animation2 setAutoreverses:YES];  //原路返回的动画一遍
    
    // 动画选项设定
    animation2.duration = 2.5;
    animation2.repeatCount = 1e100;
    
    [self.rotationImgView.layer addAnimation:animation2 forKey:@"scale-layer"];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:overControl];
    
}
+ (void)show{
    
    CustomHudView *hud = [[CustomHudView alloc] init];
    
}

//点击蒙版和取消按钮滚轮消失
+ (void)dismiss{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSArray *viewArr = keyWindow.subviews;
    for (int i = 0; i < viewArr.count; i ++) {
        UIView *view = viewArr[i];
        NSLog(@"%@",[view class]);
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}


@end

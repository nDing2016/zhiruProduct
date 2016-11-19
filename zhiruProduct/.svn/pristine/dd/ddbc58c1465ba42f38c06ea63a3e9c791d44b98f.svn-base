//
//  ZROrderRemarksView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/10/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderRemarksView.h"

@interface ZROrderRemarksView ()
@property (weak, nonatomic) IBOutlet UITextView *userTest;
/** 背景cover */
@property (nonatomic, strong) UIView *bgView;
@end

@implementation ZROrderRemarksView

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _bgView.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ZROrderRemarksView" owner:self options:nil] lastObject];
        // 初始化设置
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = CGRectMake(20 + ScreenWidth, (ScreenHeight - 240) / 2, ScreenWidth - 40, 240);
        [window addSubview:self.bgView];
        [window addSubview:self];
    }
    return self;
}
/** 显示 */
- (void)show{
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.hidden = NO;
        
        CGPoint center = self.center;
        center.x = ScreenWidth / 2;
        self.center = center;
    } completion:nil];
}

/** 隐藏 */
- (void)hide{
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:0 animations:^{
        self.bgView.hidden = YES;
        
        CGPoint center = self.center;
        center.x = ScreenWidth / 2 + ScreenWidth;
        self.center = center;
    } completion:nil];
}



- (IBAction)userClickOK:(id)sender {

    
    if (self.userClickQueding) {
        self.userClickQueding(self.userTest.text);
        [self hide];
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

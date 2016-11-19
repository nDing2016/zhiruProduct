//
//  AlertText.m
//  zhiruProduct
//
//  Created by pj on 16/9/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "AlertText.h"
#import "ZRStringWithLabel.h"

@interface AlertText ()
{
    UIControl *backControl;               /**< 蒙版 */
}

@property (nonatomic, strong)AlertText * alertLabel;

@end

@implementation AlertText


- (instancetype)initAndText:(NSString *)string
{
    self = [super init];
    if (self) {
        [self createUI:string];
    }
    return self;
}
- (void)createUI:(NSString *)string
{
    backControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    CGFloat width = [ZRStringWithLabel returanWidthWithText:string height:40 font:[UIFont systemFontOfSize:16]] + 40;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - width) / 2.0, (ScreenHeight - 40 - 64) / 2.0, width, 40)];
    [label setText:string];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor blackColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setAlpha:0.7];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5.0;
//    label.layer.borderWidth = 2.0;
//    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [backControl addSubview:label];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:backControl];
}
+ (void)showAndText:(NSString *)string
{
    AlertText * a = [[AlertText alloc] initAndText:string];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        NSArray *viewArr = keyWindow.subviews;
        for (int i = 0; i < viewArr.count; i ++) {
            UIView *view = viewArr[i];
            //NSLog(@"%@",[view class]);
            if ([view isKindOfClass:[UIControl class]]) {
                [view removeFromSuperview];
            }
        }
    });
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

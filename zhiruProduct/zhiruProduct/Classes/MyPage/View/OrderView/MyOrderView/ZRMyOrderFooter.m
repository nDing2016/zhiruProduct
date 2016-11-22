//
//  ZRMyOrderFooter.m
//  zhiruProduct
//
//  Created by pj on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMyOrderFooter.h"

@implementation ZRMyOrderFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (void)setArray:(NSMutableArray *)array
{
    _array = array;
    NSArray * imageArray = [_array objectAtIndex:0];
    NSArray * titleArray = [_array objectAtIndex:1];
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width / imageArray.count;
    NSInteger temp = imageArray.count;
    for (int i = 0; i < temp; i++) {
        ZRFooterDetailView * view = [[ZRFooterDetailView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
//                [view.titleImage setImage:[UIImage imageNamed:[keyArray objectAtIndex:i]]];
//        [view.titleLabel setText:[_dic objectForKey:[keyArray objectAtIndex:i]]];
        [view.titleLabel setText:[titleArray objectAtIndex:i]];
        [view.titleImage setImage:[imageArray objectAtIndex:i]];
        [self addSubview:view];
        if (i == 0) {
            [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
        }
        view.tag = i + 2000;
        if (i < temp - 1) {
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(width, 5, 1, height - 10)];
            [lineView setBackgroundColor:RGBCOLOR(187, 187, 187)];
            [view addSubview:lineView];
        }
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        [button setBackgroundColor:[UIColor clearColor]];
        button.tag = i + 1000;
        [button addTarget:self action:@selector(actionSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }

}
//- (void)setDic:(NSDictionary *)dic
//{
////    _dic = dic;
//    CGFloat height = self.frame.size.height;
//    CGFloat width = self.frame.size.width / 4.0;
//    NSInteger temp = dic.allKeys.count;
//    NSArray * keyArray = dic.allKeys;
//    for (int i = 0; i < temp; i++) {
//        ZRFooterDetailView * view = [[ZRFooterDetailView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
////        [view.titleImage setImage:[UIImage imageNamed:[keyArray objectAtIndex:i]]];
//        [view.titleLabel setText:[_dic objectForKey:[keyArray objectAtIndex:i]]];
//        [self addSubview:view];
//        if (i == 0) {
//            [view.titleLabel setTextColor:RGBCOLOR(255, 82, 82)];
//        }
//        view.tag = i + 2000;
//        if (i < temp - 1) {
//            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(width, 5, 1, height - 10)];
//            [lineView setBackgroundColor:RGBCOLOR(187, 187, 187)];
//            [view addSubview:lineView];
//        }
//        
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
//        [button setBackgroundColor:[UIColor clearColor]];
//        button.tag = i + 1000;
//        [button addTarget:self action:@selector(actionSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:button];
//    }
//}
- (void)actionSelectedButton:(UIButton *)button
{
    [self.delegate selectClickButton:button];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

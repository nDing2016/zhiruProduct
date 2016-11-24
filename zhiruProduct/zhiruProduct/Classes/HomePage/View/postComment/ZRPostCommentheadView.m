//
//  ZRPostCommentheadView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPostCommentheadView.h"
#import "StarView.h"
#import "StarsView.h"

@interface ZRPostCommentheadView ()


@end

@implementation ZRPostCommentheadView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

//        [self createStarsViews];
    }
    return self;
}

-(void)setIsLiren:(BOOL)isLiren{
    _isLiren = isLiren;
    
    _kouwei.text = @"效果";
    
}

- (void)setIsGame:(BOOL)isGame {
    _isGame = isGame;
    
    _kouwei.text = @"设施";
}

- (void)createStarsViews{
    StarsView *overallView = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5 starHighLightImage:@"xingxing-hei" starNormalImage:@"xingxing-hei"];
    //    view.backgroundColor = [UIColor blackColor];
    //    view.supportDecimal = YES;
    overallView.score = 1;
    overallView.frame = CGRectMake(0, 0, overallView.frame.size.width, overallView.frame.size.height);
    
    [self.overallGrade addSubview:overallView];
    
    StarsView *tasteView = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5 starHighLightImage:@"xingxing-hei" starNormalImage:@"xiaolian-hei"];
    tasteView.score = 1;
    tasteView.frame = CGRectMake(0, 0, tasteView.frame.size.width, tasteView.frame.size.height);
    
    [self.tasteGrade addSubview:tasteView];
    
    StarsView *environmentView = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5 starHighLightImage:@"xingxing-hei" starNormalImage:@"xiaolian-hei"];
    environmentView.score = 1;
    environmentView.frame = CGRectMake(0, 0, environmentView.frame.size.width, environmentView.frame.size.height);
    
    [self.environmentGrade addSubview:environmentView];
    
    StarsView *serviceView = [[StarsView alloc] initWithStarSize:CGSizeMake(20, 20) space:5 numberOfStar:5 starHighLightImage:@"xingxing-hei" starNormalImage:@"xiaolian-hei"];
    serviceView.score = 1;
    serviceView.frame = CGRectMake(0, 0, serviceView.frame.size.width, serviceView.frame.size.height);
    
    [self.serviceGrade addSubview:tasteView];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}


@end

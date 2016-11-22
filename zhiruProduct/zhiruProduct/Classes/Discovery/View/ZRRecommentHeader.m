//
//  ZRRecommentHeader.m
//  zhiruProduct
//
//  Created by nanding on 16/7/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRRecommentHeader.h"

@implementation ZRRecommentHeader


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
//        UIImageView *imgView = [[UIImageView alloc] init];
//        imgView.backgroundColor = [UIColor redColor];
//        [view addSubview:imgView];
//        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(7.5, 15, 7.5, 15));
//            
//            
//        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGBCOLOR(173, 173, 173);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@1);
            
        }];

        
        
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    UIImage *backImage = ZRImage(@"ft_beijing");
    [self drawImage:backImage Rect:CGRectMake(15, 7.5, SCREEN_WIDTH-30, self.height-15)];
    
    //title
    [self drawWithStr:self.titleStr Font:[UIFont systemFontOfSize:20] Color:[UIColor whiteColor] Point:CGPointMake(150, 20)];
    
    //查看全部
    [self drawWithStr:@"查看全部" Font:[UIFont systemFontOfSize:15] Color:[UIColor whiteColor] Point:CGPointMake(160, 60)];
    
    
    
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  ZRTabBarButton.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/23.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRTabBarButton.h"

@implementation ZRTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        
    }
    return self;
}

//赋值
- (void)setItem:(UITabBarItem *)item{
    _item = item;
    

    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    

}



-(void)layoutSubviews{
    [super layoutSubviews];
    
//    CGFloat imageH = self.height * 0.7;
//    CGFloat imageW = self.width;
//    CGFloat imageXY = 0;
//    
//    // 设置图片
//    self.imageView.frame  = CGRectMake(imageXY, (self.height - imageH) * 0.5 , imageW, imageH);
//    
//    
//    CGFloat titleX = 0;
//    CGFloat titleY = imageH - 1;
//    CGFloat titleH = self.height - imageH;
//    CGFloat titleW = self.width;
//    
//    // 设置label
//    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

// 取消按钮高亮状态
- (void)setHighlighted:(BOOL)highlighted{}

@end

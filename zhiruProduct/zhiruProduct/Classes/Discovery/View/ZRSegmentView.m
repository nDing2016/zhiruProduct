//
//  ZRSegmentView.m
//  zhiruProduct
//
//  Created by nanding on 16/7/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSegmentView.h"

@implementation ZRSegmentView
{
    CGRect _fram;
    UIView *_linView;
    
    CGSize size1;
    CGSize size2;
    CGSize size3;
}

#pragma mark - init methods
-(instancetype)init
{
    if (self = [super init]) {
        
        
        
    }
    return self;
}


- (void)loadTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    size1 = [NSString getSize:_titleArray[0] strFont:_textFont maxSize:self.bounds.size];
    size2 = [NSString getSize:_titleArray[1] strFont:_textFont maxSize:self.bounds.size];
    size3 = [NSString getSize:_titleArray[2] strFont:_textFont maxSize:self.bounds.size];
    self.frame = CGRectMake(0, 0, size1.width+size2.width+size3.width+20, 44);
    
    [self setUpSubviews];
}


/**
 *  加载标题显示的方法2
 */
- (void)loadNomalTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
//    size1 = [NSString getSize:_titleArray[0] strFont:_textFont maxSize:self.bounds.size];
//    size2 = [NSString getSize:_titleArray[1] strFont:_textFont maxSize:self.bounds.size];
//    size3 = [NSString getSize:_titleArray[2] strFont:_textFont maxSize:self.bounds.size];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH*_titleArray.count/5, 40);
    
    [self setUpNormalSubviews];
}



#pragma mark - Private methods
- (void)setUpSubviews
{
    if (!_textSeletedColor) {
        _textSeletedColor = _textNormalColor;
    }
    
    //_linView = [[UIView alloc]initWithFrame:CGRectMake(0, _fram.size.height-2, _fram.size.width/_titleArray.count, 2)];
    //CGSize size = [NSString getSize:_titleArray[0] strFont:_textFont maxSize:self.bounds.size];
    _linView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-4, size1.width, 4)];

    _linView.backgroundColor = _linColor;
    [self addSubview:_linView];
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        //CGSize sizeBtn = [NSString getSize:_titleArray[i] strFont:_textFont maxSize:self.bounds.size];

        if (i==0) {
            button.frame = CGRectMake(0, 0, size1.width, 44);
        }else if (i==1){
            button.frame = CGRectMake(size1.width+10, 0, size2.width, 44);
        }else{
            button.frame = CGRectMake(size1.width+size2.width+20, 0, size3.width, 44);
        }
        //button.frame = CGRectMake(i*(_fram.size.width/_titleArray.count), 0, sizeBtn.width, sizeBtn.height);
        button.tag = 10 + i;
        button.titleLabel.font = _textFont;
        i == 0?([button setTitleColor:_textSeletedColor forState:UIControlStateNormal]):([button setTitleColor:_textNormalColor forState:UIControlStateNormal]);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
}



- (void)setUpNormalSubviews
{
    if (!_textSeletedColor) {
        _textSeletedColor = _textNormalColor;
    }
    
    //_linView = [[UIView alloc]initWithFrame:CGRectMake(0, _fram.size.height-2, _fram.size.width/_titleArray.count, 2)];
    //CGSize size = [NSString getSize:_titleArray[0] strFont:_textFont maxSize:self.bounds.size];
    _linView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-2, SCREEN_WIDTH/_titleArray.count, 2)];
    
    _linView.backgroundColor = _linColor;
    [self addSubview:_linView];
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        CGFloat width = SCREEN_WIDTH/5;
        button.frame = CGRectMake(i*width, 0, width, 40);
        button.tag = 10 + i;
        button.titleLabel.font = _textFont;
        i == 0?([button setTitleColor:_textSeletedColor forState:UIControlStateNormal]):([button setTitleColor:_textNormalColor forState:UIControlStateNormal]);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
}



#pragma mark - click methods
- (void)buttonPressed:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        _linView.frame = CGRectMake(sender.frame.origin.x, _linView.frame.origin.y, sender.frame.size.width, _linView.height);
        
    } completion:nil];
    for (int i = 0; i<_titleArray.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i + 10];
        sender.tag == (i+10)?([button setTitleColor:_textSeletedColor forState:UIControlStateNormal]):([button setTitleColor:_textNormalColor forState:UIControlStateNormal]);
    }
    
    if (_delegate &&[_delegate respondsToSelector:@selector(segmentView:index:)]){
        [self.delegate segmentView:self index:sender.tag-10];
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

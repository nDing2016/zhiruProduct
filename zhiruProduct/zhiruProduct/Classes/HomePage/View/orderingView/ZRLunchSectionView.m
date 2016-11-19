//
//  ZRLunchSectionView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/10/10.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLunchSectionView.h"

@interface ZRLunchSectionView ()
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (nonatomic , strong) UIButton * selectBtn;
@end

@implementation ZRLunchSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
    
    self.selectBtn = self.oneBtn;
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    _selectBtn.selected = NO;
    
    switch (index) {
        case 0:
            _oneBtn.selected = YES;
            _selectBtn = _oneBtn;
            break;
        case 1:
            _twoBtn.selected = YES;
            _selectBtn = _twoBtn;
            break;
       
        default:
            break;
    }
    _line.x = index * _oneBtn.width;
}
- (IBAction)btnClick:(UIButton*)sender {
    _selectBtn.selected = NO;
    
    sender.selected = YES;
    
    _selectBtn = sender;
    
    WS(ws)
    [UIView animateWithDuration:0.3 animations:^{
        //        ws.lineConstraint.constant = sender.tag * ws.btnOne.width;
        ws.line.x = sender.tag * ws.oneBtn.width;
    }];
    
    if (self.btnClick) {
        self.btnClick(sender.tag);
    }
}

@end

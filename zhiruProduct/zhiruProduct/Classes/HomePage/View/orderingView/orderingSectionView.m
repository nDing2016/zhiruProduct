//
//  orderingSectionView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "orderingSectionView.h"

@interface orderingSectionView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraint;//下方线条约束

@property (weak, nonatomic) IBOutlet UIButton *btnOne; //按钮
@property (weak, nonatomic) IBOutlet UIButton *btnTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnThree;

@property (weak, nonatomic) IBOutlet UIView *line; //蓝色线条
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineCOnstraint;

@property (nonatomic , strong) UIButton * selectBtn;
@end


@implementation orderingSectionView

-(void)awakeFromNib{
    [super awakeFromNib];
    

    self.selectBtn = self.btnOne;
}

-(void)setIsLunch:(BOOL)isLunch{
//    _isLunch = isLunch;
//    _btnOne.width = _scw * 0.5;
//    _btnThree.hidden = YES;
//    _oneConstraint.constant = _scw * 0.5;
//
//    [_btnTwo setTitle:@"午餐说明" forState:UIControlStateNormal];
//    _twoConstraint.constant = 0;
//    _lineCOnstraint.constant = _scw * 0.5;
   
    
}

-(void)setIndex:(NSInteger)index{
    _index = index;
    _selectBtn.selected = NO;

    switch (index) {
        case 0:
            _btnOne.selected = YES;
            _selectBtn = _btnOne;
            break;
        case 1:
            _btnTwo.selected = YES;
            _selectBtn = _btnTwo;
            break;
        case 2:
            _btnThree.selected = YES;
            _selectBtn = _btnThree;
            break;
        default:
            break;
    }
    _line.x = index * _btnOne.width;
}

- (IBAction)ClickBtn:(UIButton *)sender {
    _selectBtn.selected = NO;
    
    sender.selected = YES;
    
    _selectBtn = sender;
    
    WS(ws)
    [UIView animateWithDuration:0.3 animations:^{
        //        ws.lineConstraint.constant = sender.tag * ws.btnOne.width;
        ws.line.x = sender.tag * ws.btnOne.width;
    }];
    
    if (self.btnClick) {
        self.btnClick(sender.tag);
    }
}
@end

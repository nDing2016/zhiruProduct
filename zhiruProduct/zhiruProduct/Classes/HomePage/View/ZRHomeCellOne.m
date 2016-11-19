//
//  ZRHomeCellOne.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHomeCellOne.h"

@interface ZRHomeCellOne ()
@property (weak, nonatomic) IBOutlet UIButton *BtnImgOne;

@property (weak, nonatomic) IBOutlet UIButton *BtnImgTwo;

@end

@implementation ZRHomeCellOne


-(void) createAdvertisementAndImgOne :(NSString *)imgOne AndImgTwo :(NSString *)imgTwo{
//    _imgOne.image = [UIImage imageNamed:imgOne];
//    _imgTwo.image = [UIImage imageNamed:imgTwo];
    
//    [_BtnImgOne setImage:[UIImage imageNamed:imgOne] forState:UIControlStateNormal];
//    [_BtnImgTwo setImage:[UIImage imageNamed:imgTwo] forState:UIControlStateNormal];
    NSURL * urlOne = [NSURL URLWithString:imgOne];
    NSURL * urlTwo = [NSURL URLWithString:imgTwo];
    [_BtnImgOne sd_setImageWithURL:urlOne forState:UIControlStateNormal placeholderImage:ZRPlaceholderImage];
    [_BtnImgTwo sd_setImageWithURL:urlTwo forState:UIControlStateNormal placeholderImage:ZRPlaceholderImage];
    
    self.contentView.backgroundColor = R_G_B_16(0xfafafa);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)ImgBtnClick:(UIButton*)sender {
    
    _imgViewClick(sender.tag);
}

@end

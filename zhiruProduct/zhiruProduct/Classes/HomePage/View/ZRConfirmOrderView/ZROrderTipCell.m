//
//  ZROrderTipCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderTipCell.h"
#import "ZRSupermarketHomeObj.h"
@interface ZROrderTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipMoney;
@property (weak, nonatomic) IBOutlet UILabel *PercentageLabel;

@end

@implementation ZROrderTipCell

-(void)setPercentage:(float)percentage{
    _percentage = percentage;
    
    _PercentageLabel.text = [NSString stringWithFormat:@"收取餐费%%%f的小费",_percentage * 100];
    
    CGFloat moneyCount = [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount];
    _tipMoney.text = [NSString stringWithFormat:@"$%.2f",moneyCount * percentage];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

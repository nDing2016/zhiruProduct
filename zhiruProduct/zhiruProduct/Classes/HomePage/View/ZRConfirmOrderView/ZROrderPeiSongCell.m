//
//  ZROrderPeiSongCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderPeiSongCell.h"

@interface ZROrderPeiSongCell ()
//配送信息 由谁配送
@property (weak, nonatomic) IBOutlet UILabel *peisongInfo;
//实际配送价格 如果是会员 显示优惠价格
@property (weak, nonatomic) IBOutlet UILabel *peisongMoney;
//会员字样
@property (weak, nonatomic) IBOutlet UILabel *vipView;
//非会员价格
@property (weak, nonatomic) IBOutlet UILabel *peisongOriginalMoney;
//线
@property (weak, nonatomic) IBOutlet UIView *xianView;

@end

@implementation ZROrderPeiSongCell

-(void)setIsXXDistribution:(BOOL)isXXDistribution{
    _isXXDistribution = isXXDistribution;
    
    if (_isXXDistribution == YES) {
        _peisongInfo.text = [NSString stringWithFormat:@"本订单由 嗖嗖专送 提供配送"];
    }else{
        _peisongInfo.text = [NSString stringWithFormat:@"本订单由 店家 提供配送"];
    }
    
    if (_isVip == YES) {
        _vipView.hidden = NO;
        _peisongOriginalMoney.hidden = NO;
        _xianView.hidden = NO;
        _peisongOriginalMoney.text = [NSString stringWithFormat:@"$%.2f",_psMoney];
        //暂时假优惠
        _peisongMoney.text = [NSString stringWithFormat:@"$%.2f",_psMoney - _psMoney * 0.3];
    }else{
        _vipView.hidden = YES;
        _peisongOriginalMoney.hidden = YES;
        _xianView.hidden = YES;
         _peisongMoney.text = [NSString stringWithFormat:@"$%.2f",_psMoney];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

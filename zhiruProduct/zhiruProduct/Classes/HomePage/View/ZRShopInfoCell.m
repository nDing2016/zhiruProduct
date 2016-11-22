//
//  ZRShopInfoCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShopInfoCell.h"

@interface ZRShopInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *wifi;
@property (weak, nonatomic) IBOutlet UIImageView *stop;
@property (weak, nonatomic) IBOutlet UIImageView *ka;
@property (weak, nonatomic) IBOutlet UIImageView *baojian;
@property (weak, nonatomic) IBOutlet UILabel *openTIme;
@property (weak, nonatomic) IBOutlet UILabel *remarks;

@end

@implementation ZRShopInfoCell

-(void)setModel:(ZRBusinessDetailsModel *)model{
    _model = model;
    
    if ([model.is_wifi isEqualToString:@"0"]) {
        _wifi.image = [UIImage imageNamed:@"wifi-1"];
    }
    
    if ([model.is_depot isEqualToString:@"0"]) {
        _stop.image = [UIImage imageNamed:@"stop-1"];
    }
    
    if ([model.is_card_pay isEqualToString:@"0"]) {
        _ka.image = [UIImage imageNamed:@"ka-1"];
    }
    
    if ([model.is_private_room isEqualToString:@"0"]) {
        _baojian.image = [UIImage imageNamed:@"baojian-1"];
    }
    
    _openTIme.text = [NSString stringWithFormat:@"营业时间 : %@",model.open_time];
    
    _remarks.text =[NSString stringWithFormat:@"商家信息 : %@", model.remarks];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

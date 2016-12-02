//
//  ZROrdeingCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrdeingCell.h"

@interface ZROrdeingCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ordeingImg;
@property (weak, nonatomic) IBOutlet UILabel *ordeingName;
@property (weak, nonatomic) IBOutlet UILabel *startingPrice; //起送价

@property (weak, nonatomic) IBOutlet UIImageView *grade;//评分

@property (weak, nonatomic) IBOutlet UILabel *distance; //距离
@property (weak, nonatomic) IBOutlet UILabel *soldNum; //已售

@property (weak, nonatomic) IBOutlet UIImageView *preferential; //优惠0不是1是
@property (weak, nonatomic) IBOutlet UIImageView *onlinePay; //是否支持在线支付0不支持1支持"
@property (weak, nonatomic) IBOutlet UIImageView *specialDelivery; //是否支持XX专送
@property (weak, nonatomic) IBOutlet UILabel *pickUp;// pickUp 是否支持自提


@end

@implementation ZROrdeingCell

-(void)setBusinessModel:(ZROrderingBusinessMsg *)businessModel{
    _businessModel = businessModel;
    
    NSURL * url = [NSURL URLWithString:businessModel.imgUrl];
    [_ordeingImg sd_setImageWithURL:url placeholderImage:ZRPlaceholderImage];
    
    _ordeingName.text = businessModel.name;
    
    _startingPrice.text = [NSString stringWithFormat:@"$%@元起送",businessModel.startingPrice];
    
    _grade.image = [UIImage imageWithPingfenCount:[businessModel.grade floatValue]];
    
    _distance.text = businessModel.distance;
    
    _soldNum.text = [NSString stringWithFormat:@"已售%@份",businessModel.soldNum];
    
    if ([businessModel.pickUp isEqualToString:@"0"]) {
        _pickUp.hidden = YES;
    }else{
        _pickUp.hidden = NO;
    }
    
    if ([businessModel.preferential isEqualToString:@"0"]) {
        _preferential.image = [UIImage imageNamed:@"hui--hui"];
    }
    
    if ([businessModel.onlinePay isEqualToString:@"0"]) {
        _onlinePay.image = [UIImage imageNamed:@"fu-hui"];
    }
    
    if ([businessModel.specialDelivery isEqualToString:@"0"]) {
        _specialDelivery.image = [UIImage imageNamed:@"zhuansong-hui"];
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

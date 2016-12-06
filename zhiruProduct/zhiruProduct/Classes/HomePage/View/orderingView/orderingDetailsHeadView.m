//
//  orderingDetailsHeadView.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "orderingDetailsHeadView.h"

@interface orderingDetailsHeadView ()

@property (weak, nonatomic) IBOutlet UIImageView *businessImg;  //商家图

@property (weak, nonatomic) IBOutlet UILabel *businessName; //商家名

@property (weak, nonatomic) IBOutlet UILabel *operatingStatus; //营业状态

@property (weak, nonatomic) IBOutlet UILabel *sale; //销量

@property (weak, nonatomic) IBOutlet UILabel *distributionStatus; //配送方式

@property (weak, nonatomic) IBOutlet UILabel *startPrice; //起送价格

@property (weak, nonatomic) IBOutlet UILabel *distributionPrice; //配送费用

@property (weak, nonatomic) IBOutlet UIImageView *pingxing;

@property (weak, nonatomic) IBOutlet UIImageView *wucanImg;

@end

@implementation orderingDetailsHeadView

-(void)setModel:(ZROrderingBusinessMsgModel *)model{
    _model = model;
    
    NSURL * url ;
    
    if (_isLunch == YES) {
        url =  [NSURL URLWithString:model.img_url];
        _businessName.text = model.name;
    }else{
        
        url =  [NSURL URLWithString:model.imgUrl];
        _businessName.text = model.businessName;
    }
    
    [_businessImg sd_setImageWithURL:url placeholderImage:ZRPlaceholderImage];
    
    

    if ([model.rest isEqualToString:@"0"]) {
        //营业中
        _operatingStatus.text = @"营业中";
    }else{
        _operatingStatus.text = @"休息中" ;
    }

    if (model.orderNum == nil) {
        model.orderNum = @"0";
    }
    _sale.text = [NSString stringWithFormat:@"月售%@",model.orderNum];
    
    if ([model.specialDelivery isEqualToString:@"1"]) {
        _distributionStatus.text = @"XX专送";
    }else{
        _distributionStatus.text = @"店家配送";
    }

    _startPrice.text = [NSString stringWithFormat:@"$%@ 起送",model.startingPrice];
    
    _distributionPrice.text = [NSString stringWithFormat:@"配送费 $%@ 起",model.pCosts];
    
    _pingxing.image =  [UIImage imageWithPingfenCount:[model.grade floatValue]];
    //午餐
    if (_isLunch == YES) {
        _startPrice.hidden = YES;
        _distributionPrice.hidden = YES;
        _operatingStatus.hidden = YES;
//        _distributionStatus.text = @"到店自取";
        _distributionStatus.hidden = YES;
        _pingxing.hidden = YES;
        
        
        //显示大图
        self.wucanImg.hidden = NO;
        self.wucanImg.image = [UIImage imageNamed:@"wucan_datu"];
    }else{
        _startPrice.hidden = NO;
        _distributionPrice.hidden = NO;
        _operatingStatus.hidden = NO;
        self.wucanImg.hidden = YES;
    }
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    
    self.businessImg.layer.cornerRadius = 5;
    self.businessImg.layer.masksToBounds = YES;
}




@end

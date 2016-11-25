//
//  ZRHomeCellTwo.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHomeCellTwo.h"

@interface ZRHomeCellTwo ()

@property (weak, nonatomic) IBOutlet UIImageView *productImg;

@property (weak, nonatomic) IBOutlet UILabel *productTitle;

@property (weak, nonatomic) IBOutlet UIImageView *commentCount;

@property (weak, nonatomic) IBOutlet UIImageView *tuan;

@property (weak, nonatomic) IBOutlet UIImageView *ding;
@property (weak, nonatomic) IBOutlet UILabel *distance;//距离
@property (weak, nonatomic) IBOutlet UILabel *navName;
@property (weak, nonatomic) IBOutlet UILabel *regionName;
//是否支持外卖默认是0不支持1:支持
@property (copy, nonatomic) NSString * isPack;
//是否支持团购默认是0不支持1:支持
@property (copy, nonatomic) NSString * isGroup;
@end

@implementation ZRHomeCellTwo

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(ZRBusinessModel *)model{
    _model  = model;
    
    NSURL * mUrl = [NSURL URLWithString:model.imgUrl];
    [_productImg sd_setImageWithURL:mUrl placeholderImage:ZRPlaceholderImage];
    
    _productTitle.text = model.name;
    
    
    
    _commentCount.image = [UIImage imageWithPingfenCount:[model.grade integerValue]];

    
    _distance.text =[NSString stringWithFormat:@"%@km", model.distance];
    
    if ([model.isPack isEqualToString:@"0"]) {
        _ding.hidden = YES;
    }else{
        _ding.hidden = NO;
    }
    
    if ([model.isGroup isEqualToString:@"0"]) {
        _tuan.hidden = YES;
    }else{
        _tuan.hidden = NO;
    }
    
    _navName.text = model.regionName;
    
    _regionName.text = model.navName;
}
@end
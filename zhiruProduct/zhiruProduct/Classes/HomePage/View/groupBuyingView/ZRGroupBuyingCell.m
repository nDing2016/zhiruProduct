//
//  ZRGroupBuyingCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingCell.h"

@interface ZRGroupBuyingCell ()
@property (weak, nonatomic) IBOutlet UIImageView *GroupImg;
@property (weak, nonatomic) IBOutlet UILabel *GroupTitle;
@property (weak, nonatomic) IBOutlet UILabel *regionName;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *soldNum;  //已售 200

@end

@implementation ZRGroupBuyingCell


-(void)setModel:(ZRGroupModel *)model{
    _model = model;
    
    NSURL * url = [NSURL URLWithString:model.groupImg];
    [_GroupImg sd_setImageWithURL:url placeholderImage:ZRPlaceholderImage];
    
    _GroupTitle.text = model.groupName;
    
    _regionName.text = model.regionName;
    
    _nowPrice.text = [NSString stringWithFormat:@"$%@",model.nowPrice];
    
    _distance.text = model.distance;
    
    _soldNum.text = [NSString stringWithFormat:@"已售 %@",model.soldNum];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

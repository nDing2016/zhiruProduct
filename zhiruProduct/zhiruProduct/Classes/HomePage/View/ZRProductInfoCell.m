//
//  ZRProductInfoCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProductInfoCell.h"

@interface ZRProductInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *businessImg;
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet UIImageView *businessGrade;
@property (weak, nonatomic) IBOutlet UILabel *comment_count;
@property (weak, nonatomic) IBOutlet UILabel *didian;
@property (weak, nonatomic) IBOutlet UILabel *leixing;
@property (weak, nonatomic) IBOutlet UILabel *weizhi;

@end

@implementation ZRProductInfoCell

- (void)setModel:(ZRBusinessDetailsModel *)model{
    _model = model;
    
    NSURL * url = [NSURL URLWithString:model.head_url];
    [_businessImg sd_setImageWithURL:url placeholderImage:ZRPlaceholderImage];
    
    _businessName.text = model.name;
    
    _businessGrade.image = [UIImage imageWithPingfenCount:[model.grade integerValue]];
    
    _comment_count.text =[NSString stringWithFormat:@"%@条评论", model.comment_count];
    
    _leixing.text = model.navName[0][@"nav_name"];
    
    _weizhi.text = _regionName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

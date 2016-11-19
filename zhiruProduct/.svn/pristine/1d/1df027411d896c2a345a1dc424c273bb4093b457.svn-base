//
//  ZRBDTuanGouCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBDTuanGouCell.h"

@interface ZRBDTuanGouCell ()
@property (weak, nonatomic) IBOutlet UIImageView *tuanImg;
@property (weak, nonatomic) IBOutlet UILabel *tuanName;
@property (weak, nonatomic) IBOutlet UILabel *tuanPrice;

@end

@implementation ZRBDTuanGouCell

-(void)setModel:(ZRGroup_listModel *)model{
    _model = model;
    
    _tuanName.text = model.group_name;
    
    _tuanPrice.text = model.group_price;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ZROrderSelectTwoCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderSelectTwoCell.h"

@interface ZROrderSelectTwoCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *SubtitleText;

@end

@implementation ZROrderSelectTwoCell

-(void)setWeightMoney:(NSString *)weightMoney{
    _weightMoney = weightMoney;
    
    if (_isSpecialWeather) {

        _titleText.text = [NSString stringWithFormat:@"重量费(总重约:%.2lf kg)",_allWeight];
         _SubtitleText.text = [NSString stringWithFormat:@"$%@",weightMoney];
    }else{

        _titleText.text = [NSString stringWithFormat:@"重量费(总重约:%.2lf kg)",_allWeight];
         _SubtitleText.text = [NSString stringWithFormat:@"$%@",weightMoney];
    }
    
    _SubtitleText.textColor = [UIColor redColor];
}



- (void)setTitleDict:(NSDictionary *)titleDict{
    _titleDict = titleDict;
    
    NSArray * key = titleDict.allKeys;
    _titleText.text = key[0];
    
    _SubtitleText.text = titleDict[key[0]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

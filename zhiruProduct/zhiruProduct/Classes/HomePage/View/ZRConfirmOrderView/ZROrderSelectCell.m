//
//  ZROrderSelectCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderSelectCell.h"

@interface ZROrderSelectCell ()

@property (weak, nonatomic) IBOutlet UILabel *Title;


@end

@implementation ZROrderSelectCell

-(void)setTitleText:(NSString *)TitleText{
    _TitleText = TitleText;
     self.Title.text = self.TitleText;
}
-(void)setIsSelect:(NSString *)isSelect{
    _isSelect = isSelect;
    
   
    
    //加判断,tag 0 是 到点自取, 1是 外卖配送
    if ([self.TitleText isEqualToString:@"到店自取"]) {
        _isSelectBtn.tag = 0;
    }else if([self.TitleText isEqualToString:@"外卖配送"]){
        _isSelectBtn.tag = 1;
    }else if([self.TitleText isEqualToString:@"在线支付"]){
        _isSelectBtn.tag = 2;
    }else{
        _isSelectBtn.tag = 3;
    }
    
    if ([isSelect isEqualToString:@"1"]) {
        _isSelectBtn.selected = YES;
    }
    else{
        _isSelectBtn.selected = NO;
    }
}


- (IBAction)isSelectClick:(id)sender {
    
    if (_isChange == YES) {
        return;
    }
    
    //点击选择按钮
    UIButton * btn = sender;
    if (btn.selected == YES) {
        _isSelectBtn.selected = NO;
        _isSelect = @"0";
    }else{
        _isSelectBtn.selected = YES;
        _isSelect = @"1";
        
        if (_isSelectClick) {
            _isSelectClick(_isSelectBtn);
        }
        
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

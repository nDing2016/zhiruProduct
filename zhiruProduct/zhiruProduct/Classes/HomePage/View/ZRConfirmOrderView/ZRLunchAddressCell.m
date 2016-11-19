//
//  ZRLunchAddressCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/10/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLunchAddressCell.h"

@interface ZRLunchAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *lunchAddress;


@end

@implementation ZRLunchAddressCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)isSelectClick:(id)sender {
    if (_isSelectBtn.selected == NO) {
        if (_selectBtnClick) {
            _selectBtnClick(_isSelectBtn);
        }
    }
}

- (void)setOrderingModel:(ZROrderingBusinessMsgModel *)orderingModel{
    _orderingModel = orderingModel  ;

//    if ([_count isEqualToString:@"1"]) {
//        _isSelectBtn.tag = 1;
//        _lunchAddress.text = orderingModel.;
//    }else{
//        _isSelectBtn.tag = 2;
//        _lunchAddress.text = orderingModel.address2;
//    }
//
    _lunchAddress.text = _addressModel.address;
    _isSelectBtn.tag = [_count integerValue];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

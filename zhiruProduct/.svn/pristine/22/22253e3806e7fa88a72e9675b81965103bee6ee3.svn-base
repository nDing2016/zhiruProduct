//
//  ZROrderAddressCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderAddressCell.h"

@interface ZROrderAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userSex;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *userAddress;

@end

@implementation ZROrderAddressCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setAddressModel:(ZRUserFindAddressModel *)addressModel{
    _addressModel = addressModel;
    
    if (addressModel == nil) {
        _userName.hidden = YES;
        _userSex.hidden = YES;
        _userPhone.hidden = YES;
        _userAddress.hidden = YES;
        
        UILabel * lab = [UILabel new];
        lab.text = @"请点击添加地址";
        lab.font = [UIFont systemFontOfSize:15];
        [self addSubview:lab];
        WS(ws)
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.mas_centerX);
            make.centerY.equalTo(ws.mas_centerY);
        }];
        
    }else{
        _userName.text = addressModel.name;
        
        if ([addressModel.gender isEqualToString:@"0"]) {
            //nan
            _userSex.text  =  @"先生";
        }else{
            //nv
            _userSex.text = @"女士";
        }
        
        _userPhone.text = addressModel.phone;
        
        _userAddress.text = addressModel.address;
    }
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

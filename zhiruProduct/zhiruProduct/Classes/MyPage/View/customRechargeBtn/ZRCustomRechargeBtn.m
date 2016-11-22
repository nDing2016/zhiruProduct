//
//  ZRCustomRechargeBtn.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRCustomRechargeBtn.h"

@implementation ZRCustomRechargeBtn

-(instancetype)initWithFrame:(CGRect)frame andOriginalPrice :(NSString *)originalPrice andPresentPrice :(NSString *)presentPrice{
    self = [super initWithFrame:frame];
    if (self) {
        _price = presentPrice;
        [self createCustomLabel:originalPrice andPresentPrice:presentPrice];
    }
    return self;
}


#pragma mark - 创建价格label
- (void)createCustomLabel:(NSString *)originalPrice andPresentPrice :(NSString *)presentPrice{
    
    UILabel * originalP = [UILabel new];
    
    originalP.text = [NSString stringWithFormat:@"$%@",originalPrice];
    originalP.font = [UIFont systemFontOfSize:15];
    originalP.textColor = [ UIColor redColor];
    
    UILabel * presentP = [UILabel new];
    
    presentP.text = [NSString stringWithFormat:@"现价: $%@",presentPrice];
    presentP.font = [UIFont systemFontOfSize:14];
    presentP.textColor = [ UIColor blackColor];
    
    [self addSubview:originalP];
    [self addSubview:presentP];
    
    WS(ws)
    [originalP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.mas_centerX);
        make.top.equalTo(ws.mas_top).offset(10);
    }];
    
    [presentP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.mas_centerX);
        make.top.equalTo(originalP.mas_bottom).offset(20);
    }];
    
}
@end

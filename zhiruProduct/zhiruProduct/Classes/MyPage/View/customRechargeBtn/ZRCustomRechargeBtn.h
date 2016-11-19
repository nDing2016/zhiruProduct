//
//  ZRCustomRechargeBtn.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRCustomRechargeBtn : UIButton

@property (nonatomic,copy)NSString * price;

-(instancetype)initWithFrame:(CGRect)frame andOriginalPrice :(NSString *)originalPrice andPresentPrice :(NSString *)presentPrice;

@end

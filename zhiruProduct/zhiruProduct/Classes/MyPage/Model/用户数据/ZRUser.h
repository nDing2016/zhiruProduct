//
//  ZRUser.h
//  zhiruProduct
//
//  Created by nanding on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRUser : NSObject<NSCoding>
//用户登录唯一标识
@property (nonatomic, copy) NSString *token;

//账号的有效期
//@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString * failure_time;

//过期时间 = 当前保存时间+有效期
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
//手机
@property (nonatomic, copy) NSString *phone;

//头像地址
@property (nonatomic, copy) NSString *head_url;

//生日
@property (nonatomic, copy) NSString *birthday;

//性别
@property (nonatomic, copy) NSString *gender;

//1 普通vip 2高级vip
@property (nonatomic, copy) NSString *is_vip;

//家乡
@property (nonatomic, copy) NSString *hometown;

// 默认地址

//@property (nonatomic, copy) NSString *

// 积分
@property (nonatomic, copy) NSString *points;


+ (instancetype)userWithDict:(NSDictionary *)dict;

@end

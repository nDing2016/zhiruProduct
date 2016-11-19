//
//  ZRUser.m
//  zhiruProduct
//
//  Created by nanding on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUser.h"


#define kUserToken            @"kUserToken"
#define kUserName             @"kUserName"
#define kUserPhone            @"kUserPhone"
#define kUserHeadUrl          @"kUserHeadUrl"
#define kUserBirthday         @"kUserBirthday"
#define kUserGender           @"kUserGender"
#define kUserIsVip            @"kUserIsVip"
#define kUserHomeTown         @"kUserHomeTown"

#define kExpires_in           @"kExpires_in"
#define kExpires_date         @"kExpires_date"


@implementation ZRUser

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    ZRUser *user = [ZRUser mj_objectWithKeyValues:dict];
    return user;
}


//- (void)setExpires_in:(NSString *)expires_in
//{
//    _expires_in = expires_in;
//    
//    // 计算过期的时间 = 当前时间 + 有效期
//    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
//}
- (void)setFailure_time:(NSString *)failure_time
{
    _failure_time = failure_time;
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[_failure_time longLongValue]];
}

// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_token forKey:kUserToken];
    [aCoder encodeObject:_failure_time forKey:kExpires_in];
    [aCoder encodeObject:_expires_date forKey:kExpires_date];
    [aCoder encodeObject:_name forKey:kUserName];
    [aCoder encodeObject:_phone forKey:kUserPhone];
    [aCoder encodeObject:_head_url forKey:kUserHeadUrl];
    [aCoder encodeObject:_birthday forKey:kUserBirthday];
    [aCoder encodeObject:_gender forKey:kUserGender];
    [aCoder encodeObject:_is_vip forKey:kUserIsVip];
    [aCoder encodeObject:_hometown forKey:kUserHomeTown];
}

// 解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {        
        // 一定要记得赋值

        _token = [aDecoder decodeObjectForKey:kUserToken];
        _failure_time = [aDecoder decodeObjectForKey:kExpires_in];
        _expires_date = [aDecoder decodeObjectForKey:kExpires_date];
        _name = [aDecoder decodeObjectForKey:kUserName];
        _phone =[aDecoder decodeObjectForKey:kUserPhone];
        _head_url = [aDecoder decodeObjectForKey:kUserHeadUrl];
        _birthday =[aDecoder decodeObjectForKey:kUserBirthday];
        _gender = [aDecoder decodeObjectForKey:kUserGender];
        _is_vip = [aDecoder decodeObjectForKey:kUserIsVip];
        _hometown = [aDecoder decodeObjectForKey:kUserHomeTown];

        _token = [aDecoder decodeObjectForKey:kUserToken];
//        [aDecoder decodeObjectForKey:kExpires_in];
//        [aDecoder decodeObjectForKey:kExpires_date];
        _name = [aDecoder decodeObjectForKey:kUserName];
        _phone = [aDecoder decodeObjectForKey:kUserPhone];
//        [aDecoder decodeObjectForKey:kUserHeadUrl];
//        [aDecoder decodeObjectForKey:kUserBirthday];
//        [aDecoder decodeObjectForKey:kUserGender];
//        [aDecoder decodeObjectForKey:kUserIsVip];
//        [aDecoder decodeObjectForKey:kUserHomeTown];

    }
    return self;
}



@end

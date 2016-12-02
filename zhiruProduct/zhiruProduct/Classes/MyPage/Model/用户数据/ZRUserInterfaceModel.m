//
//  ZRUserInterfaceModel.m
//  zhiruProduct
//
//  Created by nanding on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUserInterfaceModel.h"
#import "ZRUserFindAddressModel.h"
#import "ZRMessageModel.h"
@implementation ZRUserInterfaceModel

/**
 *  注册接口
 *
 *  @param password 密码
 *  @param phone    电话
 *  @param vCode    验证码
 *  @param callback 成功回调
 *
 */
+ (void)registWithPassword:(NSString *)password
                     Phone:(NSString *)phone
                     VCode:(NSString *)vCode
            RegisterCallBack:(RegisterCallBack)callBack
{
    NSString * urlStr = [HOST stringByAppendingString:@"user/register"];
    NSDictionary * param = @{@"password":password,@"phone":phone,@"VCode":vCode};
    __block NSString *str;
    [ZRAFNRequests post:urlStr parameters:param success:^(id result) {
        NSDictionary *dic = result;
        str = [dic objectForKey:@"message"];
        if (callBack) {
            callBack(str);
        }
    } failure:^(id error) {
        
        
    }];
}

/**
 *  登录接口
 *
 *  @param password 密码
 *  @param userName 账号
 *  @param registrationId    极光绑定设备码
 *  @param callback 成功回调
 */
+(void)loginWithPassword:(NSString *)password
                UserName:(NSString *)userName
          RegistrationId:(NSString *)registrationId
           LoginCallBack:(LoginCallBack)callback
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:password forKey:@"password"];
    [paramDic setObject:userName forKey:@"phone"];
    [paramDic setObject:registrationId forKey:@"registrationId"];
//    [paramDic setObject:vcode forKey:@"vCode"];
    NSString * urlStr = [HOST stringByAppendingString:@"login/login"];
    __block NSString *str;
    [ZRAFNRequests post:urlStr parameters:paramDic success:^(id result) {
//        NSLog(@"----%@----", result);
//        NSLog(@"当前线程1: %@", [NSThread currentThread]);
        NSDictionary *dic = result;
        str = [dic objectForKey:@"message"];
        id data = [dic objectForKey:@"data"];
        if (callback) {
            callback(str,data);
        }
        
    } failure:^(id error) {
        
        
    }];
    
    
}
/**
 * 通过手机获取验证码-徐迪
 *
 * @param phone      手机号
 * @param areaPhone  国家区号
 * @param codeStyle  0: 注册, 1: 修改 2: 修改手机号
 * @param callBack   成功
 * @param failure    失败
 */
+ (void)getNewPhoneVCodePhone:(NSString *)phone
                    AreaPhone:(NSString *)areaPhone
                    CodeStyle:(NSString *)codeStyle
                     CallBack:(void(^)(NSString * message))callBack
                      Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:@"user/sendMessage"];
    NSDictionary * param = @{@"phone":phone,@"areaPhone":areaPhone,@"codeStyle":codeStyle};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dict = result;
        NSString * state = [dict objectForKey:@"message"];
        callBack(state);
    } failure:^(id error) {
        callBack(error);
    }];
}
/**
 *  校验验证码
 *
 *  @param phone 手机号
 *  @param vCode 验证码
 */
+ (void)judgeVCodePhone:(NSString *)phone
                  VCode:(NSString *)vCode
          JudgeCallBack:(JudgeCallBack)callback
{
    NSMutableDictionary * paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:phone forKey:@"phone"];
    [paraDic setObject:vCode forKey:@"vCode"];
    NSString * urlStr = [HOST stringByAppendingString:@"user/checkvCode"];
    [ZRAFNRequests post:urlStr parameters:paraDic success:^(id result) {
        NSDictionary * dic = result;
        callback(dic);
        
    } failure:^(id error) {
        
        callback(error);
    }];
}


/**
 *  修改密码
 *
 *  @param oldPassword    旧密码
 *  @param latestPassword 新密码
 *
 *  @return 返回状态信息
 */
+(NSString *)updatePasswordWithOldPassword:(NSString *)oldPassword
                            LatestPassword:(NSString *)latestPassword
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:oldPassword forKey:@"oldPwd"];
    [paramDic setObject:latestPassword forKey:@"newPwd"];
    NSString * urlStr = [HOST stringByAppendingString:@"user/updatePsw"];
    __block NSString *str;
    [ZRAFNRequests post:urlStr parameters:paramDic success:^(id result) {
        
        NSDictionary *dic = result;
        str = [dic objectForKey:@"message"];
        
        
    } failure:^(id error) {
        
    }];
    return str;
}


/**
 *  找回密码
 *
 *  @param phone     手机号
 *  @param latestPwd 新密码
 *  @param callBack  成功
 *  @param failure   失败
 *
 *  @return 返回状态信息
 */
+ (void)retrievePswWithPhone:(NSString *)phone
                 NewPassword:(NSString *)password
                    CallBack:(void(^)(NSString * message))callBack
                     Failure:(void(^)(id error))failure
{
    NSString * urlStr = [HOST stringByAppendingString:@"user/retrievePsw"];
    NSDictionary * param = @{@"phone":phone,@"password":password};
    [ZRAFNRequests post:urlStr parameters:param success:^(id result) {
        NSDictionary * dict = result;
        NSString * message = [dict objectForKey:@"message"];
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}

/**
 *  更改用户信息
 *
 *  @param name           昵称
 *  @param gender         性别
 *  @param birthday       生日
 *  @param hometown       家乡
 *  @param receiptAddress 默认收货地址
 *
 *  @return 返回状态信息
 */
+ (void)updateUserInfoWithName:(NSString *)name
                        Gender:(NSString *)gender
                      Birthday:(NSString *)birthday
                      HomeTown:(NSString *)hometown
                          File:(NSArray *)file
                      CallBack:(void (^)(NSString * message, NSDictionary * userData))callBack
                       Failure:(void (^)(id error))failure
{
    NSString * urlStr = [HOST stringByAppendingString:@"user/update"];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    if (name.length != 0) {
        [paramDic setObject:name forKey:@"name"];
    }
    if (gender.length != 0) {
        [paramDic setObject:gender forKey:@"gender"];
    }
    if (birthday.length != 0) {
        [paramDic setObject:birthday forKey:@"birthday"];
    }
    if (hometown.length != 0) {
        [paramDic setObject:hometown forKey:@"hometown"];
    }
//    NSLog(@"%@", paramDic);
    [ZRAFNRequests post:urlStr parameters:paramDic imageFile:file fileKey:@"headImg" success:^(id result) {
//        NSLog(@"pj ==%@", result);
        NSDictionary * dic = result;
        NSString * messgae = [dic objectForKey:@"message"];
        NSDictionary * data = [dic objectForKey:@"data"];
        callBack(messgae, data);
    } failure:^(NSError *error) {
        failure(error);
//        NSLog(@"%@", error);
    }];
}


/**
 *  检测用户昵称接口
 *
 *  @param name 昵称
 *
 *  @return 返回状态信息
 */
+(NSString *)checkNameWithName:(NSString *)name
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:name forKey:@"name"];
   NSString * urlStr = [HOST stringByAppendingString:@"user/checkName"];
    __block NSString *str;
    [ZRAFNRequests post:urlStr parameters:paramDic success:^(id result) {
        
        NSDictionary *dic = result;
        str = [dic objectForKey:@"message"];
        
        
    } failure:^(id error) {
        
    }];
    return str;
}

/**
 *  查询收获地址接口
 *
 */
+ (void)getUserAddressCallBack:(UserAddressCallBack)callBack
{
    NSString *urlStr = [HOST stringByAppendingString:@"user/findReceiptAddress"];
    [ZRAFNRequests post:urlStr parameters:nil success:^(id result) {
        NSDictionary * dic = result;
        NSString *str = [dic objectForKey:@"message"];
        NSArray * array = [dic objectForKey:@"data"];
        callBack(array,str,[dic objectForKey:@"code"]);
    } failure:^(id error) {
        
        
    }];
}

/**
 *  新增收货地址
 *
 *  @param name      联系人
 *  @param phone     电话
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param address   详细地址
 *  @param gender    性别0男1女
 *
 *  @return 返回状态信息
 */
+ (void)addReceiptAddressWithName:(NSString *)name
                            Phone:(NSString *)phone
                        Longitude:(NSString *)longitude
                         Latitude:(NSString *)latitude
                          Address:(NSString *)address
                           Gender:(NSString *)gender
           UserNewAddressCallBack:(NewAddressCallBack)callBack
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:name forKey:@"name"];
    [paramDic setObject:phone forKey:@"phone"];
    [paramDic setObject:longitude forKey:@"longitude"];
    [paramDic setObject:latitude forKey:@"latitude"];
    [paramDic setObject:address forKey:@"address"];
    [paramDic setObject:gender forKey:@"gender"];
    NSString * urlStr = [HOST stringByAppendingString:@"user/addReceiptAddress"];
    [ZRAFNRequests post:urlStr parameters:paramDic success:^(id result) {
        NSDictionary * dic = result;
        NSString * str = [dic objectForKey:@"message"];
        callBack(str);
        
    } failure:^(id error) {
        
        
    }];
    
}





///**
// *  修改收货地址
// *
// *  @param name      联系人
// *  @param phone     电话
// *  @param longitude 经度
// *  @param latitude  纬度
// *  @param address   详细地址
// *  @param gender    性别0男1女
// *
// *  @return 返回状态信息
// */

+ (void)updateReceiptAddressWithID:(NSString *)ID
                              Name:(NSString *)name
                             Phone:(NSString *)phone
                         Longitude:(NSString *)longitude
                          Latitude:(NSString *)latitude
                           Address:(NSString *)address
                            Gender:(NSString *)gender
                         Isdefault:(NSString *)isdefault
         UserUpdateAddressCallBack:(UpdateAddressCallBack)callBack
{
    NSMutableDictionary * paraDic = [NSMutableDictionary dictionary];
    [paraDic setObject:ID forKey:@"id"];
    [paraDic setObject:name forKey:@"name"];
    [paraDic setObject:phone forKey:@"phone"];
    [paraDic setObject:longitude forKey:@"longitude"];
    [paraDic setObject:latitude forKey:@"latitude"];
    [paraDic setObject:address forKey:@"address"];
    [paraDic setObject:gender forKey:@"gender"];
    [paraDic setObject:isdefault forKey:@"isdefault"];
    
    NSString * urlStr = [HOST stringByAppendingString:@"user/updateReceiptAddress"];
    
    [ZRAFNRequests post:urlStr parameters:paraDic success:^(id result) {
       
        NSDictionary * dic = result;
        NSString * str = [dic objectForKey:@"message"];
        callBack(str);
        
    } failure:^(id error) {
        
        
    }];
}
/**
 *  修改收货地址
 *
 *  @param name      联系人
 *  @param phone     电话
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param address   详细地址
 *  @param gender    性别0男1女
 *
 *  @return 返回状态信息
 */
+(NSString *)updateReceiptAddressWithName:(NSString *)name
                                    Phone:(NSString *)phone
                                Longitude:(NSString *)longitude
                                 Latitude:(NSString *)latitude
                                  Address:(NSString *)address
                                   Gender:(NSString *)gender
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:name forKey:@"name"];
    [paramDic setObject:phone forKey:@"phone"];
    [paramDic setObject:longitude forKey:@"longitude"];
    [paramDic setObject:latitude forKey:@"latitude"];
    [paramDic setObject:address forKey:@"address"];
    [paramDic setObject:gender forKey:@"gender"];
    NSString * urlStr = [HOST stringByAppendingString:@"receiptAddress/update"];
    __block NSString *str;
    [ZRAFNRequests post:urlStr parameters:paramDic success:^(id result) {
        
        NSDictionary *dic = result;
        str = [dic objectForKey:@"message"];
        
        
    } failure:^(id error) {
        
    }];
    return str;
}
/**
 * 删除收获地址
 * @param id  收货地址id
 * @param callBack 成功
 * @param failure  失败
 */
+ (void)delReceiptAddressWithId:(NSString *)Id
                       CallBack:(void (^)(NSString * message))callBack
                        Failure:(void (^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:@"user/delReceiptAddress"];
    NSDictionary * param = @{@"id":Id};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dict = result;
        NSString * message = [dict objectForKey:@"message"];
        callBack(message);
        
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 更改绑定手机
 * @param phone    手机号码
 * @param vCode    验证码
 * @param callBack 成功
 * @param failure  失败
 */
+ (void)updatePhoneWithPhone:(NSString *)phone
                       VCode:(NSString *)vCode
                    CallBack:(void(^)(NSString * message))callBack
                     Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:@"user/updatePhone"];
    NSDictionary * param = @{@"phone":phone,@"vCode":vCode};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dict = result;
        NSString * message = [dict objectForKey:@"message"];
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 退出登录
 */
+ (void)exitUserLoginCallBack:(ExitLogin)callBack
{
    NSString * urlStr = [HOST stringByAppendingString:@"login/logout"];
    __block NSString * str;
    [ZRAFNRequests post:urlStr parameters:nil success:^(id result) {
        NSDictionary * dic = result;
        str = [dic objectForKey:@"message"];
        callBack(str);
    } failure:^(id error) {
        
    }];
}
/**
 * 修改密码
 * @param oldPwd    旧密码
 * @param newPwd    新密码
 * @param callBack
 * @param failure
 */
+ (void)updatePswWithOldPwd:(NSString *)oldPwd
                     NewPwd:(NSString *)newPwd
                   CallBack:(void(^)(NSString * message))callBack
                    failure:(void(^)(id error))failure
{
    NSString * urlStr = [HOST stringByAppendingString:@"user/updatePsw"];
    NSDictionary * param = @{@"oldPwd":oldPwd,@"newPwd":newPwd};
    [ZRAFNRequests post:urlStr parameters:param success:^(id result) {
//        NSLog(@"%@", result);
        NSDictionary * dict = result;
        callBack([dict objectForKey:@"message"]);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 用户默认收货地址
 * @param callBack  成功
 * @param failure   失败
 */
+ (void)userFineDefaultAddressCallBack:(void(^)(id result))callBack
                                Filure:(void(^)(id error))failure
{//用户未登录
    NSString * url = [HOST stringByAppendingString:@"user/findDefaultAddress"];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
        
        if ([result[@"code"] isEqualToString:@"S000"]) {
            NSDictionary * data = result[@"data"];
            ZRUserFindAddressModel * model = [ZRUserFindAddressModel mj_objectWithKeyValues:data];
            callBack(model);
        }else{
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
           
            failure(@"error");
        }
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 验证token接口
 * @param callBack 成功
 * @param failure  失败
 */
+ (void)checkTokenCallBack:(void(^)(id result))callBack
                   Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:@"login/checkToken"];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
        NSString * tokenMessage = result;
        callBack(tokenMessage);
    } failure:^(id error) {
        callBack(error);
    }];
}
/**
 * 用户消息(小信封)新消息数量接口
 * @param callBack 成功
 * @param failure  失败
 */
+ (void)userGetMessageNumCallBack:(void(^)(id result))callBack
                          Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:@"user/getMessageNum"];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
        callBack(result);
    } failure:^(id error) {
        failure(error);
    }];
}

/**
 * 用户消息(小信封)接口
 * @param callBack 成功
 * @param failure  失败
 */
+ (void)userMessageListCallBack:(void(^)(id result))callBack
                        Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:@"user/userMesssage"];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
        NSDictionary * dict = result;
        NSLog(@"信封列表: %@", dict);
        NSMutableArray * array = [NSMutableArray array];
        for (NSDictionary * dataDic in dict[@"data"]) {
            ZRMessageModel * model = [ZRMessageModel mj_objectWithKeyValues:dataDic];
            [array addObject:model];
        }
        callBack(array);
//        callBack(dict[@"data"]);
    } failure:^(id error) {
        failure(error);
    }];
}
@end

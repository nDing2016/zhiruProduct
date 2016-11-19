//
//  ZRUserTool.m
//  zhiruProduct
//
//  Created by nanding on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUserTool.h"
#import "ZRUser.h"


#define kUserFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"ZRZR.txt"]

//#define kUserFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"ZRUser.txt"]


static  ZRUser*usr;
@implementation ZRUserTool

/**
 *  保存数据
 *
 *  @param user 用户信息
 */
+ (BOOL)saveAccount:(ZRUser *)user
{
   BOOL state = [NSKeyedArchiver archiveRootObject:user toFile:kUserFileName];
   return state;
}

+ (ZRUser *)user
{

//    if (usr == nil) {
    
//        usr = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserFileName];
//
//    
//    if (usr == nil) {

        

        usr = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserFileName];
        

        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        //【NSDate date】获取当前日期
        if ([[NSDate date] compare:usr.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }

//    }
    return usr;

        
//    }
    
    
//    return usr;


  
    
}


@end

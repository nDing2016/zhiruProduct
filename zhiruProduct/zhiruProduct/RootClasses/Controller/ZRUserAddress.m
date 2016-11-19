//
//  ZRUserAddress.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/11/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUserAddress.h"
#import "ZRMyLocation.h"
@implementation ZRUserAddress




+(id)sharedInstance
{
    //单例创建
  
    static ZRUserAddress *mm = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mm = [[self alloc]init];
    });

    return mm;
}

- (void)startLocation{
    
    
}

@end

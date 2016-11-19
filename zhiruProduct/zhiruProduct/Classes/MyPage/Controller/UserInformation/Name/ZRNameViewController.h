//
//  ZRNameViewController.h
//  zhiruProduct
//
//  Created by pj on 16/7/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"
#import "ZRRegisterView.h"

typedef enum {
    
    ZRName = 0, //  设置名字类型
    ZRIphone// 设置电话类型

}updateType;

@protocol sendNameDelegate <NSObject>

- (void)sendNameString:(NSString *)name;

@end

@interface ZRNameViewController : ZRBaseViewController


@property (nonatomic, strong)ZRRegisterView * nameView;

@property (nonatomic, strong)UIButton * okButton;

@property (nonatomic, assign)id<sendNameDelegate>delegate;

@property (nonatomic, copy)NSString * name;

@property (nonatomic , copy) void (^clickBaocun)(NSString * info);

@property (nonatomic , assign) updateType nameAndIphone;
@end

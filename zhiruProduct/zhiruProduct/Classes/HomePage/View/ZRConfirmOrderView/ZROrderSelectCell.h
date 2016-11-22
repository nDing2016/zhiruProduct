//
//  ZROrderSelectCell.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  确认订单中可选择cell

#import <UIKit/UIKit.h>

@interface ZROrderSelectCell : UITableViewCell

@property (nonatomic , copy) NSString * TitleText;
@property (nonatomic , copy) NSString * isSelect;
@property (nonatomic , assign) BOOL isChange;
@property (weak, nonatomic) IBOutlet UIButton *isSelectBtn;
@property (nonatomic , copy) void(^isSelectClick)(UIButton * btn);
@end

//
//  ZRProductSectionCell.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRProductSectionCell : UITableViewCell

@property (nonatomic , copy) NSString * title;
@property (nonatomic , assign) BOOL isHideBtnView;
@property (nonatomic , strong) NSArray * titleNumbArr;
@property (nonatomic , copy) void(^SectionClick)(NSInteger index);
@property (nonatomic , assign) NSInteger selectIndex;
@end

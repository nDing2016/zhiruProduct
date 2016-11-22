//
//  ZRBDTuanGouCell.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRGroup_listModel.h"
@interface ZRBDTuanGouCell : UITableViewCell

@property (nonatomic , strong) ZRGroup_listModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *tuangouImg;

@end

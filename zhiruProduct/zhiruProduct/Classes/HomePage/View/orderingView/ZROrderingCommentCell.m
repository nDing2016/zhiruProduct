//
//  ZROrderingCommentCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingCommentCell.h"

@interface ZROrderingCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImg; //用户头像

@property (weak, nonatomic) IBOutlet UILabel *userName;  //用户名

@property (weak, nonatomic) IBOutlet UILabel *commentTime; //评论时间

@property (weak, nonatomic) IBOutlet UIImageView *pingXing; //评星

@property (weak, nonatomic) IBOutlet UILabel *userComment; // 用户评价


@property (weak, nonatomic) IBOutlet UIView *commentImgView; //用户存放 评价照片,可没有照片,没有照片 这个view 高度为 0

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentImgHeight;// 图片View 高度


@property (weak, nonatomic) IBOutlet UILabel *userOrdering; //用户订单内容

@property (weak, nonatomic) IBOutlet UILabel *zanCount; //赞 数

@property (weak, nonatomic) IBOutlet UILabel *noZanCount; //差 数


@end


@implementation ZROrderingCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)isLikeClick:(id)sender {
    //tag 1 = 赞   2 = 差
}

@end

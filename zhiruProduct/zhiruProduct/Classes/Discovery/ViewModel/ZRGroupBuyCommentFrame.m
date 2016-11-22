//
//  ZRGroupBuyCommentFrame.m
//  zhiruProduct
//
//  Created by nanding on 16/8/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyCommentFrame.h"
#import "ZRGroupCommentListModel.h"

@implementation ZRGroupBuyCommentFrame

-(void)setCommentListModel:(ZRGroupCommentListModel *)commentListModel
{
    _commentListModel = commentListModel;
    [self setUpFrames];
    
    
}


-(void)setUpFrames
{
    //评论人头像
    CGFloat x = 15*SCREEN_WIDTH/375;
    CGFloat y = 10*SCREEN_HEIGHT/667;
    CGFloat wid = 40*SCREEN_WIDTH/375;
    _commentUserImgFrame = CGRectMake(x, y, wid, wid);
    
    //评论人
    CGSize commentUsrNameSize = [NSString getSize:_commentListModel.commentUserName strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _commentUserNameFrame = CGRectMake(CGRectGetMaxX(_commentUserImgFrame)+10, y, commentUsrNameSize.width, commentUsrNameSize.height);
    
    //星级
    UIImage *pingxingImg = [UIImage imageWithPingfenCount:[_commentListModel.commentGrade integerValue]];
    _commentGradeFrame = CGRectMake(x, CGRectGetMaxY(_commentUserNameFrame)+y, pingxingImg.size.width, pingxingImg.size.height);
    
    //人均消费
    CGSize perCapitalSize = [NSString getSize:_commentListModel.perCapita strFont:CustomFont(13) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _perCapitaFrame = CGRectMake(CGRectGetMaxX(_commentGradeFrame)+10, _commentGradeFrame.origin.y, perCapitalSize.width, perCapitalSize.height);
    
    //评论内容
    CGFloat contentWid = SCREEN_WIDTH-CGRectGetMinX(_commentUserNameFrame)-(30*SCREEN_WIDTH/375);
    CGSize commentContentSize = [NSString getSize:_commentListModel.commentContent strFont:CustomFont(13) maxSize:CGSizeMake(contentWid, SCREEN_HEIGHT)];
    _commentContentFrame = CGRectMake(CGRectGetMinX(_commentUserNameFrame), CGRectGetMaxY(_commentGradeFrame)+y, commentContentSize.width, commentContentSize.height);
    
    //评论时间
    CGSize commentDateSize = [NSString getSize:_commentListModel.commentDate strFont:CustomFont(13) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _commentDateFrame = CGRectMake(SCREEN_WIDTH-x-commentDateSize.width, y, commentDateSize.width, commentDateSize.height);
    
    
    //评论图片
    if (_commentImgArray.count>0) {
        CGFloat picX = CGRectGetMinX(_commentUserNameFrame);
        CGFloat picY = CGRectGetMaxY(_commentContentFrame)+y;
        CGSize photosSize = [self photosSizeWithCount:(int)_commentListModel.commentImg.count];
        _commentImgFrame = CGRectMake(picX, picY, photosSize.width, photosSize.height);
    }
    
    //向下大拇指数
    CGSize notGoodSize = [NSString getSize:_commentListModel.notGood strFont:CustomFont(13) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _notGoodFrame = CGRectMake(SCREEN_WIDTH-x-notGoodSize.width, CGRectGetMaxY(_commentContentFrame)+y+CGRectGetMaxY(_commentImgFrame)+y, notGoodSize.width, notGoodSize.height);
    
    _notGoodImgFrame = CGRectMake(CGRectGetMinX(_notGoodFrame)-(20*SCREEN_WIDTH/375)-5, CGRectGetMaxY(_notGoodFrame)-(20*SCREEN_WIDTH/375), (20*SCREEN_WIDTH/375), (20*SCREEN_WIDTH/375));
    
    //向上大拇指数
    _goodImgFrame = CGRectMake(260*SCREEN_WIDTH/375, CGRectGetMinY(_notGoodImgFrame), _notGoodImgFrame.size.width, _notGoodImgFrame.size.height);
    
    
    CGSize goodSize = [NSString getSize:_commentListModel.good strFont:CustomFont(13) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _goodFrame = CGRectMake(CGRectGetMaxX(_goodImgFrame)+5, CGRectGetMinY(_notGoodFrame), goodSize.width, goodSize.height);
}

#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4? 3 : 2;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 80*SCREEN_WIDTH/375;
    CGFloat w = cols * photoWH + (cols - 1) * 10;
    CGFloat h = rols * photoWH + (rols - 1) * 10;
    
    
    return CGSizeMake(w, h);
    
}



@end

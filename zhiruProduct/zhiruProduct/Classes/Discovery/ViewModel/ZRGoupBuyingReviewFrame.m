//
//  ZRGoupBuyingReviewFrame.m
//  zhiruProduct
//
//  Created by nanding on 16/7/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGoupBuyingReviewFrame.h"
#import "ZRCommentListModel.h"

@implementation ZRGoupBuyingReviewFrame

-(void)setCommentListModel:(ZRCommentListModel *)commentListModel
{
    _commentListModel = commentListModel;
    
    //计算评论内容尺寸
    [self caculateReviewTextFrame];
    
    _cellHeight = CGRectGetMaxY(_reviewGoodFrame)+15;
}


- (void)caculateReviewTextFrame
{
    //头像
    CGFloat imageX = 15*SCREEN_WIDTH/375;
    CGFloat imageY = 10*SCREEN_HEIGHT/667;
    CGFloat imageWH = 42*SCREEN_WIDTH/375;
    _reviewIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //昵称
    CGSize nameSize = [NSString getSize:_commentListModel.commentUserName strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT)];
    _reviewNameFrame = CGRectMake(imageX*2+imageWH, imageY, nameSize.width, nameSize.height);
    
    //时间
    CGSize timeSize = [NSString getSize:_commentListModel.commentDate strFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT)];
    _reviewTimeFrame = CGRectMake(SCREEN_WIDTH-imageX-timeSize.width, 20, timeSize.width, timeSize.height);
    
    //评星
    _reviewStarFrame = CGRectMake(imageX*2+imageWH, imageY*2+nameSize.height, ZRImage(@"pingxing").size.width, ZRImage(@"pingxing").size.height);
    
    //价格
    CGSize priceSize = [NSString getSize:_commentListModel.perCapita strFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT)];
    _reviewPriceFrame = CGRectMake(CGRectGetMaxX(_reviewStarFrame)+10, imageY*2+nameSize.height, priceSize.width, priceSize.height);
    
    //内容
    CGFloat textWidth = SCREEN_WIDTH-imageX-imageX*2-imageWH;
    CGSize textSize = [NSString getSize:_commentListModel.commentContent strFont:CustomFont(15) maxSize:CGSizeMake(textWidth,SCREEN_HEIGHT)];
    _reviewTextFrame = CGRectMake(imageX*2+imageWH, CGRectGetMaxY(_reviewStarFrame)+imageY, textWidth, textSize.height);
    
    //配图
    CGFloat picX = imageX*2+imageWH;
    CGFloat picY = CGRectGetMaxY(_reviewTextFrame)+imageY;
    CGFloat goodY;
    if (_commentListModel.commentImg.count>0) {
        CGSize photosSize = [self photosSizeWithCount:(int)_commentListModel.commentImg.count];
        _reviewPicFrame = CGRectMake(picX, picY, photosSize.width, photosSize.height);
        goodY = CGRectGetMaxY(_reviewPicFrame)+15;
    }else{
        goodY = CGRectGetMaxY(_reviewTextFrame)+15;
    }
    
    
    //点赞
    _reviewGoodFrame = CGRectMake(256*SCREEN_WIDTH/375, goodY, ZRImage(@"haoping").size.width, ZRImage(@"haoping").size.height);
    
    //反对点赞
    _reviewBadFrame = CGRectMake(320*SCREEN_WIDTH/375, goodY, ZRImage(@"chaping").size.width, ZRImage(@"chaping").size.height);
}


#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
//    // 获取总列数
//    int cols = count == 4? 3 : 2;
//    // 获取总行数 = (总个数 - 1) / 总列数 + 1
//    int rols = (count - 1) / cols + 1;
//    CGFloat photoWH = 80*SCREEN_WIDTH/375;
//    CGFloat w = cols * photoWH + (cols - 1) * 10;
//    CGFloat h = rols * photoWH + (rols - 1) * 10;
    
    int rols;
    if (count<=3) {
        rols = 1;
    }else if (count<=6){
        rols = 2;
    }else{
        rols = 3;
    }
    
    CGFloat photoWH = 80*SCREEN_WIDTH/375;
    //缝隙
    CGFloat mix = 10*SCREEN_WIDTH/375;
    CGFloat w = photoWH*3+mix*2;
    CGFloat h = photoWH*rols+mix*(rols-1);
    
    return CGSizeMake(w, h);
    
}



@end

//
//  ZRGroupBuyingReviewDetailsCell.m
//  zhiruProduct
//
//  Created by nanding on 16/7/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingReviewDetailsCell.h"
#import "ZRCommentListModel.h"

#import "ZRHomePageRequst.h"

@interface ZRGroupBuyingReviewDetailsCell ()

@property (nonatomic, strong) NSIndexPath *idxPath;

@property (nonatomic, strong) UIButton *goodBtn;

@property (nonatomic, strong) UIButton *badBtn;

@property (nonatomic, strong) UILabel *goodLabel;
@property (nonatomic, strong) UILabel *badLabel;

@property (nonatomic , strong) UIButton * dianzanBtn;


@property (nonatomic, strong) UILabel *reviewTextLabel;

@end

@implementation ZRGroupBuyingReviewDetailsCell

//-(void)setReviewFrame:(ZRGoupBuyingReviewFrame *)reviewFrame
//{
//    _reviewFrame = reviewFrame;
//    [self setNeedsDisplay];
//}


-(void)setCommentListModel:(ZRCommentListModel *)commentListModel
{
    _commentListModel = commentListModel;

    
    [self setNeedsDisplay];
}

#pragma mark - init
+(instancetype)cellWithTableView:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    ZRGroupBuyingReviewDetailsCell *cell = [table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ZRGroupBuyingReviewDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.idxPath = idxPath;

    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
}


#pragma mark - Private methods
//-(UIButton *)goodBtn
//{
//    CGFloat x = 250*SCREEN_WIDTH/375;
//    NSLog(@"=index=%ld,heght=%f,ZRImage=%f,y=%f",(long)self.idxPath.row,self.height,ZRImage(@"haoping").size.height,self.height-15-ZRImage(@"haoping").size.height);
//    CGFloat y = self.height-ZRImage(@"haoping").size.height;
//    NSLog(@"index=%ld,y=%f",(long)self.idxPath.row,y);
//    if (!_goodBtn) {
//        _goodBtn = [MyControl createButtonWithFrame:CGRectMake(x, y, ZRImage(@"haoping").size.width, ZRImage(@"haoping").size.height) ImageName:nil Target:self Action:@selector(goodReviewClick:) Title:nil];
//        _goodBtn.tag = 0;
//    
//    }
//    
//      return _goodBtn;
//}
//
//
//-(UIButton *)badBtn
//{
//    CGFloat x = 305*SCREEN_WIDTH/375;
//    CGFloat y = self.height-ZRImage(@"chaping").size.height;
//    if (!_badBtn) {
//        _badBtn = [MyControl createButtonWithFrame:CGRectMake(x, y, ZRImage(@"chaping").size.width, ZRImage(@"chaping").size.height) ImageName:nil Target:self Action:@selector(goodReviewClick:) Title:nil];
//        _badBtn.tag = 1;
//        
//        
//
//
//    }
//    return _badBtn;
//}
//


- (void)setUpAllChildviews
{
    CGFloat x1 = 250*SCREEN_WIDTH/375;
    CGFloat y = self.height-15-ZRImage(@"haoping").size.height;
    CGFloat x2 = 305*SCREEN_WIDTH/375;
    
    
    //点赞
    self.goodBtn = [MyControl createButtonWithFrame:CGRectMake(x1, y, ZRImage(@"haoping").size.width, ZRImage(@"haoping").size.height) ImageName:nil Target:self Action:@selector(goodReviewClick:) Title:nil];
    self.goodBtn.tag = 0;
    [self.contentView addSubview:self.goodBtn];
    
    
    //反对
    self.badBtn = [MyControl createButtonWithFrame:CGRectMake(x2, y, ZRImage(@"chaping").size.width, ZRImage(@"chaping").size.height) ImageName:nil Target:self Action:@selector(goodReviewClick:) Title:nil];
    self.badBtn.tag = 1;
    [self.contentView addSubview:self.badBtn];
    
    
}



#pragma mark - click methods
- (void)goodReviewClick:(UIButton *)sender
{
    
    if (sender.tag == 0) {
       //点赞按钮
        if ([_commentListModel.isClick isEqualToString:@"1"]) {
            //[self.goodBtn setImage:ZRImage(@"haoping") forState:UIControlStateNormal];
            _clickGoodBtn(sender,_commentListModel.commentId, YES);
        }else{
            //[self.goodBtn setImage:ZRImage(@"zan_hong") forState:UIControlStateNormal];
          
                
                if ([_commentListModel.isClick isEqualToString:@"2"]) {
                    //_clickGoodBtn(self.badBtn,_commentListModel.commentId, YES);
                    [self cancelBtn:_commentListModel.commentId WithBtn:sender];
                    
                    
                }else{
                   _clickGoodBtn(sender,_commentListModel.commentId, NO);
                }
                
                
            
            //
            
        }
        
    }else{
       //点反对赞按钮
        if ([_commentListModel.isClick isEqualToString:@"2"]) {
            //[self.goodBtn setImage:ZRImage(@"chaping") forState:UIControlStateNormal];
            _clickGoodBtn(sender,_commentListModel.commentId, YES);
        }else{
            //[self.goodBtn setImage:ZRImage(@"cha_hong") forState:UIControlStateNormal];
            if ([_commentListModel.isClick isEqualToString:@"1"]) {
                //_clickGoodBtn(self.goodBtn,_commentListModel.commentId, YES);
                [self cancelBtn:_commentListModel.commentId WithBtn:sender];
            }else{
                _clickGoodBtn(sender,_commentListModel.commentId, NO);
            }
           
            
        }

    }
    
}



- (void)cancelBtn:(NSString *)commentId WithBtn:(UIButton *)btn{
    [SVProgressHUD show];

    [ZRHomePageRequst requestDeleteAgreeWithCommentId:commentId andSuccess:^(id success) {
        [SVProgressHUD dismiss];
        
        _clickGoodBtn(btn,_commentListModel.commentId, NO);
        
    } andFailure:^(id error) {
        //        [SVProgressHUD showErrorWithStatus:@"取消失败"];
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - drawRect
-(void)drawRect:(CGRect)rect
{
    if (self.idxPath.section == 1) {
        //头像
        //UIImage *headImg = [UIImage getImageFromURL:_commentListModel.commentUserImg];
        //CGFloat width = headImg.size.width*SCREEN_WIDTH/375;
        //[self drawImage:headImg Rect:self.reviewFrame.reviewIconFrame];
        //CGFloat x = 15+15+width;
        CGFloat imageX = 15*SCREEN_WIDTH/375;
        CGFloat imageY = 10*SCREEN_HEIGHT/667;
        CGFloat imageWH = 42*SCREEN_WIDTH/375;
        
        //name
        CGSize nameSize = [self drawWithStr:_commentListModel.commentUserName Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.reviewNameFrame.origin.x, self.reviewFrame.reviewNameFrame.origin.y)];
        
        //评星
        UIImage *pingxingImg = [UIImage imageWithPingfenCount:[_commentListModel.commentGrade integerValue]];
        [self drawImage:pingxingImg Rect:self.reviewFrame.reviewStarFrame];
        
        //价钱
        NSString *per = [NSString stringWithFormat:@"$%@/人",_commentListModel.perCapita];
        CGSize priceSize = [self drawWithStr:per Font:[UIFont systemFontOfSize:12] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.reviewPriceFrame.origin.x, self.reviewFrame.reviewPriceFrame.origin.y)];
        
        
        
        //口味环境服务
        if (_commentListModel.gradeOne.length>0 || _commentListModel.gradeTwo.length>0 || _commentListModel.gradeThree.length>0) {
            
            NSString *grade1 = [NSString stringWithFormat:@"口味:%@",_commentListModel.gradeOne];
            
            CGSize grade1Size = [self drawWithStr:grade1 Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.gradeOneFrame.origin.x, self.reviewFrame.gradeOneFrame.origin.y)];
            
            NSString *grade2 = [NSString stringWithFormat:@"环境:%@",_commentListModel.gradeTwo];
            
            CGSize grade2Size = [self drawWithStr:grade2 Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.gradeOneFrame.origin.x+grade1Size.width+10, self.reviewFrame.gradeOneFrame.origin.y)];
            
            NSString *grade3 = [NSString stringWithFormat:@"服务:%@",_commentListModel.gradeThree];
            [self drawWithStr:grade3 Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.gradeOneFrame.origin.x+grade1Size.width+10+grade2Size.width+10, self.reviewFrame.gradeOneFrame.origin.y)];
            
            
            [self drawWithStr:_commentListModel.commentContent Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.reviewTextFrame.origin.x, self.reviewFrame.reviewTextFrame.origin.y) Size:self.reviewFrame.reviewTextFrame.size];
                       
            
        }else{
            
            //评论内容
    //        CGFloat textWidth = SCREEN_WIDTH-imageX-imageX*2-imageWH;
    //        [self drawWithStr:_commentListModel.commentContent Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(imageX*2+imageWH, imageY*3+nameSize.height+priceSize.height) Size:CGSizeMake(textWidth, SCREEN_HEIGHT)];
            self.reviewTextLabel = [[UILabel alloc] init];
            self.reviewTextLabel.frame = CGRectMake(imageX*2+imageWH, imageY*3+nameSize.height+priceSize.height, self.reviewFrame.reviewTextFrame.size.width, self.reviewFrame.reviewTextFrame.size.height);
            self.reviewTextLabel.text = _commentListModel.commentContent;
            self.reviewTextLabel.textColor = RGBCOLOR(85, 85, 85);
            self.reviewTextLabel.font = CustomFont(15);
            self.reviewTextLabel.numberOfLines = 0;
            [self.contentView addSubview:self.reviewTextLabel];
        }
        
        
        //时间
        [self drawWithStr:_commentListModel.commentDate Font:[UIFont systemFontOfSize:12] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.reviewTimeFrame.origin.x, self.reviewFrame.reviewTimeFrame.origin.y)];
        
        
        //添加所有子控件
        [self setUpAllChildviews];
        //点赞
//        [self.contentView addSubview:self.goodBtn];
//        //反对
//        [self.contentView addSubview:self.badBtn];
        
        if ([_commentListModel.isClick isEqualToString:@"1"]) {//赞
            [self.goodBtn setImage:ZRImage(@"zan_hong") forState:UIControlStateNormal];
            [self.badBtn setImage:ZRImage(@"chaping") forState:UIControlStateNormal];
            
        }else if ([_commentListModel.isClick isEqualToString:@"2"]){ //差
            [self.badBtn setImage:ZRImage(@"cha_hong") forState:UIControlStateNormal];
            [self.goodBtn setImage:ZRImage(@"haoping") forState:UIControlStateNormal];
        }else{
            [self.goodBtn setImage:ZRImage(@"haoping") forState:UIControlStateNormal];
            [self.badBtn setImage:ZRImage(@"chaping") forState:UIControlStateNormal];
        }
        
       

        
        //点赞
        [self drawWithStr:_commentListModel.good Font:[UIFont systemFontOfSize:12] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(280*SCREEN_WIDTH/375, CGRectGetMinY(self.goodBtn.frame))];
        
        //反对点赞
        [self drawWithStr:_commentListModel.notGood Font:[UIFont systemFontOfSize:12] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(330*SCREEN_WIDTH/375, CGRectGetMinY(self.badBtn.frame))];
 
    }
    
    
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

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


@property (nonatomic, strong) UILabel *goodCount;
@property (nonatomic, strong) UILabel *badCount;

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
    
    
    //点赞数
    self.goodCount = [[UILabel alloc] initWithFrame:CGRectMake(280*SCREEN_WIDTH/375, CGRectGetMinY(self.goodBtn.frame), 25*SCREEN_WIDTH/375, ZRImage(@"haoping").size.height)];
    self.goodCount.textColor = RGBCOLOR(85, 85, 85);
    self.goodCount.font = CustomFont(12);
    [self.contentView addSubview:self.goodCount];
    
    //反对数
    self.badCount = [[UILabel alloc] initWithFrame:CGRectMake(330*SCREEN_WIDTH/375, CGRectGetMinY(self.badBtn.frame), 25*SCREEN_WIDTH/375, ZRImage(@"chaping").size.height)];
    self.badCount.textColor = RGBCOLOR(85, 85, 85);
    self.badCount.font = CustomFont(12);
    [self.contentView addSubview:self.badCount];
    
    
    //时间
    CGSize timeSize = [NSString getSize:_commentListModel.commentDate strFont:CustomFont(12) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-timeSize.width, self.reviewFrame.reviewTimeFrame.origin.y, timeSize.width+10, timeSize.height)];
    timeLabel.text = _commentListModel.commentDate;
    timeLabel.textColor = RGBCOLOR(85, 85, 85);
    timeLabel.font = CustomFont(12);
    [self.contentView addSubview:timeLabel];
    
}



#pragma mark - click methods
- (void)goodReviewClick:(UIButton *)sender
{
    
    if (sender.tag == 0) {
       //点赞按钮
        if ([_commentListModel.isClick isEqualToString:@"1"]) {
            [self.goodBtn setImage:ZRImage(@"haoping") forState:UIControlStateNormal];
            _clickGoodBtn(sender,_commentListModel.commentId, YES);
            _commentListModel.isClick = @"0";
            
            self.goodCount.text = [NSString stringWithFormat:@"%d",[self.goodCount.text intValue]-1];
            
        }else{
            [self.goodBtn setImage:ZRImage(@"zan_hong") forState:UIControlStateNormal];
            self.goodCount.text = [NSString stringWithFormat:@"%d",[self.goodCount.text intValue]+1];
                
            if ([_commentListModel.isClick isEqualToString:@"2"]) {
                _clickGoodBtn(self.badBtn,_commentListModel.commentId, YES);
                [self cancelBtn:_commentListModel.commentId WithBtn:sender];
                [self.badBtn setImage:ZRImage(@"chaping") forState:UIControlStateNormal];
                self.badCount.text = [NSString stringWithFormat:@"%d",[self.badCount.text intValue]-1];
                
            }else{
                _clickGoodBtn(sender,_commentListModel.commentId, NO);
                
            }
                
            _commentListModel.isClick = @"1";
            
            //
            
        }
        
    }else{
       //点反对赞按钮
        if ([_commentListModel.isClick isEqualToString:@"2"]) {
            [self.badBtn setImage:ZRImage(@"chaping") forState:UIControlStateNormal];
            _clickGoodBtn(sender,_commentListModel.commentId, YES);
            _commentListModel.isClick = @"0";
            
            self.badCount.text = [NSString stringWithFormat:@"%d",[self.badCount.text intValue] -1];
        }else{
            [self.badBtn setImage:ZRImage(@"cha_hong") forState:UIControlStateNormal];
            
            self.badCount.text = [NSString stringWithFormat:@"%d",[self.badCount.text intValue]+1];
            
            if ([_commentListModel.isClick isEqualToString:@"1"]) {
                _clickGoodBtn(self.goodBtn,_commentListModel.commentId, YES);
                [self cancelBtn:_commentListModel.commentId WithBtn:sender];
                [self.goodBtn setImage:ZRImage(@"haoping") forState:UIControlStateNormal];
                
                self.goodCount.text = [NSString stringWithFormat:@"%d",[self.goodCount.text intValue]-1];
            }else{
                _clickGoodBtn(sender,_commentListModel.commentId, NO);
            }
           
            _commentListModel.isClick = @"2";
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
        UIImage *pingxingImg = [UIImage imageWithPingfenCount:[_commentListModel.commentGrade floatValue]];
        [self drawImage:pingxingImg Rect:self.reviewFrame.reviewStarFrame];
        
        //价钱
        NSString *per = [NSString stringWithFormat:@"$%@/人",_commentListModel.perCapita];
        CGSize priceSize = [self drawWithStr:per Font:[UIFont systemFontOfSize:12] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.reviewPriceFrame.origin.x, self.reviewFrame.reviewPriceFrame.origin.y)];
        
        
        
        //口味环境服务
        if (_commentListModel.gradeOne.length>0 || _commentListModel.gradeTwo.length>0 || _commentListModel.gradeThree.length>0) {
            
            NSString *grade1;

            
            if (self.shoptype == 100) {
                //寻味
                grade1 = [NSString stringWithFormat:@"口味:%@",_commentListModel.gradeOne];
            }else if (self.shoptype == 101){
                //娱乐
                grade1 = [NSString stringWithFormat:@"设施:%@",_commentListModel.gradeOne];
            }else if (self.shoptype == 102){
                //丽人
                grade1 = [NSString stringWithFormat:@"效果:%@",_commentListModel.gradeOne];
            }
            
//            NSString *grade1 = [NSString stringWithFormat:@"口味:%@",_commentListModel.gradeOne];
            
            CGSize grade1Size = [self drawWithStr:grade1 Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.gradeOneFrame.origin.x, self.reviewFrame.gradeOneFrame.origin.y)];
            
            NSString *grade2 = [NSString stringWithFormat:@"环境:%@",_commentListModel.gradeTwo];
            
            CGSize grade2Size = [self drawWithStr:grade2 Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.gradeOneFrame.origin.x+grade1Size.width+10, self.reviewFrame.gradeOneFrame.origin.y)];
            
            NSString *grade3 = [NSString stringWithFormat:@"服务:%@",_commentListModel.gradeThree];
            [self drawWithStr:grade3 Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.gradeOneFrame.origin.x+grade1Size.width+10+grade2Size.width+10, self.reviewFrame.gradeOneFrame.origin.y)];
            
            
            [self drawWithStr:_commentListModel.commentContent Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(self.reviewFrame.reviewTextFrame.origin.x, self.reviewFrame.reviewTextFrame.origin.y) Size:self.reviewFrame.reviewTextFrame.size];
                       
            
        }else{
            
            //评论内容
            self.reviewTextLabel = [[UILabel alloc] init];
            CGFloat textWidth = SCREEN_WIDTH-imageX-imageX*2-imageWH;
            CGSize textSize = [NSString getSize:_commentListModel.commentContent strFont:CustomFont(13) maxSize:CGSizeMake(textWidth,SCREEN_HEIGHT)];
            if (textSize.height<nameSize.height*2+10) {
                self.reviewTextLabel.frame = CGRectMake(imageX*2+imageWH, imageY*3+nameSize.height+priceSize.height, self.reviewFrame.reviewTextFrame.size.width, textSize.height);
                
            }else{
                self.reviewTextLabel.frame = CGRectMake(imageX*2+imageWH, imageY*3+nameSize.height+priceSize.height, self.reviewFrame.reviewTextFrame.size.width, nameSize.height*2+10);
            }
            

            self.reviewTextLabel.text = _commentListModel.commentContent;
            self.reviewTextLabel.textColor = RGBCOLOR(85, 85, 85);
            self.reviewTextLabel.font = CustomFont(13);
            self.reviewTextLabel.numberOfLines = 0;
            [self.contentView addSubview:self.reviewTextLabel];
        }
        
        
        
        
        //添加所有子控件
        [self setUpAllChildviews];

        
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
        
        self.goodCount.text = _commentListModel.good;
        
        //反对点赞
        
        self.badCount.text = _commentListModel.notGood;
 
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

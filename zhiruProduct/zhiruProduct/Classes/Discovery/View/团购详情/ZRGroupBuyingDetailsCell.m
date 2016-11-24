//
//  ZRGroupBuyingDetailsCell.m
//  zhiruProduct
//
//  Created by nanding on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingDetailsCell.h"
#import "ZRGoodsModel.h"
#import "ZRGoodsListModel.h"
#import "ZRGroupBuyDetailsFrame.h"
#import "ZROtherGroupsModel.h"

#import "ZRCommentListModel.h"

@interface ZRGroupBuyingDetailsCell ()

@property (nonatomic, strong) ZRGoodsModel *goodsModel;
@property (nonatomic, strong) ZRGoodsListModel *goodsListModel;

@property (nonatomic, strong) ZROtherGroupsModel *otherGroupModel;

@property (nonatomic, strong) ZRCommentListModel *commentListModel;

@end


@implementation ZRGroupBuyingDetailsCell

-(void)setIdxPath:(NSIndexPath *)idxPath
{
    _idxPath = idxPath;
    

    [self setNeedsDisplay];
    
}



#pragma mark - init methods
+(instancetype)cellWithTable:(UITableView *)table forIndexPath:(NSIndexPath *)idxPath WithData:(ZRGroupBuyDetailModel *)detailsModel
{
    static NSString *cellIdentifier = @"cellIdentifier";
    ZRGroupBuyingDetailsCell *cell = [table dequeueReusableCellWithIdentifier:cellIdentifier];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.textLabel.text = nil;
    cell.accessoryView = nil;
    cell.imageView.image = nil;
    if (cell == nil) {
        cell = [[ZRGroupBuyingDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.detailsModel = detailsModel;
    
    if (idxPath.section == 1) {
        if (idxPath.row == 0) {
            if (detailsModel.businessNum == nil) {
                cell.textLabel.text = @"适用商户";
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"适用商户(%@)",detailsModel.businessNum];
                UIImage *img = ZRImage(@"ApplicableMerchant");
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
                imgView.image = img;
                cell.accessoryView = imgView;
            }
            
            cell.textLabel.textColor = RGBCOLOR(85, 85, 85);
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            
            
        }else if (idxPath.row == 1){
            UIImage *teleImg = ZRImage(@"tele");
            UIButton *teleBtn = [MyControl createButtonWithFrame:CGRectMake(SCREEN_WIDTH-25-teleImg.size.width, (75*SCREEN_HEIGHT/667-teleImg.size.height)/2, teleImg.size.width, teleImg.size.height) ImageName:@"tele" Target:self Action:@selector(teleClick:) Title:nil];
            [cell.contentView addSubview:teleBtn];
            
            
        }else{
            //地址
            cell.textLabel.text = detailsModel.businessAddress;
            cell.textLabel.textColor = RGBCOLOR(154, 154, 154);
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            UIImage *img = ZRImage(@"ApplicableMerchant");
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
            imgView.image = img;
            cell.accessoryView = imgView;
            cell.imageView.image = ZRImage(@"dingwei");
        }
        
    }else if (idxPath.section == 2){
        if (idxPath.row == 0) {
            cell.textLabel.text = @"团购详情";
            cell.textLabel.textColor = RGBCOLOR(85, 85, 85);
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            UIImage *img = ZRImage(@"ApplicableMerchant");
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
            imgView.image = img;
            cell.accessoryView = imgView;
            
            
        }
    }else if (idxPath.section == 3){
        if (idxPath.row == 0) {
            cell.textLabel.text = @"购买须知";
            cell.textLabel.textColor = RGBCOLOR(85, 85, 85);
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
        }
    }else{
        if ([detailsModel.otherGroupNum integerValue]>0) {
            if (idxPath.section == 4) {
                if (idxPath.row == 0) {
                    cell.textLabel.text = [NSString stringWithFormat:@"%@的其他团购",detailsModel.groupName];
                    cell.textLabel.textColor = RGBCOLOR(85, 85, 85);
                    cell.textLabel.font = [UIFont systemFontOfSize:15];
                    cell.imageView.image = ZRImage(@"redLine");
                }
                
            }else if (idxPath.section == 5){
                [cell reView:cell ForIdxPath:idxPath];
                
            }
            
        }else{
            if (idxPath.section == 4) {
                [cell reView:cell ForIdxPath:idxPath];
                
                
            }
            
        }
    }
    
    
  
    return cell;
}


- (void)reView:(ZRGroupBuyingDetailsCell *)cell ForIdxPath:(NSIndexPath *)idxPath
{
//    if (_idxPath.row != 0) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 0.5)];
//        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        [cell.contentView addSubview:view];
//    }
    
    if (idxPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"网友点评 (%@)",self.detailsModel.commentCount];
        cell.textLabel.textColor = RGBCOLOR(85, 85, 85);
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }else if (idxPath.row == 1){
        CGFloat x = 15;
        CGFloat width = (SCREEN_WIDTH-15*6)/3;
        CGFloat height = (90*SCREEN_HEIGHT/667-10*3)/2;
        for (int i=0; i<4; i++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(x*(i+1)+width*i, 10, width, height);
            btn.backgroundColor = RGBCOLOR(199, 199, 199);
            if (i==3) {
                btn.frame = CGRectMake(x, 10*2+height, width, height);
                [btn setTitle:[NSString stringWithFormat:@"有图 (%@)",self.detailsModel.bad] forState:UIControlStateNormal];
            }else if (i == 0) {
                btn.backgroundColor = RGBCOLOR(127, 199, 254);
                [btn setTitle:[NSString stringWithFormat:@"全部 (%@)",self.detailsModel.commentCount] forState:UIControlStateNormal];
            }else if (i == 1){
                [btn setTitle:[NSString stringWithFormat:@"好评 (%@)",self.detailsModel.praise] forState:UIControlStateNormal];
            }else{
                [btn setTitle:[NSString stringWithFormat:@"差评 (%@)",self.detailsModel.bad] forState:UIControlStateNormal];
            }
            btn.tag = 111+i;
            btn.layer.cornerRadius = 5;
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:cell action:@selector(reviewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
        }
    }
//    else if (idxPath.row == 2 || idxPath.row == 3){
//        UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 42*SCREEN_WIDTH/375, 42*SCREEN_WIDTH/375)];;
//        headImgView.backgroundColor = [UIColor grayColor];
//        headImgView.layer.cornerRadius = 21*SCREEN_WIDTH/375;
//        [cell.contentView addSubview:headImgView];
//        
//        //赞
//        UIImage *zanImg = ZRImage(@"haoping");
//        UIButton *zanBtn = [MyControl createButtonWithFrame:CGRectMake(260*SCREEN_WIDTH/375, 200*SCREEN_HEIGHT/667, zanImg.size.width, zanImg.size.height) ImageName:@"haoping" Target:cell Action:@selector(goodReviewClick:) Title:nil];
//        [cell.contentView addSubview:zanBtn];
//        
//        //反对
//        UIImage *reZanImg = ZRImage(@"chaping");
//        UIButton *reZanBtn = [MyControl createButtonWithFrame:CGRectMake(320*SCREEN_WIDTH/375, 200*SCREEN_HEIGHT/667, reZanImg.size.width, reZanImg.size.height) ImageName:@"chaping" Target:cell Action:@selector(badReviewClick:) Title:nil];
//        [cell.contentView addSubview:reZanBtn];
//    }
    else if (idxPath.row == 4){
        cell.textLabel.text = @"查看全部网友点评";
        cell.textLabel.textColor = RGBCOLOR(85, 85, 85);
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        UIImage *img = ZRImage(@"ApplicableMerchant");
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
        imgView.image = img;
        cell.accessoryView = imgView;
    }

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}




#pragma mark - btn clicks
/**
 *  致电商家
 */
+ (void)teleClick:(UIButton *)sender
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectZero];
    NSURL *url = [NSURL URLWithString:@"tel://10010"];
    [webView loadRequest:[NSURLRequest requestWithURL:url ]];
    [[UIApplication sharedApplication].keyWindow addSubview:webView];
}

/**
 *  网友点评
 */
- (void)reviewBtnClick:(UIButton *)sender
{
    for (int i=0; i<4; i++) {
        int t = 111+i;
        UIButton *btn = [self viewWithTag:t];
        if (t == sender.tag) {
            btn.backgroundColor = RGBCOLOR(127, 199, 254);
        }else{
            btn.backgroundColor = RGBCOLOR(199, 199, 199);
        }
    }
}

/**
 *  好评
 */
- (void)goodReviewClick:(UIButton *)sender
{
    
}

/**
 *  差评
 */
- (void)badReviewClick:(UIButton *)sender
{
    
}

#pragma mark - drawRect
-(void)drawRect:(CGRect)rect
{
    CGFloat height = 40*SCREEN_HEIGHT/667;
    if (_idxPath.section == 0) {
        if (_idxPath.row == 0) {
           [self drawImage:[UIImage getImageFromURL:_detailsModel.groupImg] Rect:CGRectMake(0, 0, SCREEN_WIDTH, 182*SCREEN_HEIGHT/667)];
        }else{
            CGFloat width = ZRImage(@"freeAppointment").size.width;
            CGFloat hei = ZRImage(@"freeAppointment").size.height;
            [self drawImage:ZRImage(@"AnyTimeBack") Rect:CGRectMake(15, (height-ZRImage(@"AnyTimeBack").size.height)/2, width, hei)];
            
            [self drawImage:ZRImage(@"OverdueWithdrawal") Rect:CGRectMake(15+width+28, (height-ZRImage(@"AnyTimeBack").size.height)/2, width, hei)];
            
            
            if ([_detailsModel.bespeak integerValue] == 0) {
                //免预约
                [self drawImage:ZRImage(@"freeAppointment") Rect:CGRectMake(15+(width+28)*2, (height-ZRImage(@"AnyTimeBack").size.height)/2, width, hei)];
            }else{
                [self drawImage:ZRImage(@"freeAppointmentGray") Rect:CGRectMake(15+(width+28)*2, (height-ZRImage(@"AnyTimeBack").size.height)/2, width, hei)];
            }
            
            //已售多少
            if (_detailsModel.sold_num == nil) {
                _detailsModel.sold_num = @"0";
            }
            CGSize size = [NSString getSize:[NSString stringWithFormat:@"已售%@",_detailsModel.sold_num] strFont:CustomFont(13) maxSize:CGSizeMake(SCREEN_WIDTH, ScreenHeight)];
            [self drawWithStr:[NSString stringWithFormat:@"已售%@",_detailsModel.sold_num] Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(SCREEN_WIDTH-15-size.width, (height-size.height)/2)];
            
            [self drawImage:ZRImage(@"saled") Rect:CGRectMake(SCREEN_WIDTH-15-ZRImage(@"saled").size.width-size.width-10, (height-ZRImage(@"AnyTimeBack").size.height)/2, ZRImage(@"saled").size.width, ZRImage(@"saled").size.height)];
            
            
            
        }
        
    }else if (_idxPath.section == 1 ){
        if (_idxPath.row == 1) {
            [self drawWithStr:self.detailsModel.businessName Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(15, 17)];
            UIImage *pingxingImg = [UIImage imageWithPingfenCount:[self.detailsModel.grade integerValue]];
            //评星
            [self drawImage:pingxingImg Rect:CGRectMake(15, 75*SCREEN_HEIGHT/667-17-pingxingImg.size.height, pingxingImg.size.width, pingxingImg.size.height)];
            
            //画线
            [self drawLineStartPoint:CGPointMake(15, 0) endPoint:CGPointMake(SCREEN_WIDTH-15, 0) Color:RGBCOLOR(240, 239, 245)];
            [self drawLineStartPoint:CGPointMake(SCREEN_WIDTH-70, 10) endPoint:CGPointMake(SCREEN_WIDTH-70, 75*SCREEN_HEIGHT/667-10) Color:RGBCOLOR(240, 239, 245)];
            
            CGSize size0 = [NSString getSize:self.detailsModel.distace strFont:CustomFont(13) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
            //距离 2km
            [self drawWithStr:self.detailsModel.distace Font:CustomFont(13) Color:RGBCOLOR(154, 154, 154) Point:CGPointMake(SCREEN_WIDTH-70-15-size0.width, 75*SCREEN_HEIGHT/667-17-pingxingImg.size.height)];
            
        }else if (_idxPath.row == 2){
            //画线
            [self drawLineStartPoint:CGPointMake(15, 0) endPoint:CGPointMake(SCREEN_WIDTH-15, 0) Color:RGBCOLOR(240, 239, 245)];
            
            
            
        }
        
    }else if (_idxPath.section == 2){
        CGFloat y = (10*SCREEN_HEIGHT/667);

        CGFloat x1 = 240*SCREEN_WIDTH/375;
        CGFloat hei = 15*SCREEN_HEIGHT/667;
        if (_idxPath.row == 0) {
            CGSize size = [NSString getSize:@"更多图文详情" strFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self drawWithStr:@"更多图文详情" Font:[UIFont systemFontOfSize:13] Color:RGBCOLOR(154, 154, 154) Point:CGPointMake(263*SCREEN_WIDTH/375, (height-size.height)/2)];
        }else if(_idxPath.row == 1){
            
            //line
            [self drawLineStartPoint:CGPointMake(15, 0) endPoint:CGPointMake(SCREEN_WIDTH-15, 0) Color:RGBCOLOR(240, 239, 245)];
            
            //保存每类的数量
            int num = 0;
            
            for (int i=0; i<self.detailsModel.goods.count; i++) {
                self.goodsModel = self.detailsModel.goods[i];
                if (i != 0) {
                    ZRGoodsModel *lastGoods = self.detailsModel.goods[i-1];
                    num = num+1+(int)lastGoods.goodsList.count;
                }
                
                [self drawWithStr:self.goodsModel.goodsClassify Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(154, 154, 154) Point:CGPointMake(15, y+num*(hei+y))];
                
                
                for (int j=0; j<self.goodsModel.goodsList.count; j++) {
                    self.goodsListModel = self.goodsModel.goodsList[j];
                    
                    [self drawWithStr:self.goodsListModel.name Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(15, (y+hei)+y+j*(hei+y)+num*(hei+y))];
                    [self drawWithStr:[NSString stringWithFormat:@"%@份",self.goodsListModel.num] Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x1, (y+hei)+y+j*(hei+y)+num*(hei+y))];
                    CGSize size2 = [NSString getSize:self.goodsListModel.unit_price strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
                    [self drawWithStr:self.goodsListModel.unit_price Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(SCREEN_WIDTH-15-size2.width, (y+hei)+y+j*(hei+y)+num*(hei+y))];
                }
               
            }

            
            //最高价值
            NSString *oldPrice = [NSString stringWithFormat:@"$%@",self.detailsModel.oldPrice];
            CGSize size3 = [NSString getSize:oldPrice strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self drawWithStr:oldPrice Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(SCREEN_WIDTH-15-size3.width, num*(y+hei)+y+(self.goodsModel.goodsList.count+1)*(y+hei))];
            //CGSize size4 = [NSString getSize:@"最高价值" strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self drawWithStr:@"最高价值" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x1,  num*(y+hei)+y+(self.goodsModel.goodsList.count+1)*(y+hei))];
            
            //团购价
            NSString *groupPrice = [NSString stringWithFormat:@"$%@",self.detailsModel.nowPrice];
            CGSize size5 = [NSString getSize:groupPrice strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self drawWithStr:groupPrice Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(255,82,82) Point:CGPointMake(SCREEN_WIDTH-15-size5.width, num*(y+hei)+y+(self.goodsModel.goodsList.count+2)*(y+hei))];
            //CGSize size6 = [NSString getSize:@"团购价" strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self drawWithStr:@"团购价" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x1,  num*(y+hei)+y+(self.goodsModel.goodsList.count+2)*(y+hei))];
            
            //赠送积分
            NSString *jifen = @"110分";
            CGSize size7 = [NSString getSize:jifen strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self drawWithStr:jifen Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(255,82,82) Point:CGPointMake(SCREEN_WIDTH-15-size7.width, num*(y+hei)+y+(self.goodsModel.goodsList.count+3)*(y+hei))];
            //CGSize size8 = [NSString getSize:@"赠送积分" strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self drawWithStr:@"赠送积分" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x1,  num*(y+hei)+y+(self.goodsModel.goodsList.count+3)*(y+hei))];
            
            
            
        }

    }else if (_idxPath.section == 3){
        //line
        [self drawLineStartPoint:CGPointMake(15, 0) endPoint:CGPointMake(SCREEN_WIDTH-15, 0) Color:RGBCOLOR(240, 239, 245)];
        if (_idxPath.row == 1) {
            //有效期
            [self drawWithStr:@"有效期" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(154, 154, 154) Point:_groupDetailsFrame.effectiveDateTitleFrame.origin];
            [self drawWithStr:[NSString stringWithFormat:@"· %@",self.detailsModel.effectiveDates] Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:_groupDetailsFrame.effectiveDateFrame.origin];
            
            [self drawWithStr:@"除外日期" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(154, 154, 154) Point:_groupDetailsFrame.exceptDateTitleFrame.origin];
            [self drawWithStr:[NSString stringWithFormat:@"· %@",self.detailsModel.exceptionDate] Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:_groupDetailsFrame.exceptDateFrame.origin];
            
            [self drawWithStr:@"使用时间" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(154, 154, 154) Point:_groupDetailsFrame.applicableTimeTitleFrame.origin];
            [self drawWithStr:[NSString stringWithFormat:@"· %@",self.detailsModel.applicableTime] Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:_groupDetailsFrame.applicableTimeFrame.origin];
            
            [self drawWithStr:@"预约提醒" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(154, 154, 154) Point:_groupDetailsFrame.remindTitleFrame.origin];
            [self drawWithStr:[NSString stringWithFormat:@"· %@",self.detailsModel.remind] Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:_groupDetailsFrame.remindFrame.origin];
            
            [self drawWithStr:@"规则提醒" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(154, 154, 154) Point:_groupDetailsFrame.ruleTitleFrame.origin];
            [self drawWithStr:[NSString stringWithFormat:@"· %@",self.detailsModel.rule]  Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:_groupDetailsFrame.ruleFrame.origin];
            
            [self drawWithStr:@"商家服务" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(154, 154, 154) Point:_groupDetailsFrame.deskTitleFrame.origin];
            [self drawWithStr:[NSString stringWithFormat:@"· %@",self.detailsModel.deskDescription]  Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:_groupDetailsFrame.deskFrame.origin];
        }
        
    }else{
        if ([_detailsModel.otherGroupNum integerValue] >0) {
            if (_idxPath.section == 4) {
                NSString *sold = [NSString stringWithFormat:@"已售%@",_otherGroupModel.sold_num];
                CGSize sizeStr = [NSString getSize:sold strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
                CGFloat y = (self.height-2*sizeStr.height)/3;
                CGFloat x = 15*SCREEN_WIDTH/375;
                
                if (_idxPath.row != 0) {
                    _otherGroupModel = _detailsModel.otherGroup[_idxPath.row-1];
                    CGSize size = [self drawWithStr:_otherGroupModel.group_name Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x, y)];
                    CGSize size1 = [self drawWithStr:_otherGroupModel.now_price Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(255, 82, 82) Point:CGPointMake(x, y+size.height+y)];
                    CGSize size2 = [self drawWithStr:@"$300" Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(154, 154, 154) Point:CGPointMake(x+size1.width+x, y+size.height+y)];
                    //line
                    [self drawLineStartPoint:CGPointMake(x+size1.width+x-1, y+size.height+y+size2.height/2) endPoint:CGPointMake(x+size1.width+x+size2.width+1, y+size.height+y+size2.height/2)  Color:RGBCOLOR(154, 154, 154)];
                    
                    
                    
                    CGSize size3 = [NSString getSize:sold strFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
                    [self drawWithStr:sold Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(154, 154, 154) Point:CGPointMake(297*SCREEN_WIDTH/375, (self.height-size3.height)/2)];
                    
                }
                //line
                [self drawLineStartPoint:CGPointMake(x, 0) endPoint:CGPointMake(SCREEN_WIDTH, 0) Color:RGBCOLOR(240, 239, 245)];

                
            }else if (_idxPath.section == 5){
                //[self review];
            }
            
        }else{
            if (_idxPath.section == 4) {
                //[self review];
                
            }
        }
    }
    
            
}




- (void)review
{
    //CGFloat x = 65*SCREEN_WIDTH/375;
    if (_idxPath.row == 2 || _idxPath.row == 3) {
        _commentListModel = _detailsModel.commentList[_idxPath.row-2];
        
        CGFloat x = 15*SCREEN_WIDTH/375;
        CGFloat y = 10*SCREEN_HEIGHT/667;
        CGFloat wid = 40*SCREEN_WIDTH/375;
        //头像
        [self drawImage:ZRImage(@"default_head") Rect:CGRectMake(x, y, wid, wid)];
        
        //name
        CGSize size1 = [self drawWithStr:_commentListModel.commentUserName Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x+wid+10,y)];
        //评星
        UIImage *pingxingImg = [UIImage imageWithPingfenCount:[_commentListModel.commentGrade integerValue]];
        [self drawImage:pingxingImg Rect:CGRectMake(x+wid+10, y+size1.height+y, pingxingImg.size.width, pingxingImg.size.height)];
        //价钱
        CGSize size2 = [self drawWithStr:_commentListModel.perCapita Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x+wid+10+pingxingImg.size.width+10, y+size1.height+y)];
        //评价
        CGSize contentSize = CGSizeMake(SCREEN_WIDTH-x-wid-10-(30*SCREEN_WIDTH/375), size2.height*2);
        CGSize size4 = [self drawWithStr:_commentListModel.commentContent Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x+wid+10,y+size1.height+y+size2.height+y) Size:contentSize];
        //时间
        CGSize size3 = [NSString getSize:@"6月11日" strFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self drawWithStr:_commentListModel.commentDate Font:[UIFont systemFontOfSize:13] Color:RGBCOLOR(154, 154, 154) Point:CGPointMake(SCREEN_WIDTH-15-size3.width, y)];
        //图片
        for (int i=0; i<_commentListModel.commentImg.count; i++) {
            CGFloat Width = SCREEN_WIDTH-(x+wid+10)-(45*SCREEN_WIDTH/375);
            //每一个图片宽度
            CGFloat PerWidth = ((Width-10*2)/3);
            if (i<3) {
                [self drawImage:[UIImage getImageFromURL:_commentListModel.commentImg[i]] Rect:CGRectMake(x+wid+10+i*(PerWidth+10), y+size1.height+y+size2.height+y+size4.height+y, PerWidth, PerWidth)];
            }
        }
        //        [self drawImage:ZRImage(@"hanbao") Rect:CGRectMake(x, 10+size1.height+10+size2.height+10+size4.height+15, 80*SCREEN_WIDTH/375, 80*SCREEN_WIDTH/375)];
        //        [self drawImage:ZRImage(@"hanbao") Rect:CGRectMake(x+80*SCREEN_WIDTH/375+10, 10+size1.height+10+size2.height+10+size4.height+15, 80*SCREEN_WIDTH/375, 80*SCREEN_WIDTH/375)];
        //        [self drawImage:ZRImage(@"hanbao") Rect:CGRectMake(x+80*SCREEN_WIDTH/375+10+80*SCREEN_WIDTH/375+10, 10+size1.height+10+size2.height+10+size4.height+15, 80*SCREEN_WIDTH/375, 80*SCREEN_WIDTH/375)];
        
        //点赞
        [self drawWithStr:@"100" Font:[UIFont systemFontOfSize:12] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(283*SCREEN_WIDTH/375, 205*SCREEN_HEIGHT/667)];
        
        //反对
        [self drawWithStr:@"90" Font:[UIFont systemFontOfSize:12] Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(344*SCREEN_WIDTH/375, 205*SCREEN_HEIGHT/667)];
        
        
        
        //向下大拇指数
        CGSize notGoodSize = [NSString getSize:_commentListModel.notGood strFont:CustomFont(13) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self drawWithStr:_commentListModel.notGood Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(SCREEN_WIDTH-x-notGoodSize.width, self.height-x-notGoodSize.height)];
        [self drawImage:ZRImage(@"chaping") Rect:CGRectMake(SCREEN_WIDTH-15-notGoodSize.width-(20*SCREEN_WIDTH/375)-5, self.height-x-20*SCREEN_WIDTH/375, 20*SCREEN_WIDTH/375, 20*SCREEN_WIDTH/375)];
        
        //向上大拇指数
        [self drawImage:ZRImage(@"haoping") Rect:CGRectMake(250*SCREEN_WIDTH/375,  self.height-x-20*SCREEN_WIDTH/375, 20*SCREEN_WIDTH/375, 20*SCREEN_WIDTH/375)];
        [self drawWithStr:_commentListModel.good Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(250*SCREEN_WIDTH/375+20*SCREEN_WIDTH/375+5, self.height-x-notGoodSize.height)];
        
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

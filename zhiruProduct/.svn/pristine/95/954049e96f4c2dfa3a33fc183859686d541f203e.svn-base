//
//  ZRPaymentOrderCell.m
//  zhiruProduct
//
//  Created by nanding on 16/9/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPaymentOrderCell.h"
#import "ZRGroupBuyDetailModel.h"

@interface ZRPaymentOrderCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIImageView *orderImgView;



@end


@implementation ZRPaymentOrderCell

#pragma mark - 懒加载
-(NSMutableArray *)selectPayArray
{
    if (!_selectPayArray) {
        //_selectPayArray = [NSMutableArray arrayWithObjects:ZRImage(@"submitOrderDuihao"),ZRImage(@"submitOrderDuihaoGray"),ZRImage(@"submitOrderDuihaoGray"), nil];
        _selectPayArray = [NSMutableArray array];
    }
    return _selectPayArray;
}

+(instancetype)cellWithTable:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath
{
    static NSString *cellID = @"cellID";
    ZRPaymentOrderCell *cell = [table dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRPaymentOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    cell.indexPath = idxPath;
    
    return cell;
}

-(void)setGroupBuyDetailModel:(ZRGroupBuyDetailModel *)groupBuyDetailModel
{
    _groupBuyDetailModel = groupBuyDetailModel;
    if (_indexPath.section == 0) {
        [self orderImage];
    }
    
   
}

-(void)setPayStyle:(SelectedPayStyle)payStyle
{
    _payStyle = payStyle;
}


-(void)setOrderType:(NSInteger)orderType
{
    _orderType = orderType;
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect
{
    CGFloat x = 15*SCREEN_WIDTH/375;
    if (_indexPath.section == 0) {
        if (_orderType == 0) {
            //团购
            if (_groupBuyDetailModel) {
                NSString *price = [NSString stringWithFormat:@"$ %@",_groupBuyDetailModel.nowPrice];
                CGFloat y = 30*SCREEN_HEIGHT/667;
                CGSize priceSize = [self drawWithStr:price Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(CGRectGetMaxX(_orderImgView.frame)+7, y)];
                
                [self drawWithStr:_groupBuyDetailModel.groupName Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(CGRectGetMaxX(_orderImgView.frame)+7, y+priceSize.height+7)];
            }
        }else{
            
            CGSize size = [NSString getSize:@"支付金额" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
            [self drawWithStr:@"支付金额" Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x,(self.height-size.height)/2)];
            
            
            CGSize size2 = [NSString getSize:self.payMoney strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
            [self drawWithStr:self.payMoney Font:CustomFont(15) Color:RGBCOLOR(255, 82, 82) Point:CGPointMake(SCREEN_WIDTH-x-size2.width,(self.height-size2.height)/2)];
            
        }
        
        
    }else if (_indexPath.section == 1){
        if (_indexPath.row == 0) {
            CGSize zhifuSize = [NSString getSize:@"钱包支付" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH,self.height)];
            [self drawWithStr:@"钱包支付" Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(15*SCREEN_WIDTH/375,(self.height-zhifuSize.height)/2)];
        }else if (_indexPath.row == 1){
            CGFloat wid = 33*SCREEN_WIDTH/375;
            [self drawImage:ZRImage(@"zhanghaoyue") Rect:CGRectMake(15*SCREEN_WIDTH/375, (self.height-wid)/2, wid, wid)];
            //账号余额
            CGSize yueSize = [self drawWithStr:@"账号余额" Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(15*SCREEN_WIDTH/375+wid+5,(self.height-wid)/2)];
            //可用余额
            [self drawWithStr:@"可用余额$0.00" Font:CustomFont(13) Color:RGBCOLOR(154, 154, 154) Point:CGPointMake(15*SCREEN_WIDTH/375+wid+5, (self.height-wid)/2+yueSize.height)];
            
            //余额不足
            CGSize yueBuzuSize = [NSString getSize:@"余额不足" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH,self.height)];
            [self drawWithStr:@"余额不足" Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(SCREEN_WIDTH-15*SCREEN_WIDTH/375-yueBuzuSize.width, (self.height-yueBuzuSize.height)/2)];
            
        }
    }else if (_indexPath.section == 2){
        CGFloat wid = 33*SCREEN_WIDTH/375;
        CGSize weichatSize = [NSString getSize:@"微信" strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
        CGFloat x = 15*SCREEN_WIDTH/375+wid+10;
        CGFloat y = (self.height-weichatSize.height)/2;
        
        
        CGFloat duihaoWid = 23*SCREEN_WIDTH/375;
        [self drawImage:self.selectPayArray[_indexPath.row] Rect:CGRectMake(SCREEN_WIDTH-15*SCREEN_WIDTH/375-duihaoWid, (self.height-duihaoWid)/2, duihaoWid, duihaoWid)];
        
        if (_indexPath.row == 0) {
            [self drawImage:ZRImage(@"payPal") Rect:CGRectMake(15*SCREEN_WIDTH/375, (self.height-wid)/2, wid, wid)];
            [self drawWithStr:@"Paypal" Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x, y)];
            
        }else if (_indexPath.row == 1){
            [self drawImage:ZRImage(@"wechatPay") Rect:CGRectMake(15*SCREEN_WIDTH/375, (self.height-wid)/2, wid, wid)];
            [self drawWithStr:@"微信" Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x, y)];
            
        }else{
            [self drawImage:ZRImage(@"zhifubaoPay") Rect:CGRectMake(15*SCREEN_WIDTH/375, (self.height-wid)/2, wid, wid)];
            [self drawWithStr:@"支付宝" Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x, y)];
        }
    }

}


#pragma mark - Private methods
-(void)orderImage
{
    CGFloat wid = 60*SCREEN_WIDTH/375;
    _orderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30*SCREEN_WIDTH/375, (100*SCREEN_HEIGHT/667-wid)/2, wid, wid)];
    _orderImgView.image = [UIImage getImageFromURL:_groupBuyDetailModel.groupImg];
    _orderImgView.layer.cornerRadius = wid/2;
    _orderImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_orderImgView];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

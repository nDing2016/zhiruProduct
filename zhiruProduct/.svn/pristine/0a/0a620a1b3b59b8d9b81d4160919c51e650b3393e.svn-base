//
//  ZRIntegralMallCell.m
//  zhiruProduct
//
//  Created by nanding on 16/7/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRIntegralMallCell.h"
#import "ZRCommodityListModel.h"

@interface ZRIntegralMallCell ()
{
    BOOL b;
}

@end

@implementation ZRIntegralMallCell


//-(void)setIntegralArr:(NSArray *)integralArr
//{
//   
//    _integralArr = integralArr;
//    if ([_integralArr[0] isEqualToString:@"titleImage"]) {
//        b = YES;
//        [self setNeedsDisplay];
//        
//    }else{
//        b = NO;
//        [self setNeedsDisplay];
//    }
//    
//}


//-(void)setIntegralMall:(ZRIntegralMallModel *)integralMall
//{
//    _integralMall = integralMall;
//    
////    if ([_integralArr[0] isEqualToString:@"titleImage"])
////    {
////                b = YES;
////                [self setNeedsDisplay];
////        
////    }else{
////                b = NO;
////                [self setNeedsDisplay];
////    }
//    
//    
//   
//}


-(void)setCommodityList:(ZRCommodityListModel *)commodityList
{
    _commodityList = commodityList;
    [self setNeedsDisplay];
}


-(void)setFirstImg:(NSString *)firstImg
{
    _firstImg = firstImg;
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect
{
    if (_commodityList) {
        //添加图片
        //UIImage *image = ZRImage(_integralArr[0]);
        
        //[self drawImage:[UIImage getImageFromURL:_commodityList.img] Rect:CGRectMake(0, 0, self.width, self.width)];
        
        //商品名
        CGSize size = [NSString getSize:@"牙膏" strFont:CustomFont(13) maxSize:CGSizeMake(self.width, 35)];
        CGSize size1 = [self drawWithStr:_commodityList.commodityName Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(5, self.width+5) Size:CGSizeMake(self.width, size.height*2)];
        
        //VIP图标
        [self drawImage:ZRImage(@"VIP") Rect:CGRectMake(5, self.width+5+size1.height+5, 18, 18)];
        
        //VIP积分
         [self drawWithStr:_commodityList.vipfraction Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(5+18+10, self.width+5+size1.height+5)];
        
        //添加金币
        [self drawImage:ZRImage(@"jifenyue-81") Rect:CGRectMake(5, self.width+5+(size1.height+5)*2+5, 18, 18)];
        
        
        //所需积分
        [self drawWithStr:_commodityList.fraction Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(5+18+10, self.width+5+(size1.height+5)*2+5)];
        
        //[self vipLabel:size1];
 
    }
    
    if (_firstImg) {
       [self drawImage:[UIImage getImageFromURL:_firstImg] Rect:CGRectMake(0, 0, self.width, self.height)];
    }
  
    
}


//- (void)vipLabel:(CGSize)size1
//{
//    CGFloat width = 30;
//    CGFloat height = 18;
//    //vip所需金币数量
//    UILabel *vipCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-7-width, self.width+5+size1.height+5, width+3, height-1)];
//    //[vipCountLabel setImage:ZRImage(@"right_kuang") forState:UIControlStateNormal];
//    vipCountLabel.layer.borderWidth = 1;
//    vipCountLabel.layer.borderColor = RGBCOLOR(85, 85, 85).CGColor;
//    vipCountLabel.layer.cornerRadius = 4.0;
//    vipCountLabel.text = _commodityList.vipfraction;
////    [vipCountLabel setTitle: _commodityList.vipfraction forState:UIControlStateNormal];
////    [vipCountLabel setTitleColor:RGBCOLOR(85, 85, 85) forState:UIControlStateNormal];
//    vipCountLabel.textColor = RGBCOLOR(85, 85, 85);
//    vipCountLabel.font = CustomFont(12);
//    vipCountLabel.textAlignment = NSTextAlignmentRight;
//    //会员label
//    UILabel *vipLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-5-width-width+3, self.width+5+size1.height+5, width, height)];
//    vipLabel.backgroundColor = RGBCOLOR(255.0, 212.0, 121.0);
//    vipLabel.layer.cornerRadius = 4.0;
//    vipLabel.layer.masksToBounds = YES;
//    vipLabel.text = @"会员";
//    vipLabel.textColor = [UIColor whiteColor];
//    vipLabel.font = CustomFont(13);
//    vipLabel.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:vipCountLabel];
//    [self.contentView addSubview:vipLabel];
//
//    
//}




@end

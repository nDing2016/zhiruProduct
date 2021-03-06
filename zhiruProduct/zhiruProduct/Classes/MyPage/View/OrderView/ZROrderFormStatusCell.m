//
//  ZROrderFormStatusCell.m
//  zhiruProduct
//
//  Created by nanding on 16/7/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderFormStatusCell.h"
#import "ZRSuperOrderProcessModel.h"

#define  SelfHeight              (120*SCREEN_HEIGHT/667)

@implementation ZROrderFormStatusCell
#pragma mark - init methods
+(instancetype)cellWithTable:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath
{
    static NSString *cellWithIdentifier = @"cellWithIdentifier";
    ZROrderFormStatusCell *cell = [table dequeueReusableCellWithIdentifier:cellWithIdentifier];
    if (cell == nil) {
        cell = [[ZROrderFormStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellWithIdentifier];
    }
    
    
    
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGBCOLOR(250, 250, 250);
    }
    return self;
}


-(void)setProcessModel:(ZRSuperOrderProcessModel *)processModel
{
    _processModel = processModel;
    [self setNeedsDisplay];
}

#pragma mark - drawRect
-(void)drawRect:(CGRect)rect
{
    
    
    //绘制长方形
    CGFloat x = 20*SCREEN_WIDTH/375;
    CGFloat X = x*2+ZRImage(@"OrderStatus").size.width;
    CGFloat y = x;
    CGPoint p1 = CGPointMake(X, y);
    CGPoint p2 = CGPointMake(SCREEN_WIDTH-x, y);
    CGPoint p4 = CGPointMake(X, SelfHeight);
    CGPoint p3 = CGPointMake(SCREEN_WIDTH-x, SelfHeight);
    CGFloat r;
    CGFloat g;
    CGFloat b;
    
    if (self.idxPath.row == self.status) {
        r = 255.0/255.0;
        g = 142.0/255.0;
        b = 141.0/255.0;
        //绘制图片
        [self drawImage:ZRImage(@"OrderStatusRed") Rect:CGRectMake(x, (SelfHeight-y-ZRImage(@"OrderStatusRed").size.height)/2+y, ZRImage(@"OrderStatusRed").size.width, ZRImage(@"OrderStatusRed").size.height)];
    }else{
        r = 217.0/255.0;
        g = 217.0/255.0;
        b = 217.0/255.0;
        //绘制图片
        [self drawImage:ZRImage(@"OrderStatus") Rect:CGRectMake(x, (SelfHeight-y-ZRImage(@"OrderStatus").size.height)/2+y, ZRImage(@"OrderStatus").size.width, ZRImage(@"OrderStatus").size.height)];
    }
    [self drawRectangleWithPoint1:p1 Point2:p2 Point3:p3 Point4:p4 Color:r G:g B:b Alpha:1];
    
    
    //竖线
    if (self.idxPath.row != self.status) {
        [self drawLineStartPoint:CGPointMake(x+ZRImage(@"OrderStatus").size.width/2, (SelfHeight-(SelfHeight-y-ZRImage(@"OrderStatus").size.height)/2)) endPoint:CGPointMake(x+ZRImage(@"OrderStatus").size.width/2, SelfHeight) Color:RGBCOLOR(187.0, 187.0, 187.0)];
        
    }
    if (self.idxPath.row != 0){
        [self drawLineStartPoint:CGPointMake(x+ZRImage(@"OrderStatus").size.width/2, 0) endPoint:CGPointMake(x+ZRImage(@"OrderStatus").size.width/2, (SelfHeight-y-ZRImage(@"OrderStatus").size.height)/2+y) Color:RGBCOLOR(187.0, 187.0, 187.0)];
        
    }
    
    //红色背景框高度
    CGFloat bgHeight = SelfHeight-x;
    CGFloat bgWidth = SCREEN_WIDTH-X-x-10;
    //文字
    if (self.idxPath.row == 0) {
        
        CGSize size = [self drawWithStr:self.processModel.process Font:CustomFont(18) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10)];
        
        [self drawWithStr:[NSString stringWithFormat:@"单号:%@,请耐心等待商家确认",self.orderId] Font:CustomFont(14) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10+size.height+5) Size:CGSizeMake(bgWidth,bgHeight)];
//        CGSize size1 = [NSString getSize:self.processModel.create_date strFont:CustomFont(12) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
//        [self drawWithStr:self.processModel.create_date Font:CustomFont(12) Color:[UIColor whiteColor] Point:CGPointMake(SCREEN_WIDTH-x-10-size1.width, y+14)];
        
    }else if (self.idxPath.row == 1){
        CGSize size = [self drawWithStr:self.processModel.process Font:CustomFont(18) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10)];
        [self drawWithStr:self.totalPrice Font:CustomFont(14) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10+size.height+5)];
//        CGSize size1 = [NSString getSize:self.processModel.create_date strFont:CustomFont(12) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
//        [self drawWithStr:self.processModel.create_date Font:CustomFont(12) Color:[UIColor whiteColor] Point:CGPointMake(SCREEN_WIDTH-x-10-size1.width, y+14)];
        
    }else if (self.idxPath.row == 2){
        CGSize size = [self drawWithStr:self.processModel.process Font:CustomFont(18) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10)];
        [self drawWithStr:@"15分钟内商户未接单,将自动取消" Font:CustomFont(14) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10+size.height+5)];
//        CGSize size1 = [NSString getSize:self.processModel.create_date strFont:CustomFont(12) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
//        [self drawWithStr:self.processModel.create_date Font:CustomFont(12) Color:[UIColor whiteColor] Point:CGPointMake(SCREEN_WIDTH-x-10-size1.width, y+14)];
        
    }else if (self.idxPath.row == 3){
        CGSize size = [self drawWithStr:self.processModel.process Font:CustomFont(18) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10)];
        [self drawWithStr:@"正在为您准备商品" Font:CustomFont(14) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10+size.height+5)];
//        CGSize size1 = [NSString getSize:self.processModel.create_date strFont:CustomFont(12) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
//        [self drawWithStr:self.processModel.create_date Font:CustomFont(12) Color:[UIColor whiteColor] Point:CGPointMake(SCREEN_WIDTH-x-10-size1.width, y+14)];
        
    }else if (self.idxPath.row == 4){
        CGSize size = [self drawWithStr:self.processModel.process Font:CustomFont(18) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10)];
        CGSize size2 = [self drawWithStr:@"骑士电话:" Font:CustomFont(14) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10+size.height+5)];
        
        [self drawWithStr:[NSString stringWithFormat:@"%@",self.riderTele] Font:CustomFont(14) Color:RGBCOLOR(255.0, 142.0, 141.0) Point:CGPointMake(X+10+size2.width+10, y+10+size.height+5)];
//        CGSize size1 = [NSString getSize:self.processModel.create_date strFont:CustomFont(12) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
//        [self drawWithStr:self.processModel.create_date Font:CustomFont(12) Color:[UIColor whiteColor] Point:CGPointMake(SCREEN_WIDTH-x-10-size1.width, y+14)];
        
    }else{
        CGSize size = [self drawWithStr:self.processModel.process Font:CustomFont(18) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10)];
        [self drawWithStr:@"任何意见和吐槽，都欢迎联系我们" Font:CustomFont(14) Color:[UIColor whiteColor] Point:CGPointMake(X+10, y+10+size.height+5)];
//        CGSize size1 = [NSString getSize:self.processModel.create_date strFont:CustomFont(12) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
//        [self drawWithStr:self.processModel.create_date Font:CustomFont(12) Color:[UIColor whiteColor] Point:CGPointMake(SCREEN_WIDTH-x-10-size1.width, y+14)];
        
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

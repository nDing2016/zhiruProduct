//
//  ZRDiscoveryTableCell.m
//  zhiruProduct
//
//  Created by nanding on 16/7/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRDiscoveryTableCell.h"
#import "ZRRecommendGroupListModel.h"
#import "ZRFindNewProduct.h"

@interface ZRDiscoveryTableCell ()

@property (nonatomic, assign) NSInteger kinds;
@property (nonatomic, strong) NSIndexPath *idxPath;

@end

@implementation ZRDiscoveryTableCell

//#pragma mark - 懒加载
//-(NSArray *)kindsArray
//{
//    if (!_kindsArray) {
//        _kindsArray = @[ZRImage(@"fd_meishi"),ZRImage(@"fd_liren"),ZRImage(@"fd_yule"),ZRImage(@"fd_lvxing"),ZRImage(@"df_gouwu"),ZRImage(@"ft_shenghuo")];
//    }
//    return _kindsArray;
//}



//-(void)setDic:(NSDictionary *)dic
//{
//    _dic = dic;
//
//    
//    
//}


-(void)setNavTitleArray:(NSArray *)navTitleArray
{
    _navTitleArray = navTitleArray;
    if (_kinds == 0) {
        if (_idxPath.section == 0) {
            [self setUpButtons];
        }
        
    }

}



-(void)setGroupListModel:(ZRRecommendGroupListModel *)groupListModel
{
    _groupListModel = groupListModel;
    
    [self setNeedsDisplay];
}


//-(void)setLatestProductArr:(NSArray *)latestProductArr
//{
//    _latestProductArr = latestProductArr;
//    
//    
//    
//    
//}


-(void)setFindNewProduct:(ZRFindNewProduct *)findNewProduct
{
    _findNewProduct = findNewProduct;
    [self setNeedsDisplay];
}


#pragma mark - init methods
+(ZRDiscoveryTableCell *)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withKinds:(NSInteger)kinds;
{
    static NSString *cellID = @"cellID";
    ZRDiscoveryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRDiscoveryTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    
    cell.kinds = kinds;
    cell.idxPath = indexPath;
    
    return cell;
}

- (void)setUpButtons
{
    CGFloat x = 15*SCREEN_WIDTH/375;
    CGFloat y = 16;
    CGFloat width = 40;
    CGFloat height = 64;
    CGFloat spacing = (SCREEN_WIDTH-2*x-6*width)/5;
    
    CGFloat titleX = x-5;
    CGFloat titleWidth = 50;
    CGFloat titleSpacing = (SCREEN_WIDTH-2*titleX-6*titleWidth)/5;
    
    
    //NSArray *kindsArray = @[ZRImage(@"fd_meishi"),ZRImage(@"fd_liren"),ZRImage(@"fd_yule"),ZRImage(@"fd_lvxing"),ZRImage(@"df_gouwu"),ZRImage(@"ft_shenghuo")];
    for (int i=0; i<6; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x+i*(width+spacing), y, width, width)];
        [button setImage:[UIImage getImageFromURL:_navImageArray[i]] forState:UIControlStateNormal];
        button.tag = kDiscover_Category1+i;
        
        UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleX+i*(titleWidth+titleSpacing), CGRectGetMaxY(button.frame), titleWidth, height-width)];
        [titleBtn setTitle:_navTitleArray[i] forState:UIControlStateNormal];
        titleBtn.tag = kDiscover_Category1+i;
        [titleBtn setTitleColor:RGBCOLOR(85, 85, 85) forState:UIControlStateNormal];
        titleBtn.titleLabel.font = CustomFont(12);
        titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        [button addTarget:self action:@selector(recommendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleBtn addTarget:self action:@selector(recommendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        [self.contentView addSubview:titleBtn];
    }

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


#pragma mark - click methods
/**
 *  推荐：分类点击事件
 *
 *  @param sender 美食、丽人、娱乐、旅行、购物、生活
 */
- (void)recommendBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(categoriesClick:withCell:)]) {
        [self.delegate categoriesClick:sender.tag withCell:self];
    }
    
    
       
}



#pragma mark - drawRect
-(void)drawRect:(CGRect)rect
{
    if (_groupListModel) {
        //绘制图片
        //self.imgView.image = ZRImage(@"hanbao");
        //ZRImage(@"hanbao");
        //UIImage* myImageObj = ZRImage(@"hanbao");
        CGFloat x = 15*SCREEN_WIDTH/375;
        CGFloat y = 7.5*SCREEN_HEIGHT/667;
        CGFloat width = 180*SCREEN_WIDTH/375;
        CGFloat height = 110*SCREEN_HEIGHT/667;
        [self drawImage:[UIImage getImageFromURL:_groupListModel.groupImg] Rect:CGRectMake(x, y, width, height)];
        //名字
        UIFont *font1 = [UIFont systemFontOfSize:15];
        NSString *str1 = _groupListModel.groupName;
        //月售
        NSString *str2 = [NSString stringWithFormat:@"月售%@",_groupListModel.soldNum];
        //价格
        NSString *str3 = [NSString stringWithFormat:@"$%@",_groupListModel.nowPrice];
        
        CGSize size1 = [self drawWithStr:str1 Font:font1 Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x+width+10, y+20)];
        [self drawWithStr:str2 Font:CustomFont(12) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x+width+10, y+35+size1.height)];
        [self drawWithStr:str3 Font:[UIFont systemFontOfSize:15] Color:RGBCOLOR(255, 82, 82) Point:CGPointMake(x+width+10, y+50+size1.height*2)];
      
        
        //预约
        //[self drawImage:ZRImage(@"yuding") Rect:CGRectMake(x+width+30+size3.width, y+45+size1.height*2, 20, 20)];
        
        
        

    }else if(_findNewProduct){
        //绘制图片
        [self drawImage:[UIImage getImageFromURL:_findNewProduct.groupImg] Rect:CGRectMake(0, 0, SCREEN_WIDTH, self.height)];
        
        [self drawRectangleWithPoint1:CGPointMake(0, 0) Point2:CGPointMake(SCREEN_WIDTH, 0) Point3:CGPointMake(SCREEN_WIDTH, self.height) Point4:CGPointMake(0, self.height) Color:0 G:0 B:0 Alpha:0.5];
        CGSize nameSize = [NSString getSize:_findNewProduct.groupName strFont:CustomFont(16) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        CGSize priceSize = [NSString getSize:_findNewProduct.nowPrice strFont:CustomFont(16) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        CGSize distanceSize = [NSString getSize:_findNewProduct.distance strFont:CustomFont(16) maxSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        //名
        [self drawWithStr:_findNewProduct.groupName Font:CustomFont(16) Color:[UIColor whiteColor] Point:CGPointMake((SCREEN_WIDTH-nameSize.width)/2, 0.25*self.height)];
        //价格
        [self drawWithStr:_findNewProduct.nowPrice Font:CustomFont(16) Color:[UIColor whiteColor] Point:CGPointMake((SCREEN_WIDTH-priceSize.width)/2, self.height *0.47)];
        //距离
        [self drawWithStr:_findNewProduct.distance Font:CustomFont(16) Color:[UIColor whiteColor] Point:CGPointMake((SCREEN_WIDTH-distanceSize.width)/2, self.height*0.68)];
        
        
        
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

//
//  ZRImmediatelyExchangeCell.m
//  zhiruProduct
//
//  Created by nanding on 16/7/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRImmediatelyExchangeCell.h"
#import "ZRUserFindAddressModel.h"
@interface ZRImmediatelyExchangeCell ()

@property (nonatomic, strong) NSIndexPath *idxPath;

@end

@implementation ZRImmediatelyExchangeCell


-(void)setAddressArr:(NSMutableArray *)addressArr
{
    _addressArr = addressArr;
//    if (self.idxPath.section == 0) {
//       self.imageView.image = _addressArr[0]; 
//    }
    
    [self setNeedsDisplay];
    
}


-(void)setAddModel:(ZRUserFindAddressModel *)addModel
{
    _addModel = addModel;
    self.imageView.image = ZRImage(@"dingwei_hong");
    [self setNeedsDisplay];
}


+ (ZRImmediatelyExchangeCell *)cellWithTable:(UITableView *)table IndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    ZRImmediatelyExchangeCell *cell = [table dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRImmediatelyExchangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    cell.idxPath = indexPath;
    
    return cell;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    
    if (self.idxPath.section == 0) {     
        //content
        //CGSize nameSize =[self drawWithStr:_addModel.name Font:[UIFont systemFontOfSize:16] Color:[UIColor blackColor] Point:CGPointMake(50, 25)];
        
        NSString *sex;
        if ([_addModel.gender integerValue] == 0) {
            sex = @"男";
        }else{
            sex = @"女";
        }
        //[self drawWithStr:sex Font:[UIFont systemFontOfSize:16] Color:[UIColor grayColor] Point:CGPointMake(90, 25)];
        
        CGSize phoneSize = [self drawWithStr:_addModel.phone Font:[UIFont systemFontOfSize:16] Color:[UIColor grayColor] Point:CGPointMake(50+70+5, 25)];
        [self setUpLabelWiteString:_addModel.name AndRect:CGRectMake(50, 25, 70, phoneSize.height)];

        
        [self drawWithStr:_addModel.address Font:[UIFont systemFontOfSize:12] Color:[UIColor grayColor] Point:CGPointMake(50, 55) Size:CGSizeMake(SCREEN_WIDTH-100, self.height)];
    }else if (self.idxPath.section == 1){
        CGSize size = [NSString getSize:_addressArr[self.idxPath.row][0] strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
        CGFloat x = 15*SCREEN_WIDTH/375;
        //[self drawWithStr:_addressArr[self.idxPath.row][0] Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(x, (self.height-size.height)/2)];
        
        [self setUpLabelWiteString:_addressArr[self.idxPath.row][0] AndRect:CGRectMake(x, (self.height-size.height)/2, SCREEN_WIDTH-2*x, size.height)];
        
        
        if (self.idxPath.row == 1) {
            CGFloat btnWid = 32*SCREEN_WIDTH/375;
            CGFloat btnHei = 28*SCREEN_HEIGHT/667;
            CGFloat labWid = 36*SCREEN_WIDTH/375;
            //右侧加号按钮
            UIButton *rightPlusBtn = [MyControl createButtonWithFrame:CGRectMake(SCREEN_WIDTH-x-btnWid, (self.height-btnHei)/2, btnWid, btnHei) ImageName:@"youjia" Target:self Action:@selector(rightPlusBtnClick:) Title:nil];
            [self.contentView addSubview:rightPlusBtn];
            //中间数字
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-x-btnWid-labWid, (self.height-btnHei)/2, labWid, btnHei)];
            countLabel.layer.borderColor = RGBCOLOR(240, 239, 245).CGColor;
            countLabel.layer.borderWidth = 1.0;
            countLabel.text = self.addressArr[1][1];
            countLabel.textColor = RGBCOLOR(85, 85, 85);
            countLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:countLabel];
            
            //左侧减号按钮
            UIButton *leftMinusBtn = [MyControl createButtonWithFrame:CGRectMake(SCREEN_WIDTH-x-btnWid-labWid-btnWid, (self.height-btnHei)/2, btnWid, btnHei) ImageName:@"zuojian-" Target:self Action:@selector(leftMinusBtnClick:) Title:nil];
            [self.contentView addSubview:leftMinusBtn];
            
        }else{
            CGSize size1 = [NSString getSize:self.addressArr[self.idxPath.row][1] strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
            if (self.idxPath.row == 3) {
                
                [self drawWithStr:self.addressArr[self.idxPath.row][1] Font:CustomFont(15) Color:RGBCOLOR(255, 82, 82) Point:CGPointMake(SCREEN_WIDTH-x-size1.width, (self.height-size1.height)/2)];
            }else{
                if (self.idxPath.row != 0) {
                     [self drawWithStr:self.addressArr[self.idxPath.row][1] Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(SCREEN_WIDTH-x-size1.width, (self.height-size1.height)/2)];
                }
               
            }
            CGFloat w = 18*SCREEN_WIDTH/375;
            
            if(self.idxPath.row !=0){            
                [self drawImage:ZRImage(@"jifenyue-81") Rect:CGRectMake(SCREEN_WIDTH-x-size1.width-w-w, (self.height-w)/2, w, w)];
            }
        }
        
        
        
        
        
    }
    
    
    
    
    
    
}

- (void)setUpLabelWiteString:(NSString *)text AndRect:(CGRect)rect
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:rect];
    textLabel.text = text;
    textLabel.textColor = RGBCOLOR(85, 85, 85);
    textLabel.font = CustomFont(15);
    [self.contentView addSubview:textLabel];
}


#pragma mark - click methods
/**
 *  右侧加号点击事件
 */
- (void)rightPlusBtnClick:(UIButton *)sender
{
    int i = [self.addressArr[1][1] intValue];
    int price = [self.addressArr[2][1] intValue]/i;
    int vipPrice = [self.addressArr[3][1] intValue]/i;
    
    //计算能兑换几个
    int perPrice = [self.addressArr[0][1] intValue];
    int count = [self.myPoints intValue]/perPrice;
    if (i<count) {
        i++;
        [self.addressArr[1] replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",i]];
        [self.addressArr[2] replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",i*price]];
        [self.addressArr[3] replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",i*vipPrice]];
        
        if ([self.delegate respondsToSelector:@selector(plusOrMinusWithArray:)]) {
            [self.delegate plusOrMinusWithArray:self.addressArr];
        }
 
    }else{
        [SVProgressHUD showErrorWithStatus:@"您的积分不够了"];
    }
    
    
    
}

/**
 *  左侧减号点击事件
 */
- (void)leftMinusBtnClick:(UIButton *)sender
{
    int i = [self.addressArr[1][1] intValue];
    if (i>1) {
        int price = [self.addressArr[2][1] intValue]/i;
        int vipPrice = [self.addressArr[3][1] intValue]/i;
        i--;
        [self.addressArr[1] replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",i]];
        [self.addressArr[2] replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",i*price]];
        [self.addressArr[3] replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",i*vipPrice]];
        if ([self.delegate respondsToSelector:@selector(plusOrMinusWithArray:)]) {
            [self.delegate plusOrMinusWithArray:self.addressArr];
        }

    }else{
        [SVProgressHUD showErrorWithStatus:@"不能再减了"];
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

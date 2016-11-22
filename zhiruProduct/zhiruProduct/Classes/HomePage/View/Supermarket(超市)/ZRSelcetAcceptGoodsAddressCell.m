//
//  ZRSelcetAcceptGoodsAddressCell.m
//  zhiruProduct
//
//  Created by nanding on 16/9/10.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSelcetAcceptGoodsAddressCell.h"
#import "ZRMyLocation.h"
#import "ZRSelectAcceptAddressModel.h"

@interface ZRSelcetAcceptGoodsAddressCell ()

@property (nonatomic, strong) NSIndexPath *idxPath;

@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ZRSelcetAcceptGoodsAddressCell

#pragma mark - 懒加载
-(UIButton *)locationBtn
{
    if (!_locationBtn) {
        CGFloat y=7;
        CGFloat hei = self.height-2*y;
        CGFloat wid = 93;
        _locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-wid, y, wid, hei)];
        [_locationBtn setTitle:@"重新定位" forState:UIControlStateNormal];
        [_locationBtn setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = CustomFont(15);
        [_locationBtn setImage:ZRImage(@"reLocation") forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(reFixedPositionClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_locationBtn];
    }
    return _locationBtn;
}


-(UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = CGPointMake(SCREEN_WIDTH-30, self.height/2);
        [self.contentView addSubview:_indicatorView];
    }
    return _indicatorView;
}

#pragma mark - 初始化
+(instancetype)cellWithTable:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath
{
    static NSString *cellID = @"cellID";
    ZRSelcetAcceptGoodsAddressCell *cell = [table dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRSelcetAcceptGoodsAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.idxPath = idxPath;
    
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationNoti:) name:kLocation_Noti object:nil];
        
    }
    return self;
}

- (void)locationNoti:(NSNotification *)noti
{
    [self.indicatorView stopAnimating];
    
    self.curLocation = noti.object;
    [self setNeedsDisplay];
 
}


-(void)setCurLocation:(NSString *)curLocation
{
    _curLocation = curLocation;
    [self setNeedsDisplay];
}


-(void)setHistoryAddress:(ZRSelectAcceptAddressModel *)historyAddress
{
    _historyAddress = historyAddress;
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect
{
    if (_idxPath.section == 0) {
        CGSize localSize = [NSString getSize:_curLocation strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, self.height)];
        [self drawWithStr:_curLocation Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(15, (self.height-localSize.height)/2)];
        //添加重新定位按钮
        [self reFixedPosition];
        
    }else{
        //姓名
        CGSize nameSize = [NSString getSize:_historyAddress.name strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, self.height/2)];
        [self drawWithStr:_historyAddress.name Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(15, (self.height/2-nameSize.height)/2)];
        
        //先生/女士
        NSString *sexStr;
        if ([_historyAddress.gender isEqualToString:@"0"]) {
            sexStr = @"先生";
        }else if([_historyAddress.gender isEqualToString:@"1"]){
            sexStr = @"女士";
        }
        CGSize sexSize = [NSString getSize:sexStr strFont:CustomFont(15) maxSize:CGSizeMake(SCREEN_WIDTH, self.height/2)];
        [self drawWithStr:sexStr Font:CustomFont(15) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(15+nameSize.width+10, (self.height/2-sexSize.height)/2)];
        
        //电话
        CGSize teleSize = [NSString getSize:_historyAddress.phone strFont:CustomFont(13) maxSize:CGSizeMake(SCREEN_WIDTH, self.height/2)];
        [self drawWithStr:_historyAddress.phone Font:CustomFont(13) Color:RGBCOLOR(85, 85, 85) Point:CGPointMake(15+nameSize.width+10+sexSize.width+10, (self.height/2-sexSize.height)/2+sexSize.height-teleSize.height)];
        
        //地址
        CGSize addressSize = [NSString getSize:_historyAddress.address strFont:CustomFont(13) maxSize:CGSizeMake(SCREEN_WIDTH, self.height/2)];
        [self drawWithStr:_historyAddress.address Font:CustomFont(13) Color:RGBCOLOR(154, 154, 154) Point:CGPointMake(15, self.height-((self.height/2-nameSize.height)/2)-addressSize.height)];
        
    }
}


/**
 *  重新定位
 */
- (void)reFixedPosition
{
    self.locationBtn.hidden = NO;
    self.indicatorView.hidden = YES;
}

#pragma mark - click methods
/**
 *  重新定位
 */
- (void)reFixedPositionClick:(UIButton *)sender
{
    self.locationBtn.hidden = YES;
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    //定位
    [[ZRMyLocation shareInstance] getMylocation];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

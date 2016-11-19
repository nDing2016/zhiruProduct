//
//  ZRPhotosCell.m
//  zhiruProduct
//
//  Created by pj on 16/9/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPhotosCell.h"

@implementation ZRPhotosCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor blackColor]];
        [self createView];

    }
    return self;
}
- (void)createView
{
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgView];
    
    self.imgName = [[UILabel alloc] init];
    [self.imgName setTextColor:[UIColor whiteColor]];
    [self.imgName setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_imgName];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.timeLabel setTextColor:[UIColor whiteColor]];
    [self.timeLabel setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_timeLabel];
}
//- (void)setViewMasonary
//{
//    
//}
- (void)setModel:(ZRPhotosModel *)model
{
    _model = model;
    WS(weakSelf);
    UIImage * image = [UIImage getImageFromURL:_model.img_url];
    CGSize size = image.size;
    CGFloat height;
    if (image == nil) {
        height = ScreenHeight - 64;
    } else {
        height = ScreenWidth / size.width * size.height;
    }
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(height);
    }];
//    [self.imgView setImage:image];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.img_url] placeholderImage:ZRPlaceholderImage];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.bottom.equalTo(weakSelf).with.offset(-10);
    }];
    [self.timeLabel setText:_model.create_date];
    
    [self.imgName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.timeLabel.mas_top).with.offset(-5);
        make.left.equalTo(weakSelf).with.offset(20);
    }];
    
    [self.imgName setText:_model.describe];
    
}
@end

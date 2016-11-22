//
//  ZRPictureColl.m
//  zhiruProduct
//
//  Created by pj on 16/9/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPictureColl.h"

@implementation ZRPictureColl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.imgView setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:_imgView];
        
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        [self.backView setBackgroundColor:[UIColor blackColor]];
        [self.backView setAlpha:0.3];
        [self.imgView addSubview:_backView];
        
        self.imgName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, _backView.frame.size.width - 20, 30)];
        [self.imgName setTextColor:[UIColor whiteColor]];
        [self.imgName setFont:[UIFont systemFontOfSize:14]];
        [self.backView addSubview:_imgName];
    }
    return self;
}

- (void)setModel:(ZRPhotosModel *)model
{
    _model = model;
    [self.imgName setText:_model.describe];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.img_url] placeholderImage:ZRPlaceholderImage];
    
}

@end

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
        [self setViewMasonary];
    }
    return self;
}
- (void)createView
{
    self.imgView = [[UIImageView alloc] init];
//    [self.imgView setImage:ZRPlaceholderImage];
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
- (void)setViewMasonary
{
    WS(weakSelf);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
//        make.width.mas_equalTo(ScreenWidth);
//        make.height.mas_equalTo(height);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.bottom.equalTo(weakSelf).with.offset(-10);
    }];
    [self.imgName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.timeLabel.mas_top).with.offset(-5);
        make.left.equalTo(weakSelf).with.offset(20);
    }];
}
- (void)setModel:(ZRPhotosModel *)model
{
    _model = model;
//    WS(weakSelf);
//    UIImage * image = [UIImage getImageFromURL:_model.img_url];
//    CGSize size = image.size;
//    CGFloat height;
//    if (image == nil) {
//        height = ScreenHeight - 64;
//    } else {
//        height = ScreenWidth / size.width * size.height;
//    }
//    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(weakSelf);
//        make.width.mas_equalTo(ScreenWidth);
//        make.height.mas_equalTo(height);
//    }];
//    [self.imgView setImage:image];
//    [self.imgView setImage:ZRPlaceholderImage];
    WS(ws);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.img_url] placeholderImage:ZRPlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"%@", [NSThread currentThread]);
        NSLog(@"%f %f", image.size.width, image.size.height);
        
        NSLog(@"%@ %@ %ld %@", image, error, cacheType, imageURL);
        NSLog(@"下载成功");
        if (image.size.width > ScreenWidth && image.size.height > ScreenHeight - 64) {
            [ws.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(ws);
                make.width.mas_equalTo(ScreenWidth);
                make.height.mas_equalTo(ScreenWidth / image.size.width * image.size.height);
            }];
        }
    }];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.img_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"%@", _model.img_url);
//        NSLog(@"%f==%f",image.size.height,image.size.width);
//        CGSize size = image.size;
//        CGFloat width;
//        CGFloat height;
//        if (size.width > ScreenWidth) {
//            width = ScreenWidth;
//            height = ScreenWidth / size.width * size.height;
//        }
//        
//        [ws.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(ws);
//            make.width.mas_equalTo(width);
//            make.height.mas_equalTo(height);
//        }];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            ws.imgView.image = image;
//            
//        });
//    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.bottom.equalTo(ws).with.offset(-10);
    }];
    [self.timeLabel setText:_model.create_date];
    
    [self.imgName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.timeLabel.mas_top).with.offset(-5);
        make.left.equalTo(ws).with.offset(20);
    }];
//    NSLog(@"名字: %@", _model.describe);
    [self.imgName setText:_model.describe];
    
}
@end

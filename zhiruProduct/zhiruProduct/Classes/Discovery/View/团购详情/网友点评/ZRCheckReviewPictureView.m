//
//  ZRCheckReviewPictureView.m
//  zhiruProduct
//
//  Created by nanding on 16/12/2.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRCheckReviewPictureView.h"

@interface ZRCheckReviewPictureView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ZRCheckReviewPictureView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}


-(void)setPicturesArray:(NSArray *)picturesArray
{
    _picturesArray = picturesArray;
    [SVProgressHUD show];
    
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.pageControl];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod)];
    [self addGestureRecognizer:tap];
    
}

#pragma mark - 懒加载
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.picturesArray.count, self.height);
        
        for (int i=0; i<self.picturesArray.count; i++) {
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:imgView];
            [SVProgressHUD dismiss];
            [imgView sd_setImageWithURL:self.picturesArray[i] placeholderImage:ZRImage(@"Default") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                CGFloat h = SCREEN_WIDTH*image.size.height/image.size.width;
                CGFloat y = (self.height-h)/2;
                imgView.frame = CGRectMake(i*SCREEN_WIDTH, y, SCREEN_WIDTH, h);
                
            }];
            
        }
        
    }
    return _scrollView;
}


-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height-30, SCREEN_WIDTH, 30)];
        _pageControl.numberOfPages = self.picturesArray.count;
        _pageControl.currentPage = self.curPage;
        
        self.scrollView.contentOffset = CGPointMake(_pageControl.currentPage*SCREEN_WIDTH, 0);
        [self addSubview:self.scrollView];
        _pageControl.hidesForSinglePage = YES;
        
    }
    return _pageControl;
}


#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == _scrollView) {
        _pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
        
    }
}


#pragma mark - click methods
- (void)tapMethod
{
    if ([self.delegate respondsToSelector:@selector(dismissView:)]) {
        [self.delegate dismissView:self];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

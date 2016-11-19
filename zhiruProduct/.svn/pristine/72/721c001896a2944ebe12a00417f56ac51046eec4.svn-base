//
//  ZRTabBar.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//



#import "ZRTabBar.h"
#import "ZRTabBarButton.h"
@interface ZRTabBar ()


@property (nonatomic, weak) UIView * btnBG;

@end

@implementation ZRTabBar



- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark -- 创建背景样式
- (void)createBackgroude{
    
    UIView* btnBG = [[UIView alloc] init];
    [btnBG setFrame:CGRectMake(0, 0, self.width, self.height)];
    
    [btnBG setBackgroundColor:[UIColor whiteColor]];
    
    btnBG.userInteractionEnabled = YES;
    [self addSubview:btnBG];
    _btnBG = btnBG;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [btnBG addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (btnBG.mas_left);
        make.top.equalTo (btnBG.mas_top);
        make.right.equalTo (btnBG.mas_right);
        make.height.equalTo(@1);
    }];
    
}

//赋值
-(void)setItems:(NSArray *)items{
    _items = items;
    
    // 把之前的全部干掉
    for (UIView *childView in self.subviews) {
        [childView removeFromSuperview];
    }
    
    [self createBackgroude];
    
    // 添加所有按钮
    for (int i = 0; i < _items.count; i++) {
        
        // 取出按钮对应的模型
        UITabBarItem *item = _items[i];
        
        // 创建按钮
        ZRTabBarButton *btn = [ZRTabBarButton buttonWithType:UIButtonTypeCustom];
        
      
        btn.tag = self.tabBarButtons.count;
        
        if (btn.tag == 0) { // 默认选中第一个
            [self btnClick:btn];
        }
        
//        if (btn.tag == 2 || btn.tag ==3) {
//            btn.tag++;
//        }
        
        
        // 传递模型
        btn.item = item;

        // 添加到控件
        [_btnBG addSubview:btn];
        
        // 监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        // 添加到数组
        [self.tabBarButtons addObject:btn];
        
    }
    
}

#pragma mark -点击按钮的时候调用
- (void)btnClick:(UIButton *)button
{
    _selectButton.selected = NO;
    button.selected = YES;
    _selectButton = button;
    
    
    // 点击tabBar上通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
        [_delegate tabBar:self didClickBtn:button];
    }
    
}


#pragma mark --设置 子控件frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    [self createBackgroude];
    // 布局普通的按钮
    CGFloat x = 0;
    CGFloat y = 0;
    // 包含tabBar上所有按钮对应的tabBarItem
    NSUInteger count = self.items.count;
//    CGFloat tabBarW = self.bounds.size.width;
    CGFloat w = self.bounds.size.width / count;
    CGFloat h = self.bounds.size.height;
    
    NSInteger i = 0;
    
    for (UIView *tabBarButton in self.tabBarButtons) {

        x = i * w;
        
        tabBarButton.frame = CGRectMake(x, y, w, h);
        i++;
    }
    
}

@end

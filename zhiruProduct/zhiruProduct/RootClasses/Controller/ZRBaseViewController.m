//
//  ZRBaseViewController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/23.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"

@interface ZRBaseViewController ()

@property (nonatomic,strong) UIImageView *baseNavImageView;  /**< 导航背景 */
@property (nonatomic,strong) UIButton *baseNavLeftBtn;  /**< 导航左按钮 */
@property (nonatomic,strong) UIButton *baseNavRightBtn;  /**<导航右按钮*/

@property (nonatomic,strong) UILabel *baseNavTitle;     /**< 导航标题 */
@end

@implementation ZRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //背景颜色
    //    self.view.backgroundColor = BackGroundColor;
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
//    {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        
//    }
//
    [self createLeftBtn];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)createLeftBtn{

    //创建 全局统一 按钮
    UIBarButtonItem * item = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"zuojiantou"] highImage:[UIImage imageNamed:@"zuojiantou"]  target:self action:@selector(navbanckBtnClick)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)createNavWithTitle: (NSString *)title
                andLeftImg: (NSString *)leftImg
              andLeftTitle: (NSString *)leftTitle
               andRightImg: (NSString *)rightImg
             andRightTitle: (NSString *)RightTitle
              andLeftClick: (void(^)()) leftClick
             andRightTitle: (void(^)()) rightClick{
    
    //保存点击事件
    self.baseLeftBtnClick = leftClick;
    self.baseRightBtnClick = rightClick;
    self.title = title;
    //创建按钮
    if (leftClick != nil) {
        self.baseNavLeftBtn = [MyControl createButtonWithFrame:CGRectMake(0, 20, 50, 44) ImageName:nil Target:self Action:@selector(baseNavLeftBtnClick) Title:nil];
        
        
        if (leftTitle != nil) {
            [self.baseNavLeftBtn setTitle:leftTitle forState:UIControlStateNormal];
            [self.baseNavLeftBtn setTitleColor:Color_Black forState:UIControlStateNormal];
            self.baseNavLeftBtn.titleLabel.font = CustomFont(Font_BtnTitle);
        }
        if (leftImg != nil) {
            

            [self.baseNavLeftBtn setImage:[UIImage imageNamed:leftImg] forState:UIControlStateNormal];
        }
        UIBarButtonItem * navBtn = [[UIBarButtonItem alloc] initWithCustomView:self.baseNavLeftBtn];
        self.navigationItem.leftBarButtonItem = navBtn;
    }
    
    
    if (rightClick != nil) {
        self.baseNavRightBtn = [MyControl createButtonWithFrame:CGRectMake(ScreenWidth-80, 20, 80, 44) ImageName:nil Target:self Action:@selector(baseNavRightBtnClick) Title:nil];
        //button 内的文字 左对齐 否则不好看
        self.baseNavRightBtn .contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.baseNavRightBtn .titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        if (RightTitle != nil) {
            [self.baseNavRightBtn setTitle:RightTitle forState:UIControlStateNormal];
            [self.baseNavRightBtn setTitleColor:Color_Black forState:UIControlStateNormal];
            self.baseNavRightBtn.titleLabel.font = CustomFont(Font_BtnTitle);
            
        }
        if (rightImg != nil) {
            [self.baseNavRightBtn setImage:[UIImage imageNamed:rightImg] forState:UIControlStateNormal];
        }
        UIBarButtonItem * navBtn = [[UIBarButtonItem alloc] initWithCustomView:self.baseNavRightBtn];
        self.navigationItem.rightBarButtonItem = navBtn;
    }
    self.baseNavTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    self.baseNavTitle.center = CGPointMake(ScreenWidth/2.0, 20+22);
    self.baseNavTitle.text = title;
    self.baseNavTitle.textAlignment = NSTextAlignmentCenter;
    self.baseNavTitle.font = CustomFont(Font_NavTitle);
    self.baseNavTitle.textColor = Color_Purple;
}

- (void)navbanckBtnClick
{
        
        //执行block
        [self baseNavLeftBtnClick];
        
        [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)baseNavRightBtnClick{
    if (self.baseRightBtnClick) {
        self.baseRightBtnClick();
    }
}

- (void)baseNavLeftBtnClick{
    if (self.baseLeftBtnClick) {
        self.baseLeftBtnClick();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

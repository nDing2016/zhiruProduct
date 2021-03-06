//
//  ZRMyPageController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/23.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMyPageController.h"
#import "ZRMyPageHeaderView.h"
#import "ZRMyPageTableViewCell.h"
#import "ZRLoginViewController.h"
#import "ZRNavigationController.h"
#import "ZRUserInformationViewController.h"
#import "ZRMyWalletViewController.h"
#import "ZRPointsViewController.h"
#import "ZRMyOrderViewController.h"
#import "ZRNeedCommentRootController.h"
#import "ZRStoreupRootViewController.h"
#import "ZRShoppingCarController.h"
#import "ZRSettingController.h"
#import "ZRMessageController.h"
#import "ZRUserTool.h"
#import "ZRUser.h"
#import "ZRTabBarViewController.h"
#import "ZRTabBar.h"
#import "ZRGroupBuyingTicketController.h"
#import "ZRWeController.h"
#import "ZRRefundStateController.h"
#import "ZRContanMeController.h"
#import "ZRCooperateController.h"
#import "ZRStorePictureController.h"
#import "ZROrderingEvaluateController.h"
#import "ZRRechargeOrderController.h"
#import "ZRMyCommentController.h"
#import "ZRStoreupShopController.h"
#import "ZRUserInterfaceModel.h"
@interface ZRMyPageController ()<UITableViewDelegate, UITableViewDataSource, userInfoDelegate, loginDelegate>


@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)NSArray * contentArray;

@property (nonatomic, strong) NSArray *contentImageArray;

@property (nonatomic, strong)ZRMyPageHeaderView * headerView;

@property (nonatomic, strong)UIButton * rightBtn;
@end

@implementation ZRMyPageController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userExit" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userExitLogin" object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_queue_t quede = dispatch_queue_create("com.pj.userMessage", DISPATCH_QUEUE_CONCURRENT);
//     异步函数
    dispatch_async(quede, ^{
        [ZRUserInterfaceModel userGetMessageNumCallBack:^(id result) {
            NSDictionary * dict = result;
            if ([dict[@"code"] isEqualToString:@"S000"] && [dict[@"message"] isEqualToString:@"success"]) {
                // 回到主线程, 刷新UI
                NSString * data = dict[@"data"];
                if (data.integerValue > 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_rightBtn setImage:[UIImage imageNamed:@"xinfeng-dian"] forState:UIControlStateNormal];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_rightBtn setImage:[UIImage imageNamed:@"xinfeng"] forState:UIControlStateNormal];
                    });
                }
            }
        } Failure:^(id error) {

        }];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
     
    
    // 创建左按钮: 联系我们
    [self createNavigationLeftButton];
    // 创建右按钮: 推送消息记录
    [self createNavigationRightButton];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self getUserInfo];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userExit:)
                                                 name:@"userExit"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userExitLogin:)
                                                 name:@"userExitLogin"
                                               object:nil];
}
- (void)userExit:(NSNotification *)notification
{
    if([notification object] != nil)
    {
        NSString *str = [notification object];
        if ([str isEqualToString:@"1"]) {
            [self getUserInfo];
        }
    }
}
- (void)userExitLogin:(NSNotification *)notification
{
    if([notification object] != nil)
    {
        NSString *str = [notification object];
        if ([str isEqualToString:@"1"]) {
            [self.headerView.userNameLabel setText:@"点击登录"];
            [self.headerView.vipLabel setText:@""];
            [self.headerView.headerImageView setImage:ZRImage(@"placeHeader")];
        }
    }
}
- (void)getUserInfo
{
    ZRUser * user = [ZRUserTool user];
    if (user == nil) {
        [self.headerView.userNameLabel setText:@"点击登录"];
        [self.headerView.vipLabel setText:@""];
        [self.headerView.headerImageView setImage:ZRImage(@"placeHeader")];
        
        ZRLoginViewController * loginVC = [[ZRLoginViewController alloc] init];
        loginVC.delegate = self;
        ZRNavigationController * loginVCNav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginVCNav animated:YES completion:nil];
    } else {
        [self.headerView.userNameLabel setText:user.name];



//        self.headerView.headerImageView.image = [UIImage getImageFromURL:user.head_url];

        if ([user.is_vip isEqualToString:@"1"]) {
            [self.headerView.vipLabel setText:@"vip1"];
        } else if ([user.is_vip isEqualToString:@"2"]) {
            [self.headerView.vipLabel setText:@"vip2"];
        }
        
        if (user.head_url.length != 0) {
            dispatch_queue_t queue = dispatch_queue_create("com.pj.downloadImage", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                NSURL * url = [NSURL URLWithString:user.head_url];
                NSData * data = [NSData dataWithContentsOfURL:url];
                UIImage * image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.headerView.headerImageView.image = image;
                });
            });
        }
    }
}
- (NSArray *)contentArray
{
    if (_contentArray == nil) {
        _contentArray = [NSArray arrayWithObjects:@"我的订单",@"我的点评", @"待点评",@"我的收藏",@"我的团购券",@"我的购物车", nil];
    }
    return _contentArray;
}



-(NSArray *)contentImageArray
{
    if (!_contentImageArray) {
        _contentImageArray = @[ZRImage(@"wodedingdan"),ZRImage(@"wodedianping"),ZRImage(@"daidianping"),ZRImage(@"wodeshouchang"),ZRImage(@"wodetuangouquan"),ZRImage(@"wodegouwuche")];
    }
    return _contentImageArray;
}



- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 44) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView setBackgroundColor:RGBCOLOR(240, 240, 240)];
        self.headerView = [[ZRMyPageHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 145.0 / 667.0 * ScreenHeight)];
        _tableView.tableHeaderView = self.headerView;
        
        [self.headerView.headerButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView.footerView1.contentButton addTarget:self action:@selector(actionContentButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView.footerView2.contentButton addTarget:self action:@selector(actionContentButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView.footerView3.contentButton addTarget:self action:@selector(actionContentButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView * view = [[UIView alloc] init];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (void)createNavigationLeftButton
{
    UIButton * leftButton = [MyControl createButtonWithFrame:CGRectMake(0, 0, 60, 40) ImageName:nil Target:self Action:@selector(contactMe) Title:@"联系我们"];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftButton setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
// 联系我们
- (void)contactMe
{
    ZRContanMeController * contanMe = [[ZRContanMeController alloc] init];
    [self.navigationController pushViewController:contanMe animated:YES];
}
- (void)createNavigationRightButton
{
    UIButton * rightButton = [MyControl createButtonWithFrame:CGRectMake(0, 0, 50, 40) ImageName:nil Target:self Action:@selector(pushMessage) Title:nil];
    [rightButton setImage:[UIImage imageNamed:@"xinfeng"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    _rightBtn = rightButton;
}

- (void)pushMessage
{
    ZRUser * user = [ZRUserTool user];
    if (user == nil) {
        ZRLoginViewController * loginVC = [[ZRLoginViewController alloc] init];
        loginVC.delegate = self;
        ZRNavigationController * loginVCNav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginVCNav animated:YES completion:nil];
    } else {
        ZRMessageController * messageVC = [[ZRMessageController alloc] init];
        [self.navigationController pushViewController:messageVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.contentArray.count;
    } else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0 / 667.0 * ScreenHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0 / 667.0 * ScreenHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * myConsumptionInformation = @"myConsumptionInformation";// 消费信息
    static NSString * mySettings = @"mySettings";// 设置
    static NSString * myCooperation = @"myCooperation";// 合作
    
    if (indexPath.section == 0) {
        ZRMyPageTableViewCell * myConsumptionInformationCell = [tableView dequeueReusableCellWithIdentifier:myConsumptionInformation];
        if (myConsumptionInformationCell == nil) {
            myConsumptionInformationCell = [[ZRMyPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myConsumptionInformation];
        }
        [myConsumptionInformationCell.identificationLabel setText:[_contentArray objectAtIndex:indexPath.row]];
        
        myConsumptionInformationCell.identificationImage.image = self.contentImageArray[indexPath.row];
        return myConsumptionInformationCell;
    } else if (indexPath.section == 1) {
        ZRMyPageTableViewCell * mySettingsCell = [tableView dequeueReusableCellWithIdentifier:mySettings];
        if (mySettingsCell == nil) {
            mySettingsCell = [[ZRMyPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mySettings];
        }
        [mySettingsCell.identificationLabel setText:@"关于我们"];
        mySettingsCell.identificationImage.image = ZRImage(@"shezhi");
        return mySettingsCell;
    } else {
        ZRMyPageTableViewCell * myCooperationCell = [tableView dequeueReusableCellWithIdentifier:myCooperation];
        if (myCooperationCell == nil) {
            myCooperationCell = [[ZRMyPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCooperation];
        }
        [myCooperationCell.identificationLabel setText:@"合作"];
        myCooperationCell.identificationImage.image = ZRImage(@"hezuo");
        return myCooperationCell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZRUser * user = [ZRUserTool user];
        if (user == nil) {
            [ZRUserTool saveAccount:nil];
            ZRLoginViewController * loginVC = [[ZRLoginViewController alloc] init];
            loginVC.delegate = self;
            ZRNavigationController * loginVCNav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:loginVCNav animated:YES completion:nil];
        } else {
            if (indexPath.row == 0) {
                //NSLog(@"我的订单");
                ZRMyOrderViewController * myOrderVC = [[ZRMyOrderViewController alloc] init];
                [self.navigationController pushViewController:myOrderVC animated:YES];
            } else if (indexPath.row == 1) {
                //NSLog(@"我的点评");
                ZRMyCommentController *myCommentVC = [[ZRMyCommentController alloc] init];
                [self.navigationController pushViewController:myCommentVC animated:YES];
                
            } else if (indexPath.row == 2) {
                //NSLog(@"待点评");
                ZRNeedCommentRootController * needCommentVC = [[ZRNeedCommentRootController alloc] init];
                [self.navigationController pushViewController:needCommentVC animated:YES];
            } else if (indexPath.row == 3) {
                //NSLog(@"我的收藏");
                //                ZRStoreupRootViewController * storupVC = [[ZRStoreupRootViewController alloc] init];
                ZRStoreupShopController * storupVC = [[ZRStoreupShopController alloc] init];
                [storupVC setTitle:@"我的收藏"];
                [self.navigationController pushViewController:storupVC animated:YES];
            } else if (indexPath.row == 4) {
                //NSLog(@"我的团购券");
                ZRGroupBuyingTicketController * ticketVC = [[ZRGroupBuyingTicketController alloc] init];
                [self.navigationController pushViewController:ticketVC animated:YES];
            } else if (indexPath.row == 5) {
                //NSLog(@"我的购物车");
                ZRShoppingCarController * shoppingCar = [[ZRShoppingCarController alloc] init];
                shoppingCar.pushSource = @"我的";
                [self.navigationController pushViewController:shoppingCar animated:YES];
            }
        }
    } else if (indexPath.section == 1) {
        ZRWeController * settingVC = [[ZRWeController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    } else if (indexPath.section == 2) {
        ZRCooperateController * cooperateVC = [[ZRCooperateController alloc] init];
        [self.navigationController pushViewController:cooperateVC animated:YES];
    }
}
// 点击头部的点击登录
- (void)loginButtonClick
{
    ZRUser * user = [ZRUserTool user];
    if (user == nil) {
        ZRLoginViewController * loginVC = [[ZRLoginViewController alloc] init];
        loginVC.delegate = self;
        ZRNavigationController * loginVCNav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginVCNav animated:YES completion:nil];
    } else {
        ZRUserInformationViewController * userInforVC = [[ZRUserInformationViewController alloc] init];
        userInforVC.image = self.headerView.headerImageView.image;
        userInforVC.delegate = self;
        [self.navigationController pushViewController:userInforVC animated:YES];
    }
}
- (void)userLogin
{
    [self getUserInfo];
}
- (void)submitUserInfo
{
    [AlertText showAndText:@"用户信息修改成功"];
    [self getUserInfo];
}
- (void)exitUserLogin
{
    [self.headerView.headerImageView setImage:ZRImage(@"default_head")];
    [self.headerView.userNameLabel setText:@"点击登录"];
    [self.headerView.vipLabel setText:nil];
}
- (void)actionContentButton:(UIButton *)sender
{
    // 积分商城
    if (sender.tag == 3000) {
        ZRTabBarViewController *tab = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UIButton * sender = [tab.rootTabBar.tabBarButtons objectAtIndex:1];
        tab.rootTabBar.selectButton.selected = NO;
        sender.selected = YES;
        tab.rootTabBar.selectButton = sender;
        if ([tab.rootTabBar.delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
            [tab.rootTabBar.delegate tabBar:tab.rootTabBar didClickBtn:sender];
        }
    } else {
        ZRUser * user = [ZRUserTool user];
        if (user == nil) {
            [ZRUserTool saveAccount:nil];
            ZRLoginViewController * loginVC = [[ZRLoginViewController alloc] init];
            loginVC.delegate = self;
            ZRNavigationController * loginVCNav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:loginVCNav animated:YES completion:nil];
        } else {
            // 我的钱包
            if (sender.tag == 1000) {
                ZRMyWalletViewController * myWallet = [[ZRMyWalletViewController alloc] init];
                [self.navigationController pushViewController:myWallet animated:YES];
            // 我的积分
            } else if (sender.tag == 2000) {
                ZRPointsViewController * pointVC = [[ZRPointsViewController alloc] init];
                [self.navigationController pushViewController:pointVC animated:YES];
            }
        }
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

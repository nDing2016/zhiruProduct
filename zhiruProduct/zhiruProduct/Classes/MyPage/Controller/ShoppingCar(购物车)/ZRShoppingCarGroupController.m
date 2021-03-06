//
//  ZRShoppingCarGroupController.m
//  zhiruProduct
//
//  Created by pj on 16/9/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShoppingCarGroupController.h"
#import "ZRShoppingCarFooterView.h"
#import "ZRShoppingHeaderView.h"
#import "ZRShoppingCarTuanCell.h"
#import "ZRUserShoppingCarRequest.h"
#import "ZRShoppingCarModel.h"
#import "ZRShoppingCarDetailModel.h"
#import "ZRProductDetailsController.h"
#import "ZRTabBarViewController.h"
#import "ZRNavigationController.h"
#import "ZRShoppingCarController.h"
#import "ZRGroupBuyingDetailsController.h"
#import "ZRShoppingGroupOrderController.h"
@interface ZRShoppingCarGroupController ()<footSelectButtonDelegate, UITableViewDelegate, UITableViewDataSource, ShoppingCarGroupCellDelegate, ZRShoppingHeaderViewDelegate>

@property (nonatomic, strong)ZRShoppingCarFooterView * footView;
@property (nonatomic, strong)UITableView * groupTableView;

//@property (nonatomic, strong)NSMutableArray * arrayList;
//@property (nonatomic, strong)NSMutableArray * stateList;
//@property (nonatomic, assign)BOOL tableViewState;

@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, assign)BOOL isUploading;

@property (nonatomic, strong)dispatch_queue_t queue;


@property (nonatomic, assign)CGFloat allMoney;
@property (nonatomic, strong)NSMutableArray * allArray;


@end

@implementation ZRShoppingCarGroupController
/*
 团购
 */

- (UITableView *)groupTableView
{
    if (_groupTableView == nil) {
        _groupTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50 - 50) style:UITableViewStylePlain];
        [_groupTableView setDelegate:self];
        [_groupTableView setDataSource:self];
        UIView * view = [UIView new];
        _groupTableView.tableFooterView = view;
    }
    return _groupTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.allArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    self.queue = dispatch_queue_create("com.pj.doenload", DISPATCH_QUEUE_CONCURRENT);
    
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    [self.view addSubview:self.groupTableView];
    
    [self createFooterView];
    [self addHeaderRequest];
}
// 下拉刷新
- (void)addHeaderRequest
{
//    self.groupTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        self.isUploading = YES;
//        [self loadRequest];
//    }];
//    [self.groupTableView.mj_header beginRefreshing];
    
    [self.groupTableView startRefreshWithCallback:^{
        self.isUploading = YES;
        [self loadRequest];
    }];
}
// 数据请求
- (void)loadRequest
{
    [ZRUserShoppingCarRequest groupShoppingCarCallBack:^(NSMutableArray *array) {
        if (self.isUploading == YES) {
            [self.dataArray removeAllObjects];
        }
        self.allMoney = 0;
        [self.allArray removeAllObjects];
        [self.footView.moneyLabel setText:@"$0.00"];
        self.dataArray = array;
        [self.groupTableView.mj_header endRefreshing];
        [self.groupTableView reloadData];
    } Failure:^(id error) {
        
        
    }];
}
// 创建底部结算tabbar
- (void)createFooterView
{
    self.footView = [[ZRShoppingCarFooterView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 50 - 64 - 50, ScreenWidth, 50)];
    self.footView.delegate = self;
    [self.view addSubview:self.footView];
}
// 选择底部选择按钮
- (void)footViewSlelectButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self.allArray removeAllObjects];
    self.allMoney = 0.0;
    for (ZRShoppingCarModel * model in self.dataArray) {
        model.headerSelectState = sender.selected;
        for (ZRShoppingCarDetailModel * detailModel in model.groupList) {
            detailModel.state = sender.selected;
            if (sender.selected == YES) {
                [self.allArray addObject:detailModel];
                int num = detailModel.num.intValue;
                CGFloat nowPrice = detailModel.nowPrice.floatValue;
                CGFloat money = num * nowPrice;
                self.allMoney += money;
            }
        }
    }
    [self.footView.moneyLabel setText:[NSString stringWithFormat:@"$%.2f", self.allMoney]];
    [self.groupTableView reloadData];
}
// 结算+删除
- (void)footViewClearingButton:(UIButton *)sender
{
    if (sender.selected == NO) {
        if (self.allArray.count == 0) {
            [AlertText showAndText:@"未选择商品"];
        } else {
            ZRShoppingGroupOrderController * groupVC = [[ZRShoppingGroupOrderController alloc] init];
            groupVC.allMoney = self.allMoney;
            groupVC.allArray = self.allArray;
            ZRTabBarViewController * tabBar = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            ZRNavigationController * nav = tabBar.viewControllers[2];
            ZRShoppingCarController * shoppingCar = nav.viewControllers[1];
            [shoppingCar.navigationController pushViewController:groupVC animated:YES];
        }
    } else {
        NSMutableArray * deleteArray = [NSMutableArray array];
        for (ZRShoppingCarDetailModel * model in self.allArray) {
            NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:model.groupId,@"groupId",model.businessId,@"businessId", nil];
            [deleteArray addObject:dict];
        }
        [ZRUserShoppingCarRequest groupDeleteShoppingCarList:deleteArray CallBack:^(NSString *message) {
            if ([message isEqualToString:@"success"]) {
                [self loadRequest];
                
                for (ZRShoppingCarDetailModel * model in self.allArray) {
                    [self deleteReloadFootMoneyLabel:model];
                }
                [self.allArray removeAllObjects];
                [AlertText showAndText:message];
            }
        } Failure:^(id error) {
            [AlertText showAndText:@"删除失败"];
        }];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZRShoppingCarModel * model = [self.dataArray objectAtIndex:section];
    return model.groupList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZRShoppingHeaderView * headerView = [[ZRShoppingHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    headerView.tag = section;
    headerView.selectButton.tag = section;
    headerView.edtintButton.tag = section;
    headerView.section = section;
    headerView.delegate = self;
    //NSLog(@"tag: %ld %ld", (long)headerView.selectButton.tag, headerView.edtintButton.tag);
    [headerView.selectButton addTarget:self action:@selector(actionHeaderSelectButtons:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.edtintButton addTarget:self action:@selector(actionEdtintButon:) forControlEvents:UIControlEventTouchUpInside];
    ZRShoppingCarModel * model = [self.dataArray objectAtIndex:section];
    headerView.model = model;
    return headerView;
}

/*
 点击区头跳转店铺详情
 */
- (void)actionSectionHeaderView:(NSInteger)section
{
    ZRShoppingCarModel * model = [self.dataArray objectAtIndex:section];
    ZRShoppingCarDetailModel * detailModel = [model.groupList lastObject];
    ZRProductDetailsController * detailVC = [[ZRProductDetailsController alloc] init];
    detailVC.businessId = detailModel.businessId;
    ZRTabBarViewController * tabBar = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    ZRNavigationController * nav = tabBar.viewControllers[2];
    ZRShoppingCarController * shoppingCar = nav.viewControllers[1];
    [shoppingCar.navigationController pushViewController:detailVC animated:YES];
}
// 区头的全选框
- (void)actionHeaderSelectButtons:(UIButton *)sender
{
    if (sender.selected == NO) {
        ZRShoppingCarModel * model = [self.dataArray objectAtIndex:sender.tag];
        model.headerSelectState = YES;
        for (ZRShoppingCarDetailModel * detailModel in model.groupList) {
            detailModel.state = model.headerSelectState;
            if (![self.allArray containsObject:detailModel]) {
                [self.allArray addObject:detailModel];
                [self addReloadFootMoneyLabel:detailModel];
            }
        }
    } else if (sender.selected == YES) {
        ZRShoppingCarModel * model = [self.dataArray objectAtIndex:sender.tag];
        model.headerSelectState = NO;
        for (ZRShoppingCarDetailModel * detailModel in model.groupList) {
            detailModel.state = model.headerSelectState;
            if ([self.allArray containsObject:detailModel]) {
                [self.allArray removeObject:detailModel];
                [self deleteReloadFootMoneyLabel:detailModel];
            }
        }
    }
    [self.groupTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
}
// 区头的编辑按钮
- (void)actionEdtintButon:(UIButton *)sender
{
    ZRShoppingCarModel * model = [self.dataArray objectAtIndex:sender.tag];
    model.editingState = !sender.selected;
    for (ZRShoppingCarDetailModel * detailModel in model.groupList) {
        detailModel.edtitngState = model.editingState;
    }
    [self.groupTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"groupCellID";
    ZRShoppingCarTuanCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ZRShoppingCarTuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.section = indexPath.section;
    cell.row = indexPath.row;
    cell.delegate = self;
    ZRShoppingCarModel * model = [self.dataArray objectAtIndex:indexPath.section];
    ZRShoppingCarDetailModel * detailModel = [model.groupList objectAtIndex:indexPath.row];
    cell.model = detailModel;
    return cell;
}
/*
 cell点击方法
 跳转到团购详情
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.state == NO) {
        ZRGroupBuyingDetailsController * detailVC = [[ZRGroupBuyingDetailsController alloc] init];
        ZRTabBarViewController * tabBar = (ZRTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        ZRNavigationController * nav = tabBar.viewControllers[2];
        ZRShoppingCarController * shoppingCar = nav.viewControllers[1];
        [shoppingCar.navigationController pushViewController:detailVC animated:YES];
    }
}
// 点击cell上的选择按钮
- (void)selectButtonClick:(UIButton *)sender andSection:(NSInteger)section andRow:(NSInteger)row
{
    ZRShoppingCarModel * model = [self.dataArray objectAtIndex:section];
    ZRShoppingCarDetailModel * detailModel = [model.groupList objectAtIndex:row];
    detailModel.state = !sender.selected;
    
    // 点击之后是选择状态: 添加到数组, 点击之后是未选择状态: 从数组移除
    if (detailModel.state == YES) {
        [self.allArray addObject:detailModel];
        [self addReloadFootMoneyLabel:detailModel];
    } else {
        [self.allArray removeObject:detailModel];
        [self deleteReloadFootMoneyLabel:detailModel];
    }
    // 刷新当前cell
    NSIndexPath * path = [NSIndexPath indexPathForRow:row inSection:section];
    [self.groupTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
}
// 减
- (void)deleteGroupNumSection:(NSInteger)section andRow:(NSInteger)row
{
    //NSLog(@"减: section: %ld row: %ld", (long)section, row);
    ZRShoppingCarModel * model = [self.dataArray objectAtIndex:section];
    ZRShoppingCarDetailModel * detailModel = [model.groupList objectAtIndex:row];
    NSInteger number = detailModel.num.integerValue;
    if (number == 1) {
        [AlertText showAndText:@"不能再少了"];
    } else {
        number--;
        detailModel.num = [NSString stringWithFormat:@"%ld", (long)number];
        
        
        dispatch_async(self.queue, ^{
           [ZRUserShoppingCarRequest groupAddShoppingCarGroupID:detailModel.groupId Number:detailModel.num BusinessID:detailModel.businessId CallBack:^(NSString *message) {
               
               [self.allArray removeAllObjects];
               self.allMoney = 0;
               [self.footView.moneyLabel setText:@"$0.00"];
               for (ZRShoppingCarModel * sectionModel in self.dataArray) {
                   for (ZRShoppingCarDetailModel * cellModel in sectionModel.groupList) {
                       if (cellModel.state == YES) {
                           [self.allArray addObject:cellModel];
                           [self addReloadFootMoneyLabel:cellModel];
                       }
                   }
               }
               
           } Failure:^(id error) {
               
           }];
        });
        dispatch_barrier_async(self.queue, ^{
            //NSLog(@"拦截");
        });
        NSIndexPath * path = [NSIndexPath indexPathForRow:row inSection:section];
        [self.groupTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
        //NSLog(@"数组个数: %ld", (unsigned long)self.allArray.count);
    }
}
// 加
- (void)addGroupNumSection:(NSInteger)section andRow:(NSInteger)row
{
    //NSLog(@"加: section: %ld row: %ld", (long)section, row);
    ZRShoppingCarModel * model = [self.dataArray objectAtIndex:section];
    ZRShoppingCarDetailModel * detailModel = [model.groupList objectAtIndex:row];
    NSInteger number = detailModel.num.integerValue;
    number++;
    detailModel.num = [NSString stringWithFormat:@"%ld", (long)number];
    NSIndexPath * path = [NSIndexPath indexPathForRow:row inSection:section];
    [self.groupTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
    [ZRUserShoppingCarRequest groupAddShoppingCarGroupID:detailModel.groupId Number:detailModel.num BusinessID:detailModel.businessId CallBack:^(NSString *message) {
        //NSLog(@"添加成功---%@", detailModel.num);
        [self.allArray removeAllObjects];
        self.allMoney = 0;
        [self.footView.moneyLabel setText:@"$0.00"];
        for (ZRShoppingCarModel * sectionModel in self.dataArray) {
            for (ZRShoppingCarDetailModel * cellModel in sectionModel.groupList) {
                if (cellModel.state == YES) {
                    [self.allArray addObject:cellModel];
                    [self addReloadFootMoneyLabel:cellModel];
                }
            }
        }
        //NSLog(@"数组个数: %ld", (unsigned long)self.allArray.count);
    } Failure:^(id error) {
        
        
    }];
//    NSIndexPath * path = [NSIndexPath indexPathForRow:row inSection:section];
//    [self.groupTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
}
// tableView编辑
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        ZRShoppingCarModel * model = [self.dataArray objectAtIndex:indexPath.section];
        ZRShoppingCarDetailModel * detailModel = [model.groupList objectAtIndex:indexPath.row];
        NSString * groupID = detailModel.groupId;
        NSString * businessID = detailModel.businessId;
        //NSLog(@"%@ %@", groupID, businessID);
        NSMutableArray * listArray = [NSMutableArray array];
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:detailModel.groupId,@"groupId",detailModel.businessId,@"businessId", nil];
        [listArray addObject:dic];
        [ZRUserShoppingCarRequest groupDeleteShoppingCarList:listArray CallBack:^(NSString *message) {
            [AlertText showAndText:message];
        } Failure:^(id error) {
            //NSLog(@"%@", error);
        }];
        NSMutableArray * array = (NSMutableArray *)model.groupList;
        // 删除某一行
        [array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        if (array.count == 0) {
            // 删除某一区
        [self.dataArray removeObjectAtIndex:indexPath.section];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationRight];
        }
    }
    [tableView reloadData];
}
- (void)setState:(BOOL)state
{
    _state = state;
    if (_state == YES) {
        for (ZRShoppingCarModel * model in self.dataArray) {
            model.editingState = YES;
            for (ZRShoppingCarDetailModel * detailModel in model.groupList) {
                detailModel.edtitngState = YES;
            }
        }
        [self.footView.moneyLabel setHidden:YES];
        [self.footView.titleLabel setHidden:YES];
        self.footView.clearingState = YES;
        [self.groupTableView reloadData];
    } else if (_state == NO) {
        for (ZRShoppingCarModel * model in self.dataArray) {
            model.editingState = NO;
            for (ZRShoppingCarDetailModel * detailModel in model.groupList) {
                detailModel.edtitngState = NO;
            }
        }
        [self.footView.moneyLabel setHidden:NO];
        [self.footView.titleLabel setHidden:NO];
        self.footView.clearingState = NO;
        [self.groupTableView reloadData];
    }
}
- (void)addReloadFootMoneyLabel:(ZRShoppingCarDetailModel *)detailModel
{
    int number = detailModel.num.intValue;
    CGFloat nowPrice = detailModel.nowPrice.floatValue;
    CGFloat money = number * nowPrice;
    self.allMoney += money;
    [self.footView.moneyLabel setText:[NSString stringWithFormat:@"$%.2f", self.allMoney]];
}
- (void)deleteReloadFootMoneyLabel:(ZRShoppingCarDetailModel *)detailModel
{
    int number = detailModel.num.intValue;
    CGFloat nowPrice = detailModel.nowPrice.floatValue;
    CGFloat money = number * nowPrice;
    self.allMoney -= money;
    [self.footView.moneyLabel setText:[NSString stringWithFormat:@"$%.2f", self.allMoney]];
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

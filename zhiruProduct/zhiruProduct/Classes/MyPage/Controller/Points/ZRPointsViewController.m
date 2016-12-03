//
//  ZRPointsViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointsViewController.h"
#import "ZRPointsHeaderView.h"
//#import "ZRSectionHeaderView.h"
//#import "ZRPointDetailView.h"
#import "ZRPointDeatilTableViewCell.h"
#import "ZRPointExchangeTableViewCell.h"
#import "ZRUserPointsRequest.h"
#import "ZRPointsModel.h"
#import "ZRPointsAllModel.h"
#import "ZRPointsDeatilModel.h"
#import "ZRExchangeModel.h"
#import "ZRExchangAllModel.h"
#import "ZRExchangeDetailModel.h"
#import "ZRProductDetalController.h"
#import "ZRPointsRuleController.h"
@interface ZRPointsViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView * scrollView;
@property (nonatomic, strong)UITableView * pointTableView;
@property (nonatomic, strong)ZRPointsHeaderView * headerView;
//@property (nonatomic, strong)ZRSectionHeaderView * sectionView;
//@property (nonatomic, strong)ZRPointDetailView * pointCell;
@property (nonatomic, assign)NSInteger state;

@property (nonatomic, strong)NSMutableArray * pointsArray;
@property (nonatomic, strong)NSMutableArray * exchangeArray;

@property (nonatomic, assign)NSInteger pointsPage;
@property (nonatomic, assign)BOOL pointsUpLoading;
@property (nonatomic, assign)NSInteger exchangePage;
@property (nonatomic, assign)BOOL exchangeUpLoading;

@property (nonatomic, strong)UIImageView * promptImg;
@end

@implementation ZRPointsViewController

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = NO;
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    self.navigationController.navigationBar.translucent = YES;
//}
- (UITableView *)pointTableView
{
    if (_pointTableView == nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        [self.view addSubview:_scrollView];
        [self.scrollView setContentSize:CGSizeMake(0, ScreenHeight - 64 + 175.0 / 667.0 * ScreenHeight)];
        [self.scrollView setBounces:NO];
        [self.scrollView setDelegate:self];
        
        self.headerView = [[ZRPointsHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40 + 175.0 / 667.0 * ScreenHeight)];
//        self.headerView = [[ZRPointsHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40 + 175.0)];
        [self.scrollView addSubview:self.headerView];
        [self.headerView.sectionHeaderView.pointDetailButton addTarget:self action:@selector(actionSectionHeaderView:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView.sectionHeaderView.pointExchangeButton addTarget:self action:@selector(actionSectionHeaderView:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _pointTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headerView.frame.size.height, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [self.scrollView addSubview:_pointTableView];
        [self.pointTableView setDelegate:self];
        [self.pointTableView setDataSource:self];
        [self.pointTableView setScrollEnabled:NO];
        
        UIView * view = [UIView new];
        [_pointTableView setTableFooterView:view];
    }
    return _pointTableView;
}
- (UIImageView *)promptImg
{
    if (_promptImg == nil) {
        _promptImg = [[UIImageView alloc] init];
        [self.view addSubview:_promptImg];
        
        CGFloat Y = 60.0 / 568.0 * ScreenHeight;
        WS(weakSelf);
        [_promptImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerView.mas_bottom).with.offset(Y);
            
//            make.centerY.mas_equalTo((ScreenHeight - weakSelf.headerView.frame.size.height) / 2.0);
            make.centerX.equalTo(weakSelf.view);
        }];
    }
    return _promptImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的积分"];
    
    self.pointsArray = [NSMutableArray array];
    self.exchangeArray = [NSMutableArray array];
    self.state = 1;
    [self addHeaderRefresh];
    [self addFooterRefresh];
    [self createRightNavigate];
}

- (void)addHeaderRefresh
{
    [self.pointTableView startRefreshWithCallback:^{
        if (self.state == 1) {
            self.pointsPage = 1;
            self.pointsUpLoading = YES;
            NSString * str = [NSString stringWithFormat:@"%ld",(long)self.pointsPage];
            [self getPointsDataList:str];
        } else {
            self.exchangePage = 1;
            self.exchangeUpLoading = YES;
            NSString * str = [NSString stringWithFormat:@"%ld",(long)self.exchangePage];
            [self getExchangePointDataList:str];
        }
    }];
}
- (void)addFooterRefresh
{
        self.pointTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{


            //NSLog(@"%ld", (long)self.state);

            if (self.state == 1) {
                self.pointsPage++;
                self.pointsUpLoading = NO;
                NSString * str = [NSString stringWithFormat:@"%ld", (long)self.pointsPage];
                [self getPointsDataList:str];
            } else {
                self.exchangePage++;
                self.exchangeUpLoading = NO;
                NSString * str2 = [NSString stringWithFormat:@"%ld", (long)self.exchangePage];
                [self getExchangePointDataList:str2];
            }
        }];    
}
- (void)getPointsDataList:(NSString *)page
{
    [ZRUserPointsRequest personPointsRows:@"6" page:page CallBack:^(NSMutableArray *array) {
        if (self.pointsUpLoading == YES) {
            [self.pointsArray removeAllObjects];
        }
        ZRPointsModel * model = [array objectAtIndex:0];
        for (ZRPointsAllModel * ml in model.personalPoints) {
            [self.pointsArray addObject:ml];
        }
        if (self.pointsArray.count == 0) {
            [self.scrollView setScrollEnabled:NO];
            [self.promptImg setHidden:NO];
            [self.promptImg setImage:[UIImage imageNamed:@"wuwodejifen-1"]];
        } else {
            [self.scrollView setScrollEnabled:YES];
            [self.promptImg setHidden:YES];
        }
        [self.pointTableView.mj_header endRefreshing];
        [self.pointTableView.mj_footer endRefreshing];
        [self.pointTableView reloadData];
        [self.headerView.pointLabel setText:model.allPoints];
        
        
    } Failure:^(id error) {
        
    }];
}
- (void)getExchangePointDataList:(NSString *)page
{
    [ZRUserPointsRequest pointExchangeRows:@"6" Page:page CallBack:^(NSMutableArray *array) {
        if (self.exchangeUpLoading == YES) {
            [self.exchangeArray removeAllObjects];
        }
        ZRExchangeModel * model = [array objectAtIndex:0];
        for (ZRExchangAllModel * ml in model.personalPoints) {
            [self.exchangeArray addObject:ml];
        }
        if (self.exchangeArray.count == 0) {
            [self.scrollView setScrollEnabled:NO];
            [self.promptImg setHidden:NO];
            [self.promptImg setImage:[UIImage imageNamed:@"wuduihuanjilu-1"]];
        } else {
            [self.scrollView setScrollEnabled:YES];
            [self.promptImg setHidden:YES];
        }
//        self.exchangeArray = (NSMutableArray *)model.personalPoints;
        [self.pointTableView.mj_header endRefreshing];
        [self.pointTableView.mj_footer endRefreshing];
        [self.pointTableView reloadData];
    } Failure:^(id error) {
        
    }];
}
- (void)createRightNavigate
{
    UIButton * button = [MyControl createButtonWithFrame:CGRectMake(0, 0, 60, 40) ImageName:nil Target:self Action:@selector(pointRule) Title:@"积分规则"];

    [button setTitleColor:R_G_B_16(0xff5252) forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
// 跳转至积分规则
- (void)pointRule
{
//    NSLog(@"积分规则");
    ZRPointsRuleController * pointRuleVC = [[ZRPointsRuleController alloc] init];
    [self.navigationController pushViewController:pointRuleVC animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.state == 1) {
//        ZRPointsModel * model = [self.pointsArray objectAtIndex:0];
        return self.pointsArray.count;
    } else {
//        ZRExchangeModel * model = [self.exchangeArray objectAtIndex:0];
        return self.exchangeArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.state == 1) {
        ZRPointsAllModel * model = [self.pointsArray objectAtIndex:section];
//        ZRPointsAllModel * ml = [model.personalPoints objectAtIndex:section];
        return model.list.count;
    } else {
        ZRExchangAllModel * model = [self.exchangeArray objectAtIndex:section];
//        ZRExchangAllModel * ml = [model.personalPoints objectAtIndex:section];
        return model.list.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 25)];
    [view setBackgroundColor:R_G_B_16(0xfafafa)];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 25)];
//    [label setText:@"2016年6月"];
    [label setFont:[UIFont systemFontOfSize:14]];
    [label setTextColor:R_G_B_16(0x555555)];
    [label setTextAlignment:NSTextAlignmentLeft];
    [view addSubview:label];
    if (self.state == 1) {
        ZRPointsAllModel * model = [self.pointsArray objectAtIndex:section];
//        ZRPointsAllModel * ml = [model.personalPoints objectAtIndex:section];
        [label setText:model.date];
    } else {
        ZRExchangAllModel * model = [self.exchangeArray objectAtIndex:section];
//        ZRExchangAllModel * ml = [model.personalPoints objectAtIndex:section];
        [label setText:model.date];
    }
    
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_state == 1) {
        static NSString * pointCellID = @"pointDetailCellID";
        ZRPointDeatilTableViewCell * pointCell = [tableView dequeueReusableCellWithIdentifier:pointCellID];
        if (pointCell == nil) {
            pointCell = [[ZRPointDeatilTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pointCellID];
        }
        ZRPointsAllModel * model = [self.pointsArray objectAtIndex:indexPath.section];
//        ZRPointsAllModel * ml = [model.personalPoints objectAtIndex:indexPath.section];
        pointCell.model = [model.list objectAtIndex:indexPath.row];
        
        [pointCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return pointCell;
    } else {
        static NSString * pointCellID = @"pointExchangeCellID";
        ZRPointExchangeTableViewCell * pointCell = [tableView dequeueReusableCellWithIdentifier:pointCellID];
        if (pointCell == nil) {
            pointCell = [[ZRPointExchangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pointCellID];
        }
        ZRExchangAllModel * model = [self.exchangeArray objectAtIndex:indexPath.section];
//        ZRExchangAllModel * ml = [model.personalPoints objectAtIndex:indexPath.section];
        pointCell.model = [model.list objectAtIndex:indexPath.row];
        [pointCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return pointCell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.state == 2) {
        ZRProductDetalController * productVC = [[ZRProductDetalController alloc] init];
        [self.navigationController pushViewController:productVC animated:YES];
    }
}
- (void)actionSectionHeaderView:(UIButton *)sender
{
    [self.promptImg setHidden:YES];
    if (sender.tag == 1000) {
        [self.headerView.sectionHeaderView.pointDetail.titleLabel setTextColor:R_G_B_16(0xffae02)];
        [self.headerView.sectionHeaderView.pointDetail.titleImage setImage:ZRImage(@"wdjfhuang")];
        [self.headerView.sectionHeaderView.pointExchange.titleLabel setTextColor:R_G_B_16(0x555555)];
        [self.headerView.sectionHeaderView.pointExchange.titleImage setImage:ZRImage(@"dhjlhui")];
        self.state = 1;
        [self addHeaderRefresh];
        [self.pointTableView reloadData];
//        NSString * page = [NSString stringWithFormat:@"%ld", self.pointsPage];
//        [self getPointsDataList:page];
    } else if (sender.tag == 2000) {
        [self.headerView.sectionHeaderView.pointDetail.titleLabel setTextColor:R_G_B_16(0x555555)];
        [self.headerView.sectionHeaderView.pointDetail.titleImage setImage:ZRImage(@"wdjfhui")];
        [self.headerView.sectionHeaderView.pointExchange.titleLabel setTextColor:R_G_B_16(0xffae02)];
        [self.headerView.sectionHeaderView.pointExchange.titleImage setImage:ZRImage(@"dhjlhuang")];
        
        self.state = 2;
//        NSString * page = [NSString stringWithFormat:@"%ld", self.exchangePage];
//        [self getExchangePointDataList:page];
        [self addHeaderRefresh];
        [self.pointTableView reloadData];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (ScreenHeight == 568.0) {
        if (scrollView == self.scrollView) {
            if (scrollView.contentOffset.y == 149.0) {
                [self.pointTableView setScrollEnabled:YES];
            } else {
                [self.pointTableView setScrollEnabled:NO];
            }
        }
    } else if (ScreenHeight == 667.0) {
        if (scrollView == self.scrollView) {
            if (scrollView.contentOffset.y == 175.0) {
                [self.pointTableView setScrollEnabled:YES];
            } else {
                [self.pointTableView setScrollEnabled:NO];
            }
        }
    } else if (ScreenHeight == 736.0) {
        if (scrollView == self.scrollView) {
            if (scrollView.contentOffset.y == 193.0) {
                [self.pointTableView setScrollEnabled:YES];
            } else {
                [self.pointTableView setScrollEnabled:NO];
            }
        }
    }
}


//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
//{
//    NSLog(@"scrollViewWillBeginDragging");
//    if (scrollView.contentOffset.y >= 130) {
//        //        [self.headerView.sectionHeaderView setFrame:CGRectMake(0, 64, ScreenWidth, 40)];
//        //        [self.headerView.sectionHeaderView setBounds:CGRectMake(0, 64, ScreenWidth, 40)];
//        [self.pointTableView setFrame:CGRectMake(0, -66, ScreenWidth, ScreenHeight + 130 - 64)];
//    }
//}
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
//{
//    NSLog(@"scrollViewWillBeginDecelerating");
//    if (scrollView.contentOffset.y >= 130) {
//        //        [self.headerView.sectionHeaderView setFrame:CGRectMake(0, 64, ScreenWidth, 40)];
//        //        [self.headerView.sectionHeaderView setBounds:CGRectMake(0, 64, ScreenWidth, 40)];
//        [self.pointTableView setFrame:CGRectMake(0, -66, ScreenWidth, ScreenHeight + 130 - 64)];
//    }
//}


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

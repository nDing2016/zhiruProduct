//
//  ZRProductDetalController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProductDetalController.h"
#import "ZRImmediatelyExchangeController.h"
#import "ZRProductDetailCell.h"
#import "ZRDiscoverRequest.h"
#import "ZRProductDetailModel.h"

//#import "ZRCommentListModel.h"
#import "ZRCommodityListModel.h"

@interface ZRProductDetalController ()<UIWebViewDelegate>
//<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *immediatelyBtn;

//@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZRProductDetailModel *productDetail;

@property (nonatomic, copy) NSString *webUrl;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ZRProductDetalController
#pragma mark - 懒加载
//-(UITableView *)tableView
//{
//    if (!_tableView) {
//        _tableView = [[ UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        
//    }
//    return _tableView;
//}


-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-40)];
        _webView.delegate = self;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
        [_webView loadRequest:request];
    }
    return _webView;
}

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商品详情";
    
    
    //添加立即兑换
    [self setUpImmediatelyExchange];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.immediatelyBtn.hidden = NO;
    
    [self loadProductDetailsData];
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.immediatelyBtn.hidden = YES;
}


#pragma mark - Private methods
- (void)setUpImmediatelyExchange
{
    UIWindow *myWindow = [[UIApplication sharedApplication] keyWindow];
    
    _immediatelyBtn = [MyControl createButtonWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40) ImageName:nil Target:self Action:@selector(immediatelyExchange:) Title:@"立即兑换"];
    _immediatelyBtn.backgroundColor = [UIColor blackColor];
    _immediatelyBtn.alpha = 0.3;
    [_immediatelyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _immediatelyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _immediatelyBtn.enabled = NO;
    [myWindow addSubview:_immediatelyBtn];
    
    
}


#pragma mark - click methods
- (void)immediatelyExchange:(UIButton *)sender
{
    
    //判断是否登录
    ZRUser * user = [ZRUserTool user];
    if (user == nil) {
        //用户未登录
        [ZRAlertControl notLoginAlert:self goLogin:^{
            
            //弹出登录页面
            ZRLoginViewController *loginVC = [[ZRLoginViewController alloc] init];
            ZRNavigationController *nav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
            
            [self presentViewController:nav animated:YES completion:nil];
            
            
        }];
    }else{
        
        ZRImmediatelyExchangeController *exchangeVC = [[ZRImmediatelyExchangeController alloc] init];
        [self.navigationController pushViewController:exchangeVC animated:YES];
        exchangeVC.commodityListmodel = self.commodityListModel;
        exchangeVC.mypoints = self.productDetail.myPoints;

        
    }

    
}


#pragma mark - manage memory methos
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebViewDelegate methods
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //判断是否可以兑换
    if ([self.productDetail.islogin isEqualToString:@"success"] && [self.productDetail.myPoints intValue]>=[self.productDetail.fraction intValue]) {
        self.immediatelyBtn.backgroundColor = RGBCOLOR(255, 82, 82);
        self.immediatelyBtn.alpha = 1;
        self.immediatelyBtn.enabled = YES;
        
    }else{
        //积分不够
        [SVProgressHUD showInfoWithStatus:@"您的积分不够,无法兑换"];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:2];
    }

}






//#pragma mark - UITableViewDataSource methods
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ZRProductDetailCell *cell = [ZRProductDetailCell cellWithTable:self.tableView ForIndexPath:indexPath];
//    
//    
//    return cell;
//}

#pragma mark - UITableViewDelegate methods
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat hei;
//    if (indexPath.row == 0) {
//        hei = 
//    }
//    
//    return hei;
//}


#pragma mark - 网络请求获取数据
- (void)loadProductDetailsData
{
    WS(ws)
    [ZRDiscoverRequest requestForIntegralMallProductDetailsWithCommodityId:ws.commodityListModel.commodityId WithCallback:^(id details, NSError *error) {
        ws.productDetail = [ZRProductDetailModel mj_objectWithKeyValues:details];
        //0未下架1下架
        if ([ws.productDetail.state isEqualToString:@"1"]) {
            [SVProgressHUD showInfoWithStatus:@"该商品已下架"];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
            
        }else{
            //加载网页
            //        ws.webUrl = [NSString stringWithFormat:@"http://192.168.2.22:8080/zhiru%@",ws.productDetail.url];
            ws.webUrl = [NSString stringWithFormat:@"%@",ws.productDetail.url];
            [ws.view addSubview:ws.webView];
        }
        
             

        
        
        
        
        
    }];
    

    
}





@end

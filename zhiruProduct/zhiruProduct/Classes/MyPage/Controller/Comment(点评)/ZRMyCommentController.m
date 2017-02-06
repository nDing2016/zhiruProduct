//
//  ZRMyCommentController.m
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMyCommentController.h"
#import "ZRCommentRequest.h"
#import "ZRCommentListModel.h"

@interface ZRMyCommentController ()

@end

@implementation ZRMyCommentController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的点评";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);

    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.goodReviewsCount = @"0";
    self.badReviewsCount = @"0";
    self.allReviewsCount = @"0";
    self.imgReviewsCount = @"0";
    
    self.btnTag = 111;
    self.allPage = 1;
    self.goodPage = 1;
    self.badPage = 1;
    self.picPage = 1;
    [self.tableView startRefreshWithCallback:^{
        [self loadData];
        
    }];
    
    [self.tableView startFooterRefresh:self Action:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden = YES;
    
}





#pragma mark - manage memory methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 网络请求获取数据
- (void)loadCommentDatasWithScreen:(NSString *)screen
{
}


//- (void)loadMoreDatas
//{
//    NSInteger page;
//    NSString *screen = nil;
//    if (self.btnTag == 111) {
//        page = ++self.allPage;
//        screen = @"0";
//    }else if (self.btnTag == 112){
//        page = ++self.goodPage;
//        screen = @"1";
//    }else if (self.btnTag == 113){
//        page = ++self.badPage;
//        screen = @"2";
//    }else{
//        page = ++self.picPage;
//        screen = @"3";
//    }
//    
//    WS(ws)
//    [ZRCommentRequest requestForMyBusinessCommentWithScreen:screen Rows:@"4" Page:[NSString stringWithFormat:@"%ld",(long)page] CallBack:^(id details, NSError *error) {
//        
//        [ws.tableView.mj_header endRefreshing];
//        ws.tableView.mj_footer.hidden = NO;
//        ws.tableView.mj_footer.state = MJRefreshStateIdle;
//        
//        
//        [details[@"commentList"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            ZRCommentListModel *model = [ZRCommentListModel mj_objectWithKeyValues:obj];
//            [ws.commentListArray addObject:model];
//        }];
//        
//        [ws.tableView reloadData];
//        
//        
//    }];
//
//}
//



#pragma mark - 网络请求获取数据
-(void)loadData
{
    WS(ws)
    
    [ZRCommentRequest requestForMyBusinessCommentWithScreen:@"0" Rows:@"4" Page:@"1" CallBack:^(id details, NSError *error) {
        
        if ([details[@"code"] isEqualToString:@"S000"]) {
            id datas = details[@"data"];
            
            [ws.tableView.mj_header endRefreshing];
            
            super.goodReviewsCount = datas[@"praise"];
            super.badReviewsCount = datas[@"bad"];
            super.allReviewsCount = datas[@"comment_count"];
            super.imgReviewsCount = datas[@"img_comment"];
            
            super.commentListArray = [NSMutableArray array];
            [datas[@"commentList"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZRCommentListModel *model = [ZRCommentListModel mj_objectWithKeyValues:obj];
                [super.commentListArray addObject:model];
                
                
                if (idx == super.commentListArray.count-1) {
                    if (super.commentListArray.count == 4) {
                        super.tableView.mj_footer.hidden = NO;
                        super.tableView.mj_footer.state = MJRefreshStateIdle;
                        
                    }
                    
                    [super.tableView reloadData];
                }
            }];
            
            
        }else{
            [ws.tableView.mj_header endRefreshing];
            
            if ([details[@"code"] isEqualToString:@"C004"]) {
                //用户未登录
                [ZRAlertControl notLoginAlert:self goLogin:^{
                    
                    //弹出登录页面
                    ZRLoginViewController *loginVC = [[ZRLoginViewController alloc] init];
                    ZRNavigationController *nav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
                    
                    [self presentViewController:nav animated:YES completion:nil];
                    
                    
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"获取数据出现错误,请稍候重试"];
                [SVProgressHUD performSelector:@selector(dismiss)withObject:nil afterDelay:2];
            }
            
           
            
            
            
        }
        
        
    }];
    
}

-(void)loadMoreData
{
    NSInteger page;
    NSString *screenStr = nil;
    if (self.btnTag == 111) {
        //全部
        page = ++self.allPage;
        screenStr = @"0";
    }else if (self.btnTag == 112){
        //好评
        page = ++self.goodPage;
        screenStr = @"1";
    }else if (self.btnTag == 113){
        //差评
        page = ++self.badPage;
        screenStr = @"2";
    }else if (self.btnTag == 114){
        //带图
        page = ++self.picPage;
        screenStr = @"3";
    }
    
    WS(ws)
    [ZRCommentRequest requestForMyBusinessCommentWithScreen:screenStr Rows:@"4" Page:[NSString stringWithFormat:@"%ld",(long)page] CallBack:^(id details, NSError *error) {
        
        if ([details[@"code"] isEqualToString:@"S000"]) {
            id detail = details[@"data"];
            
            [ws.tableView.mj_header endRefreshing];
            ws.tableView.mj_footer.hidden = NO;
            ws.tableView.mj_footer.state = MJRefreshStateIdle;
            
            NSArray *listArr = detail[@"commentList"];
            if (listArr.count>0) {
                [listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    ZRCommentListModel *model = [ZRCommentListModel mj_objectWithKeyValues:obj];
                    [ws.commentListArray addObject:model];
                    
                    if (idx == listArr.count-1) {
                        [ws.tableView reloadData];
                    }
                }];
                
                
                
            }else{
                //无更多数据了
                ws.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                if (self.btnTag == 111) {
                    //全部
                    self.allPage--;
                }else if (self.btnTag == 112){
                    //好评
                    self.goodPage--;
                }else if (self.btnTag == 113){
                    //差评
                    self.badPage--;
                    
                }else if (self.btnTag == 114){
                    //带图
                    self.picPage--;
                    
                }

                
            }

            
            
        }
        
        
    }];

    
}


- (void)selectData:(NSString *)screen
{
    
    NSInteger page;
    if (self.btnTag == 111) {
        //全部
        self.allPage = 1;
        page = self.allPage;
    }else if (self.btnTag == 112){
        //好评
        self.goodPage = 1;
        page = self.goodPage;
    }else if (self.btnTag == 113){
        //差评
        self.badPage = 1;
        page = self.badPage;
    }else if (self.btnTag == 114){
        //带图
        self.picPage = 1;
        page = self.picPage;
    }
    
    WS(ws)
    [ZRCommentRequest requestForMyBusinessCommentWithScreen:screen Rows:@"4" Page:@"1" CallBack:^(id details, NSError *error) {
        
        if ([details[@"code"] isEqualToString:@"S000"]) {
            id detail = details[@"data"];
            
            [ws.tableView.mj_header endRefreshing];
            
            
            ws.goodReviewsCount = detail[@"praise"];
            ws.badReviewsCount = detail[@"bad"];
            ws.allReviewsCount = detail[@"comment_count"];
            ws.imgReviewsCount = detail[@"img_comment"];
            
            ws.commentListArray = [NSMutableArray array];
            [detail[@"commentList"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZRCommentListModel *model = [ZRCommentListModel mj_objectWithKeyValues:obj];
                [ws.commentListArray addObject:model];
                
                
                if (idx == ws.commentListArray.count-1) {
                    if (ws.commentListArray.count == 4) {
                        ws.tableView.mj_footer.hidden = NO;
                        ws.tableView.mj_footer.state = MJRefreshStateIdle;
                        
                    }
                    
                    [ws.tableView reloadData];
                    
                }
                
            }];

            
        }else{
            
            if ([details[@"code"] isEqualToString:@"C004"]) {
                [ws.tableView.mj_header endRefreshing];
                //用户未登录
                [ZRAlertControl notLoginAlert:self goLogin:^{
                    
                    //弹出登录页面
                    ZRLoginViewController *loginVC = [[ZRLoginViewController alloc] init];
                    ZRNavigationController *nav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
                    
                    [self presentViewController:nav animated:YES completion:nil];
                    
                    
                }];
            }
            
            
        }
        
        
        
        
        
        
        
    }];

    
}







//实现左滑删除方法

//第一个参数：表格视图对象

//第二个参数：编辑表格的方式

//第三个参数：操作cell对应的位置

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath

{
    if (indexPath.section == 1) {
        //如果是删除
        
        if(editingStyle==UITableViewCellEditingStyleDelete)
            
        {
            
            [SVProgressHUD show];
            
            ZRCommentListModel *model = self.commentListArray[indexPath.row];
            WS(ws)
            [ZRCommentRequest requestForBusinessCommentDeleteWithCommentId:model.commentId AndCommentType:@"1" CallBack:^(id details, NSError *error) {
                NSLog(@"data====%@",details[@"data"]);
                if ([details[@"code"] isEqualToString:@"S000"]) {
                    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                    [SVProgressHUD performSelector:@selector(dismiss)withObject:nil afterDelay:2];
                    
                    //点击删除按钮调用这里的代码
                    
                    //        1.数据源删除
                    
                    
                    
                    [ws.commentListArray removeObjectAtIndex:indexPath.row];
                    
                    //        2.UI上删除
                    
                    //删除表视图的某个cell
                    
                    /*
                     
                     第一个参数：将要删除的所有的cell的indexPath组成的数组
                     
                     第二个参数：动画
                     
                     */
                    
                    //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                   
                    
                    //修改四个分类个数
                    ws.badReviewsCount = details[@"data"][@"bad"];
                    ws.goodReviewsCount = details[@"data"][@"praise"];
                    ws.allReviewsCount = details[@"data"][@"comment_count"];
                    ws.imgReviewsCount = details[@"data"][@"img_comment"];
                    
                    
                    //将整个表格视图刷新也可以实现在UI上删除的效果，只不过它要重新执行一遍所有的方法，效率很低
                    [ws.tableView reloadData];

                    
                }else{
                    [SVProgressHUD showErrorWithStatus:@"删除失败"];
                    [SVProgressHUD performSelector:@selector(dismiss)withObject:nil afterDelay:2];
                    
                    
                }
                
                
            }];
            
            
            
            
        }
 
    }
    
    
}

//修改删除按钮为中文的删除

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return @"删除";
    
}

//是否允许编辑行，默认是YES

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return YES;
    
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

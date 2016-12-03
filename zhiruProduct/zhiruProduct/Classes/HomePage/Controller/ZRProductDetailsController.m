//
//  ZRProductDetailsController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProductDetailsController.h"
#import "ZRProductInfoCell.h"
#import "ZRProductSectionCell.h"
#import "ZRBDTuanGouCell.h"
#import "ZRShopCommentCell.h"
#import "ZRShopInfoCell.h"
#import "ZRPostCommentController.h"

#import "ZRHomePageRequst.h"
#import "ZRBusinessDetailsModel.h"
#import "ZRShareView.h"

#import "ZRMapViewController.h"

#import "ZRAllReviewsController.h"
#import "ZRStorePictureController.h"
#import "ZRUserStoreupRequest.h"

#import "ZRReviewDetailController.h"

@interface ZRProductDetailsController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong) UITableView * myTableView;
@property (nonatomic , strong) NSArray * sectionOneTitleArr;
@property (nonatomic , strong) ZRBusinessDetailsModel * model;

@property (nonatomic, strong)UIButton * likeCarButton;


//评价集合
@property (nonatomic , strong) NSArray * commentListArr;
//选中条件按钮角标
@property (nonatomic , assign) NSInteger selectIndex;
@property (nonatomic , strong) NSMutableArray * commentCountArr;

@property (nonatomic , assign) NSInteger page;
@end

@implementation ZRProductDetailsController

- (NSMutableArray *)commentCountArr{
    if (_commentCountArr== nil) {
        _commentCountArr = [NSMutableArray array];
    }
    return _commentCountArr;
}

-(void)setBusinessId:(NSString *)businessId{
    _businessId = businessId;
    
    //发送网络请求
   WS(ws)
    [self.myTableView startRefreshWithCallback:^{
        ws.page = 1;
        //网络请求
         [ws getBusinessData];
    }];
}

-(NSArray *)sectionOneTitleArr{
    if (_sectionOneTitleArr == nil ) {
//        _sectionOneTitleArr = @[@"口味 : 4.9 环境 : 4,9 服务 : 4.9",@"向工街基业百花园北门",@"024 -12345645", @"营业时间 : 8 : 00 - 9 : 00",@"订餐"];
        if (_isGame) {
            _sectionOneTitleArr = @[[NSString stringWithFormat:@"设施 : %@ 环境 : %@ 服务 : %@",_model.gradeOne,_model.gradeTwo,_model.gradeThree], _model.address , _model.tel ,[NSString stringWithFormat:@"营业时间 : %@",_model.open_time] ,_model.is_pack];
        }else if(_isLiren){
        
        _sectionOneTitleArr = @[[NSString stringWithFormat:@"效果 : %@ 环境 : %@ 服务 : %@",_model.gradeOne,_model.gradeTwo,_model.gradeThree], _model.address , _model.tel ,[NSString stringWithFormat:@"营业时间 : %@",_model.open_time] ,_model.is_pack];
        
        }
        else {
            _sectionOneTitleArr = @[[NSString stringWithFormat:@"口味 : %@ 环境 : %@ 服务 : %@",_model.gradeOne,_model.gradeTwo,_model.gradeThree], _model.address , _model.tel ,[NSString stringWithFormat:@"营业时间 : %@",_model.open_time] ,_model.is_pack];
        }
        
        
    }
    return _sectionOneTitleArr;
}

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        
        UITableView * myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth , ScreenHeight - 64) style:UITableViewStylePlain];
        
        [self.view addSubview:myTableView];
        
        myTableView.backgroundColor = [UIColor clearColor];
        
        myTableView.rowHeight = UITableViewAutomaticDimension;
        myTableView.estimatedRowHeight = 80.0;
        
        _myTableView = myTableView;
    }
    return _myTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [CustomHudView show];
    
    [self createNavRightBtn];
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        //基本信息section
        if ([[self.sectionOneTitleArr lastObject] isEqualToString:@"1"]) {
            return self.sectionOneTitleArr.count + 1;
        }else{
            return self.sectionOneTitleArr.count;
        }
        
    }else if(section == 1){
        //团购
        return _model.group_list.count + 1;
    }else if(section == 2){
        if (_commentListArr.count >2) {
            
            return 4;
        }else{
            if (_commentListArr.count == 0) {
                return 2;
            }else if(_commentListArr.count == 1)
            {
                return 3;
            }else{
                return 4;
            }
            
        }
        
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString * identifier = @"cellOne";
            
            ZRProductInfoCell * cellOne = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cellOne == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRProductInfoCell class]) owner:self options:nil];
                cellOne = [nibs lastObject];
            }
            cellOne.regionName = _regionName;
            cellOne.model = _model;
            cellOne.selectionStyle = UITableViewCellSelectionStyleNone;
            return cellOne;
        }else{
            static NSString * identifier = @"cellTwo";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = self.sectionOneTitleArr[indexPath.row -1];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.numberOfLines = 0;
            if (indexPath.row == 2) {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
                cell.imageView.image = [UIImage imageNamed:@"dingwei_hei"];
            }else if (indexPath.row == 3){
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
                cell.imageView.image = [UIImage imageNamed:@"call_hei"];
            }else if(indexPath.row == 5){
                cell.imageView.image = [UIImage imageNamed:@"ding"];
            }
            return cell;
        }
    }
    //团购
    else if(indexPath.section == 1){
        if (indexPath.row== 0) {
            static NSString * identifier = @"SectionCell";
            ZRProductSectionCell * sectionCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (sectionCell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRProductSectionCell class]) owner:self options:nil];
                sectionCell = [nibs lastObject];
            }
            sectionCell.title = [NSString stringWithFormat:@"本店团购 (%ld)",(unsigned long)_model.group_list.count];
            sectionCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return sectionCell;
        }
        
        static NSString * identifier = @"tuanGouCell";
        ZRBDTuanGouCell * tuanCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (tuanCell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRBDTuanGouCell class]) owner:self options:nil];
            tuanCell = [nibs lastObject];
        }
        tuanCell.selectionStyle = UITableViewCellSelectionStyleNone;
        tuanCell.model = _model.group_list[indexPath.row - 1] ;
        
        return tuanCell;
    }
    
    //评论
    else if(indexPath.section == 2){
        if (indexPath.row== 0) {
            static NSString * identifier = @"SectionCell";
            ZRProductSectionCell * sectionCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (sectionCell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRProductSectionCell class]) owner:self options:nil];
                sectionCell = [nibs lastObject];
            }

            sectionCell.selectIndex = _selectIndex;
            sectionCell.titleNumbArr = self.commentCountArr;


            sectionCell.title = @"网友点评";
            sectionCell.isHideBtnView = YES;

            
            //网友点评 点击选择按钮 回调
            WS(ws)
            sectionCell.SectionClick = ^(NSInteger index){
                NSInteger count = index -100 ;
                ws.selectIndex = count  ;
                [ws getCommentListWithScreen:[NSString stringWithFormat:@"%ld",(long)count] andBusinessId:_businessId andCommentType:@"1"];
                
            };


            sectionCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return sectionCell;
        }
        
        static NSString * identifier = @"commentCell";
        ZRShopCommentCell * commentCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (commentCell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRShopCommentCell class]) owner:self options:nil];
            commentCell = [nibs lastObject];
        }
        
        //如果等于最后一个返回 普通cell
        NSInteger count ;
        if ( _commentListArr.count > 2) {
            count = 2;
        }else{
            count = _commentListArr.count;
        }
        if (indexPath.row == count + 1) {
            static NSString * identifier = @"cell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            }
            cell.textLabel.text = @"查看所有网友评论";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (_commentListArr.count>0) {
            commentCell.model = _commentListArr[indexPath.row - 1];
        }
        
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        WS(ws)
        commentCell.clickGoodBtn = ^(UIButton* btn , NSString * commentId ,BOOL isCancel){
            if (btn.tag == 0) {
                //好评
                if (isCancel == YES) {
                    [ws cancelClickBtn:commentId];
                }else{
                    [ws clickGoodBtn:commentId];
                }
            }else{
                //差评
                if (isCancel == YES) {
                    [ws cancelClickBtn:commentId];
                }else{
                    [ws clickeNoGoodBtn:commentId];
                }
            }
          
        };
        return commentCell;
        
    }
    //商家信息
    else{
        if (indexPath.row== 0) {
            static NSString * identifier = @"SectionCell";
            ZRProductSectionCell * sectionCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (sectionCell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRProductSectionCell class]) owner:self options:nil];
                sectionCell = [nibs lastObject];
            }
            sectionCell.title = @"商户信息";
            sectionCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return sectionCell;
        }
        static NSString * identifier = @"shopInfoCell";
        ZRShopInfoCell * shopInfoCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (shopInfoCell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRShopInfoCell class]) owner:self options:nil];
            shopInfoCell = [nibs lastObject];
        }
        shopInfoCell.model = _model;
        shopInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return shopInfoCell;
    }

}


#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //_businessId
            ZRStorePictureController * storeVC = [[ZRStorePictureController alloc] init];
            storeVC.bussinesId = _businessId;
            [self.navigationController pushViewController:storeVC animated:YES];
        }
        
        
        if (indexPath.row == 2) {
            //跳转到地图
            ZRMapViewController *mapVC = [[ZRMapViewController alloc] init];
            
            mapVC.longitude = self.model.longitude;
            mapVC.latitude = self.model.latitude;
            
            [self.navigationController pushViewController:mapVC animated:YES];
        }
        
        if (indexPath.row == 3) {
            //拨打电话
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", self.sectionOneTitleArr[indexPath.row -1]];
            
//            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];
            //            NSLog(@"str======%@",str);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

//            UIWebView *webView = [[UIWebView alloc]init];
            
//            NSURL *url = [NSURL URLWithString:str];
            
//            [webView loadRequest:[NSURLRequest requestWithURL:url ]];
            
//            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            
//            [self.view addSubview:webView];
        }
        
    }else if (indexPath.section == 2){
        NSInteger count ;
        if ( _commentListArr.count > 2) {
            count = 2;
        }else{
            count = _commentListArr.count;
        }
        if (indexPath.row == count + 1) {
#warning 查看所有评价 跳转口
            //跳转到查看全部网友评论。  店铺评论
            ZRAllReviewsController *allReviewsVC = [[ZRAllReviewsController alloc] init];
            [self.navigationController pushViewController:allReviewsVC animated:YES];
            allReviewsVC.reviewsType = ZRShopReviews;
            allReviewsVC.businessId = _businessId;
            allReviewsVC.goodReviewsCount = _model.praise;
            allReviewsVC.allReviewsCount = _model.comment_count;
            allReviewsVC.badReviewsCount = _model.bad;
            allReviewsVC.imgReviewsCount = _model.img_comment;
            
            if (_isGame) {
                //娱乐
                allReviewsVC.shopType = ZRYuLe;
                
            }else if(_isLiren){
                
                //丽人
                allReviewsVC.shopType = ZRLiRen;
            }
            else {
                //寻味
                allReviewsVC.shopType = ZRXunWei;
            }

            
            
        }
        
        ZRShopCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ZRReviewDetailController *reviewDetailVC = [[ZRReviewDetailController alloc] init];
        [self.navigationController pushViewController:reviewDetailVC animated:YES];
        reviewDetailVC.commentIdStr = cell.model.commentId;
        if (_isGame) {
            //娱乐
            reviewDetailVC.shoptype = 101;
            
        }else if(_isLiren){
            
            //丽人
            reviewDetailVC.shoptype = 102;
        }
        else {
            //寻味
            reviewDetailVC.shoptype = 100;
        }
        
        
        
        
    }
    
    
}



#pragma mark -- 创建导航条右标题

- (void)createNavRightBtn{
    //评论
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:@selector(enterehzFilesVC:) forControlEvents:UIControlEventTouchUpInside];
    [informationCardBtn setImage:[UIImage imageNamed:@"pinglun-hong"] forState:UIControlStateNormal];
    informationCardBtn.tag = 100;
    
    [informationCardBtn sizeToFit];
    UIBarButtonItem *pinglunCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    //分享
    UIButton *shareCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    shareCardBtn.userInteractionEnabled = NO;
    
    [shareCardBtn addTarget:self action:@selector(enterehzFilesVC:) forControlEvents:UIControlEventTouchUpInside];
    [shareCardBtn setImage:[UIImage imageNamed:@"fenxiang_hui"] forState:UIControlStateNormal];
    shareCardBtn.tag = 101;
    
    [shareCardBtn sizeToFit];
    UIBarButtonItem *shareCardItem = [[UIBarButtonItem alloc] initWithCustomView:shareCardBtn];
    
    //收藏
    UIButton *likeCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeCardBtn addTarget:self action:@selector(enterehzFilesVC:) forControlEvents:UIControlEventTouchUpInside];
    [likeCardBtn setImage:[UIImage imageNamed:@"zan-hong"] forState:UIControlStateNormal];
    [likeCardBtn setImage:[UIImage imageNamed:@"yizanhong"] forState:UIControlStateSelected];
    likeCardBtn.tag = 102;
    
    [likeCardBtn sizeToFit];
    UIBarButtonItem *likeCardItem = [[UIBarButtonItem alloc] initWithCustomView:likeCardBtn];
    self.navigationItem.rightBarButtonItems  = @[pinglunCardItem,shareCardItem,likeCardItem];
    
    _likeCarButton = likeCardBtn;
}

- (void)enterehzFilesVC : (UIButton *)btn{
    
    switch (btn.tag) {
        case 100://评论
        {
            //判断是否 登录 ,如果没登录 弹出登录,
            ZRUser * user = [ZRUserTool user];
            if (user == nil) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:@"1"];
                return;
            }
            
            ZRPostCommentController * pCommentVC = [[ZRPostCommentController alloc]  init];
            
            if (_isLiren) {
                pCommentVC.isLiren = YES;
            }
            if (_isGame) {
                pCommentVC.isGame = YES;
            }
            
            pCommentVC.title = @"发表评论";
            pCommentVC.businessId = _businessId;
            pCommentVC.commentType = @"1";
            WS(ws)
            pCommentVC.postOkBlock = ^(){
                [ws getBusinessData];
                
            };
            
            [self.navigationController pushViewController:pCommentVC animated:YES];
            
        }
            break;
        case 101://分享
        {
            //NSLog(@"点击了分享");
//            _productModel.btnTile = @"分享";
//            if (self.btnClickBlock) {
//                self.btnClickBlock(_productModel);
//                
            NSMutableArray *temImgArr = [NSMutableArray array];
            
            if (self.model.head_url.length>0) {
                [temImgArr addObject:self.model.head_url];
            }else{
                [temImgArr addObject:@""];
            }
            
          
            NSArray *imgesArr = [NSArray arrayWithArray:temImgArr];
                NSString *shareUrlStr = [NSString stringWithFormat:@"http://www.sharesdk.cn"];
                ZRShareView *shareView = [[ZRShareView alloc]init];
//                WS(ws);
                [shareView createUIWithTitle:self.model.name andText:self.model.remarks andImages:imgesArr andUrlStr:shareUrlStr  andSuccess:^{
                    [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                } andFail:^{
                    
                    
                } andCancle:^{
                    
                    
                }];
                
//            }

        }
            
        case 102: // 收藏
        {
            ZRUser * user = [ZRUserTool user];
            if (user == nil) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:@"1"];
            } else {
                if (_likeCarButton.selected == YES) {
                    [ZRUserStoreupRequest delBusinessCollectionWithBusinessId:_businessId CallBack:^(NSString *message) {
                        if ([message isEqualToString:@"success"]) {
                            [AlertText showAndText:@"取消收藏成功"];
                            _likeCarButton.selected = !_likeCarButton.selected;
                        } else {
                            [AlertText showAndText:@"取消收藏失败"];
                        }
                        
                    } Failure:^(id error) {
                        [AlertText showAndText:@"取消收藏失败"];
                    }];
                } else {
                    [ZRHomePageRequst requestCollectionAddBusinessCollectionWithBusinessId:_businessId andSuccess:^(id success) {
                        NSString * str = success;
                        if ([str isEqualToString:@"success"]) {
                            [AlertText showAndText:@"添加收藏成功"];
                            _likeCarButton.selected = !_likeCarButton.selected;
                        } else {
                            [AlertText showAndText:@"添加收藏失败"];
                        }
                        
                    } andFailure:^(id error) {
                        [AlertText showAndText:@"添加收藏失败"];
                    }];
                }

            }
        }
            break;
        default:
            break;
    }
}


#pragma mark -- 请求网络数据
- (void)getBusinessData{
    self.commentCountArr = nil;
    self.sectionOneTitleArr = nil;
    WS(ws)
    [ZRHomePageRequst requestGetBusinessDetailsWithBusinessId:_businessId andSuccess:^(NSMutableArray *marr) {
        
        ws.model = marr[0];

        
        
        [ws.commentCountArr addObject:ws.model.comment_count];
        [ws.commentCountArr addObject:ws.model.praise];
        [ws.commentCountArr addObject:ws.model.bad];
        [ws.commentCountArr addObject:ws.model.img_comment];
        ws.commentListArr = ws.model.commentList;
        


        ws.myTableView.delegate = ws;
        ws.myTableView.dataSource = ws;
        if ([ws.model.isCollection isEqualToString:@"0"]) {
            _likeCarButton.selected = NO;
        } else if ([ws.model.isCollection isEqualToString:@"1"]) {
            _likeCarButton.selected = YES;
        }

        [ws.myTableView reloadData];
         [ws.myTableView.mj_header endRefreshing];
        [CustomHudView dismiss];
    } andFailure:^(id error) {
         [ws.myTableView.mj_header endRefreshing];
        [CustomHudView dismiss];
    }];
}

#pragma mark -- 通过筛选 请求店铺评价
- (void)getCommentListWithScreen:(NSString*)screen andBusinessId :(NSString *)businessId andCommentType:(NSString *)commentType{
    WS(ws)
    [CustomHudView show];
    [ZRHomePageRequst requestBusinessCommentListWithBusinessId:businessId  withScreen:screen andCommentType:commentType andSuccess:^(id success) {
        ws.commentListArr = success;
        
        [ws.myTableView reloadData];
        
        //刷新tableview
        [CustomHudView dismiss];
    } andFailure:^(id error) {
        
        [CustomHudView dismiss];
    }];
}

#define mark - 点赞/差评/取消点赞
- (void)clickGoodBtn:(NSString*)commentId{
    [SVProgressHUD show];

    [ZRHomePageRequst requestAgreeWithCommentId:commentId andSuccess:^(id success) {
        [SVProgressHUD showSuccessWithStatus:@"好评成功"];
//        [ws getBusinessData];
//        [ws.myTableView reloadData];
        [SVProgressHUD dismiss];
    } andFailure:^(id error) {
        [SVProgressHUD showErrorWithStatus:@"好评失败"];
        [SVProgressHUD dismiss];
    }];
}

- (void)clickeNoGoodBtn:(NSString *)commentId{
    
    [SVProgressHUD show];

    [ZRHomePageRequst requestNoAgreeWithCommentId:commentId andSuccess:^(id success) {
        [SVProgressHUD showSuccessWithStatus:@"差评成功"];
//        [ws getBusinessData];
//        [ws.myTableView reloadData];
        [SVProgressHUD dismiss];
    } andFailure:^(id error) {
        [SVProgressHUD showErrorWithStatus:@"差评失败"];
        [SVProgressHUD dismiss];
    }];
}


- (void)cancelClickBtn:(NSString *)commentId{
    [SVProgressHUD show];

    [ZRHomePageRequst requestDeleteAgreeWithCommentId:commentId andSuccess:^(id success) {
//        [SVProgressHUD showSuccessWithStatus:@"取消成功"];
//        [ws getBusinessData];
//        [ws.myTableView reloadData];
        [SVProgressHUD dismiss];
    } andFailure:^(id error) {
//        [SVProgressHUD showErrorWithStatus:@"取消失败"];
        [SVProgressHUD dismiss];
    }];
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

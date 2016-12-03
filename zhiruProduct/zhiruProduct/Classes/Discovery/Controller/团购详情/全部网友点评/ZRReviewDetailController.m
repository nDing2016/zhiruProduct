//
//  ZRReviewDetailController.m
//  zhiruProduct
//
//  Created by nanding on 16/11/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRReviewDetailController.h"
#import "ZRCommentRequest.h"
#import "ZRCommentListModel.h"
#import "ZRGroupBuyingReviewDetailsCell.h"
#import "ZRHomePageRequst.h"
#import "ZRCheckReviewPictureView.h"
@interface ZRReviewDetailController ()<ZRCheckReviewPicViewDelegate>

//所有评论图片数组
@property (nonatomic, strong) NSMutableArray *reviewPicsArray;

@end

@implementation ZRReviewDetailController
#pragma mark - lifeCycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView startRefreshWithCallback:^{
        
        [self loadDetails];
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"点评详情";
    // Do any additional setup after loading the view.
}


#pragma mark - get methods


#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
        return self.commentListArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRGroupBuyingReviewDetailsCell *cell = [ZRGroupBuyingReviewDetailsCell cellWithTableView:self.tableView ForIndexPath:indexPath];
    for (UIView *vi in cell.contentView.subviews) {
        [vi removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 1) {
        self.reviewFrame.commentListModel = self.commentListArray[indexPath.row];
        cell.reviewFrame = self.reviewFrame;
        cell.commentListModel = self.commentListArray[indexPath.row];
        cell.shoptype = (int)self.shoptype;
        WS(ws)
        cell.clickGoodBtn = ^(UIButton* btn , NSString * commentId ,BOOL isCancel){
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
        
        
        //头像
        UIImageView *headImgView = [[UIImageView alloc] initWithFrame:cell.reviewFrame.reviewIconFrame];
        headImgView.layer.cornerRadius = cell.reviewFrame.reviewIconFrame.size.width/2;
        headImgView.layer.masksToBounds = YES;
        [headImgView sd_setImageWithURL:[NSURL URLWithString:cell.commentListModel.commentUserImg] placeholderImage:ZRImage(@"default_head")];
        [cell.contentView addSubview:headImgView];
        
        
        
        if (cell.commentListModel.commentImg.count>0) {
            UIView *commentView = [[UIView alloc] initWithFrame:cell.reviewFrame.reviewPicFrame];
            [cell.contentView addSubview:commentView];
            //评论配图
            CGFloat wid = 80*SCREEN_WIDTH/375;
            CGFloat mix = 10*SCREEN_WIDTH/375;
            
            [cell.commentListModel.commentImg enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *commentImgUrlDic = obj;
                NSString *commentImgUrl = [commentImgUrlDic objectForKey:@"img_url"];
                UIImageView *commentImgView = [[UIImageView alloc] initWithFrame:CGRectMake((wid+mix)*(idx%3), (wid+mix)*(idx/3), wid, wid)];
                if (idx == 0) {
                    for (UIGestureRecognizer *ges in commentImgView.gestureRecognizers) {
                        [commentImgView removeGestureRecognizer:ges];
                        
                    }
                    
                }
                
                commentImgView.tag = idx;
                commentImgView.userInteractionEnabled = YES;
                [commentImgView sd_setImageWithURL:[NSURL URLWithString:commentImgUrl] placeholderImage:ZRImage(@"Default")];
                [commentView addSubview:commentImgView];
                
                //添加手势
                UITapGestureRecognizer *tapImgView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgView:)];
                [commentImgView addGestureRecognizer:tapImgView];
                
                //                [ws.reviewPicsArray addObject:commentImgUrl];
            }];
            
        }

    }
    
    
    return cell;
    
}



#pragma mark - UITableViewDelegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat hei;
    if (indexPath.section == 0) {
        hei = 0;
    }else{
        hei = self.reviewFrame.cellHeight;
    }
    
    return hei;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - click methods
/**
 *  评论图片点击事件
 */
- (void)tapImgView:(UIGestureRecognizer *)ges
{
    
    ZRGroupBuyingReviewDetailsCell *cell = (ZRGroupBuyingReviewDetailsCell *)[[[ges.view superview] superview] superview];
    self.reviewPicsArray = [NSMutableArray array];
    WS(ws)
    [cell.commentListModel.commentImg enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *commentImgUrlDic = obj;
        NSString *commentImgUrl = [commentImgUrlDic objectForKey:@"img_url"];
        [ws.reviewPicsArray addObject:commentImgUrl];
        
        if (idx == cell.commentListModel.commentImg.count-1) {
            ZRCheckReviewPictureView *checkPicView = [[ZRCheckReviewPictureView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight)];
            [[UIApplication sharedApplication].keyWindow addSubview:checkPicView];
            checkPicView.delegate = ws;
            checkPicView.curPage = ges.view.tag;
            checkPicView.picturesArray = ws.reviewPicsArray;
            
        }
        
    }];
    
    
    
    
    
}


#pragma mark - ZRCheckReviewPictureViewDelegate methods
-(void)dismissView:(ZRCheckReviewPictureView *)view
{
    [UIView animateWithDuration:1 animations:^{
        [view removeFromSuperview];
        
    }];
}




#pragma mark - 网络请求
- (void)loadDetails
{
    WS(ws)
    self.commentListArray = [NSMutableArray array];
    [ZRCommentRequest requestForBusinessCommentDetailsWithCommentId:self.commentIdStr CallBack:^(id details, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if ([details[@"code"] isEqualToString:@"S000"]) {
            ZRCommentListModel *model = [ZRCommentListModel mj_objectWithKeyValues:details[@"data"]];
            [ws.commentListArray addObject:model];
            
            ZRGroupBuyingReviewDetailsCell *cell = [ws.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            for (UIView *view in cell.contentView.subviews) {
                view.hidden = YES;
            }
            
            [ws.tableView reloadData];
            
        }else{
            //用户未登录
            [ZRAlertControl notLoginAlert:self goLogin:^{
                
                //弹出登录页面
                ZRLoginViewController *loginVC = [[ZRLoginViewController alloc] init];
                ZRNavigationController *nav = [[ZRNavigationController alloc] initWithRootViewController:loginVC];
                
                [self presentViewController:nav animated:YES completion:nil];
                
                
            }];
            
        }
        
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
        
        
//
//        [ws.tableView startRefreshWithCallback:^{
//            [ws loadDetails];
//            
//        }];
        
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
        //        ZRGroupBuyingReviewDetailsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        //        UIButton *btn = [cell viewWithTag:ws.btnTag];
        //        [self reviewButtonClick:btn];
        
//        NSString *screenStr = nil;
//        if (ws.btnTag == 111) {
//            screenStr = @"0";
//        }else if (ws.btnTag == 112){
//            screenStr = @"1";
//        }else if (ws.btnTag == 113){
//            screenStr = @"2";
//        }else{
//            screenStr = @"3";
//        }
//        [self selectData:screenStr];
        
//        [ws.tableView startRefreshWithCallback:^{
//            [ws loadDetails];
//            
//        }];
        
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
        //        ZRGroupBuyingReviewDetailsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        //        UIButton *btn = [cell viewWithTag:ws.btnTag];
        //        [self reviewButtonClick:btn];
        
//        NSString *screenStr = nil;
//        if (ws.btnTag == 111) {
//            screenStr = @"0";
//        }else if (ws.btnTag == 112){
//            screenStr = @"1";
//        }else if (ws.btnTag == 113){
//            screenStr = @"2";
//        }else{
//            screenStr = @"3";
//        }
//        [self selectData:screenStr];
        
//        [ws.tableView startRefreshWithCallback:^{
//            [ws loadDetails];
//            
//        }];
        
        
    } andFailure:^(id error) {
        //        [SVProgressHUD showErrorWithStatus:@"取消失败"];
        [SVProgressHUD dismiss];
    }];
}






#pragma mark - manage memory methods
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

//
//  ZRAllReviewsController.m
//  zhiruProduct
//
//  Created by nanding on 16/7/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRAllReviewsController.h"
#import "ZRGroupBuyingReviewDetailsCell.h"
#import "ZRGoupBuyingReviewFrame.h"

#import "ZRHomePageRequst.h"
#import "ZRCommentListModel.h"

#import "ZRReviewDetailController.h"

@interface ZRAllReviewsController ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) ZRGoupBuyingReviewFrame *reviewFrame;



@end

@implementation ZRAllReviewsController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网友点评";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.btnTag = 111;
    self.allPage = 1;
    self.goodPage = 1;
    self.badPage = 1;
    self.picPage = 1;
    WS(ws)
    [self.tableView startRefreshWithCallback:^{
        [ws loadData];
    }];
    
    [self.tableView startFooterRefresh:self Action:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden = YES;
}


#pragma mark - set方法

//全部评论
-(void)setAllReviewsCount:(NSString *)allReviewsCount
{
    _allReviewsCount = allReviewsCount;
    if (_allReviewsCount == nil) {
        _allReviewsCount = @"0";
    }
}

//好评数
-(void)setGoodReviewsCount:(NSString *)goodReviewsCount
{
    _goodReviewsCount = goodReviewsCount;
    if (_goodReviewsCount == nil) {
        _goodReviewsCount = @"0";
    }
}

//差评数
-(void)setBadReviewsCount:(NSString *)badReviewsCount
{
    _badReviewsCount = badReviewsCount;
    if (_badReviewsCount == nil) {
        _badReviewsCount = @"0";
    }
}

//带图评论数
-(void)setImgReviewsCount:(NSString *)imgReviewsCount
{
    _imgReviewsCount = imgReviewsCount;
    if (_imgReviewsCount == nil) {
        _imgReviewsCount = @"0";
    }
}

#pragma mark - 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}


-(ZRGoupBuyingReviewFrame *)reviewFrame
{
    if (!_reviewFrame) {
        _reviewFrame = [[ZRGoupBuyingReviewFrame alloc] init];
    }
    return _reviewFrame;
}


-(NSMutableArray *)commentListArray
{
    if (!_commentListArray) {
        _commentListArray = [NSMutableArray array];
    }
    return _commentListArray;
}


#pragma mark - UITableViewDataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
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
    if (indexPath.section == 0) {
        [self createTitleButton:cell WithSelectedTag:self.btnTag];
    }else{
        
        self.reviewFrame.commentListModel = self.commentListArray[indexPath.row];
        cell.reviewFrame = self.reviewFrame;
        cell.commentListModel = self.commentListArray[indexPath.row];
        
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
                [commentImgView sd_setImageWithURL:[NSURL URLWithString:commentImgUrl] placeholderImage:ZRImage(@"Default")];
                [commentView addSubview:commentImgView];
            }];

        }
        
    }
    
    
    return cell;
    
}

#pragma mark - Private methods
- (void)createTitleButton:(ZRGroupBuyingReviewDetailsCell *)cell WithSelectedTag:(NSInteger)selctedTag
{
    CGFloat x = 15*SCREEN_WIDTH/375;
    CGFloat width = (SCREEN_WIDTH-15*6)/3;
    CGFloat height = (90*SCREEN_HEIGHT/667-10*3)/2;
    for (int i=0; i<4; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(x*(i+1)+width*i, 10, width, height);
        btn.backgroundColor = RGBCOLOR(199, 199, 199);
        if (i==3) {
            btn.frame = CGRectMake(x, 10*2+height, width, height);
            [btn setTitle:[NSString stringWithFormat:@"有图 (%@)",self.imgReviewsCount] forState:UIControlStateNormal];
        }else if (i == 0) {
            [btn setTitle:[NSString stringWithFormat:@"全部 (%@)",self.allReviewsCount] forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:[NSString stringWithFormat:@"好评 (%@)",self.goodReviewsCount] forState:UIControlStateNormal];
        }else{
            [btn setTitle:[NSString stringWithFormat:@"差评 (%@)",self.badReviewsCount] forState:UIControlStateNormal];
        }
        btn.tag = 111+i;
        if (btn.tag == selctedTag) {
           btn.backgroundColor = RGBCOLOR(142, 210, 255);
        }
        btn.layer.cornerRadius = 5;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reviewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
    }

}


#define mark - 点赞/差评/取消点赞
- (void)clickGoodBtn:(NSString*)commentId{
    [SVProgressHUD show];
    WS(ws)
    [ZRHomePageRequst requestAgreeWithCommentId:commentId andSuccess:^(id success) {
        [SVProgressHUD showSuccessWithStatus:@"好评成功"];
        //        [ws getBusinessData];
        //        [ws.myTableView reloadData];
        [SVProgressHUD dismiss];
        
        
//        ZRGroupBuyingReviewDetailsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        UIButton *btn = [cell viewWithTag:ws.btnTag];
//        [self reviewButtonClick:btn];
        
        
        NSString *screenStr = nil;
        if (ws.btnTag == 111) {
            screenStr = @"0";
        }else if (ws.btnTag == 112){
            screenStr = @"1";
        }else if (ws.btnTag == 113){
            screenStr = @"2";
        }else{
            screenStr = @"3";
        }
        [self selectData:screenStr];
        
    } andFailure:^(id error) {
        [SVProgressHUD showErrorWithStatus:@"好评失败"];
        [SVProgressHUD dismiss];
    }];
}

- (void)clickeNoGoodBtn:(NSString *)commentId{
    
    [SVProgressHUD show];
    WS(ws)
    [ZRHomePageRequst requestNoAgreeWithCommentId:commentId andSuccess:^(id success) {
        [SVProgressHUD showSuccessWithStatus:@"差评成功"];
        //        [ws getBusinessData];
        //        [ws.myTableView reloadData];
        [SVProgressHUD dismiss];
//        ZRGroupBuyingReviewDetailsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        UIButton *btn = [cell viewWithTag:ws.btnTag];
//        [self reviewButtonClick:btn];
        
        NSString *screenStr = nil;
        if (ws.btnTag == 111) {
            screenStr = @"0";
        }else if (ws.btnTag == 112){
            screenStr = @"1";
        }else if (ws.btnTag == 113){
            screenStr = @"2";
        }else{
            screenStr = @"3";
        }
        [self selectData:screenStr];

    } andFailure:^(id error) {
        [SVProgressHUD showErrorWithStatus:@"差评失败"];
        [SVProgressHUD dismiss];
    }];
}


- (void)cancelClickBtn:(NSString *)commentId{
    [SVProgressHUD show];
    WS(ws)
    [ZRHomePageRequst requestDeleteAgreeWithCommentId:commentId andSuccess:^(id success) {
        //        [SVProgressHUD showSuccessWithStatus:@"取消成功"];
        //        [ws getBusinessData];
        //        [ws.myTableView reloadData];
        [SVProgressHUD dismiss];
//        ZRGroupBuyingReviewDetailsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        UIButton *btn = [cell viewWithTag:ws.btnTag];
//        [self reviewButtonClick:btn];
        
        NSString *screenStr = nil;
        if (ws.btnTag == 111) {
           screenStr = @"0";
        }else if (ws.btnTag == 112){
            screenStr = @"1";
        }else if (ws.btnTag == 113){
            screenStr = @"2";
        }else{
            screenStr = @"3";
        }
        [self selectData:screenStr];

        
    } andFailure:^(id error) {
        //        [SVProgressHUD showErrorWithStatus:@"取消失败"];
        [SVProgressHUD dismiss];
    }];
}



#pragma mark - click methods
- (void)reviewButtonClick:(UIButton *)sender
{
    
    WS(ws)
    [self.tableView startRefreshWithCallback:^{
        ws.btnTag = sender.tag;
        NSString *screen = nil;
        switch (sender.tag) {
            case 111:
            {
                //全部
                screen = @"0";
            }
                break;
            case 112:
            {
                //好评
                screen = @"1";
            }
                break;
            case 113:
            {
                //差评
                screen = @"2";
            }
                break;
            case 114:
            {
                //带图
                screen = @"3";
            }
                break;
                
            default:
                break;
        }
        
         //NSLog(@"选择全部还是别的======%@",screen);
        [ws selectData:screen];
        
        
    }];
    
    
}


#pragma mark - UITableViewDelegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat hei;
    if (indexPath.section == 0) {
        hei = 90*SCREEN_HEIGHT/667;
    }else{
        self.reviewFrame.commentListModel = self.commentListArray[indexPath.row];
        hei = self.reviewFrame.cellHeight;
        //NSLog(@"代理方法中行高======%f===index====%ld",hei,(long)indexPath.row);
    }
    
    return hei;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat hei;
    if (section == 0) {
        hei = 0.1;
    }else{
        hei = 20*SCREEN_HEIGHT/667;
    }
    return hei;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
//    ZRGroupBuyingReviewDetailsCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.commentListModel = self.commentListArray[indexPath.row];
//    
//    ZRReviewDetailController *reviewDetailVC = [[ZRReviewDetailController alloc] init];
//    [self.navigationController pushViewController:reviewDetailVC animated:YES];
//    reviewDetailVC.commentIdStr = cell.commentListModel.commentId;
    
}



#pragma mark - 网络请求获取数据
-(void)loadData
{
    WS(ws)
    [ZRHomePageRequst requestForBusinessCommentListWithBusinessId:self.businessId CommentType:[NSString stringWithFormat:@"%ld",(long)self.reviewsType] Screen:@"0" Rows:@"4" Page:@"1" Callback:^(id details, NSError *error) {

        [ws.tableView.mj_header endRefreshing];
        NSArray *arr = details;
        if (arr.count==4) {
            ws.tableView.mj_footer.hidden = NO;
            ws.tableView.mj_footer.state = MJRefreshStateIdle;
        }
        
        ws.commentListArray = [NSMutableArray array];
        [details enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZRCommentListModel *model = [ZRCommentListModel mj_objectWithKeyValues:obj];
            [ws.commentListArray addObject:model];
        }];
        
        [ws.tableView reloadData];
        
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
    [ZRHomePageRequst requestForBusinessCommentListWithBusinessId:self.businessId CommentType:[NSString stringWithFormat:@"%ld",(long)self.reviewsType] Screen:screenStr Rows:@"4" Page:[NSString stringWithFormat:@"%ld",(long)page] Callback:^(id details, NSError *error) {
        
        [ws.tableView.mj_footer endRefreshing];
        NSArray *arr = details;
        if (arr.count>0) {
            [details enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZRCommentListModel *model = [ZRCommentListModel mj_objectWithKeyValues:obj];
                [ws.commentListArray addObject:model];
            }];
            
            [ws.tableView reloadData];
        }else{
            //无更多数据了
            ws.tableView.mj_footer.state = MJRefreshStateNoMoreData;
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
    [ZRHomePageRequst requestForBusinessCommentListWithBusinessId:self.businessId CommentType:[NSString stringWithFormat:@"%ld",(long)self.reviewsType] Screen:screen Rows:@"4" Page:@"1" Callback:^(id details, NSError *error) {
        
        
        
        ws.commentListArray = [NSMutableArray array];
        [details enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZRCommentListModel *model = [ZRCommentListModel mj_objectWithKeyValues:obj];
            [ws.commentListArray addObject:model];
        }];
        
        [ws.tableView reloadData];
        [ws.tableView.mj_header endRefreshing];
        
        if (ws.commentListArray.count==4) {
            ws.tableView.mj_footer.hidden = NO;
            ws.tableView.mj_footer.state = MJRefreshStateIdle;
        }
       
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

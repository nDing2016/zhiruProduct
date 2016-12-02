//
//  ZRDiscoveryCell.m
//  zhiruProduct
//
//  Created by nanding on 16/7/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRDiscoveryCell.h"
#import "ZRDiscoveryTableCell.h"
#import "ZRColletionViewLayout.h"
#import "ZRRecommentHeader.h"

#import "ZRIntegralMallCell.h"

#import "ZRRecommendModel.h"
#import "ZRRecommendGroupListModel.h"
#import "ZRFindNewProduct.h"
#import "ZRCommodityListModel.h"

@interface ZRDiscoveryCell ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, ZRDiscoveryTableCellDelegate>


@property (nonatomic, strong) ZRRecommentHeader *headerView;

@property (nonatomic, strong) NSMutableArray *dataArr;


@property (nonatomic, strong) ZRRecommendModel *recommendModel;
@property (nonatomic, strong) ZRRecommendGroupListModel *groupListModel;

@property (nonatomic, strong) ZRFindNewProduct *findNewProduct;

@property (nonatomic, strong) ZRCommodityListModel *commodityList;

//@property (nonatomic, assign) NSInteger sectionNum;
//@property (nonatomic, strong) NSMutableArray *groupListArray;



@end

static NSString *ID = @"ID";
@implementation ZRDiscoveryCell

#pragma mark - 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGBCOLOR(240, 240, 240);
        //[self.contentView addSubview:_tableView];
        
    }
    return _tableView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        //流水布局
        ZRColletionViewLayout *layout = [[ZRColletionViewLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[ZRIntegralMallCell class] forCellWithReuseIdentifier:ID];
        _collectionView.backgroundColor = RGBCOLOR(240, 240, 240);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
       
    }
    return _collectionView;
}


-(NSMutableArray *)navImgArr
{
    if (!_navImgArr) {
        _navImgArr = [NSMutableArray array];
    }
    return _navImgArr;
}

-(NSMutableArray *)navTitleArr
{
    if (!_navTitleArr) {
        _navTitleArr = [NSMutableArray array];
    }
    return _navTitleArr;
}



/**
 *  悬浮向上的按钮
 *
 *  @return 
 */
-(UIButton *)upButton
{
    if (!_upButton) {
        
        CGFloat width = 40*SCREEN_WIDTH/375;
        CGFloat x = SCREEN_WIDTH-width-20;
        CGFloat y = self.frame.size.height-20-width;
        _upButton = [MyControl createButtonWithFrame:CGRectMake(x, y, width, width) ImageName:@"ft_fanhuijiantou" Target:self Action:@selector(upButtonClick:) Title:nil];
        
    }
    return _upButton;
}


- (void)showUpButton:(BOOL)b
{
    if (b== YES) {
        [self addSubview:self.upButton];
        [self bringSubviewToFront:self.upButton];
    }else{
        [_upButton removeFromSuperview];
    }
}






-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
    [self setNeedsDisplay];
    
    
}

-(void)setCollectionArray:(NSArray *)collectionArray
{
    _collectionArray = collectionArray;
    
    [self.collectionView reloadData];
    
}

///**
// *  积分商城数据
// *
// *  @return
// */
//-(NSMutableArray *)dataArr
//{
//    if (!_dataArr) {
//        
//        _dataArr = [NSMutableArray array];
//        for (int i=0; i<100; i++) {
//            if (i==0) {
//                [_dataArr addObject:@[@"titleImage"]];
//            }else{
//                NSArray *arr = @[@"tu-0",@"[牙膏中的爱马仕]意大利",@"Marvis玛尔斯25ml*7支套装",@"100"];
//                [_dataArr addObject:arr];
//            }
//            
//        }
//        
//    }
//    return _dataArr;
//}


#pragma mark - UICollectionViewDataSource   

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.mj_footer.hidden = self.collectionArray.count == 0;
    return _collectionArray.count+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZRIntegralMallCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.item == 0) {
        cell.commodityList = nil;
        cell.firstImg = _collectionFirstImg;
        
    }else{
        cell.firstImg = nil;
        _commodityList = [ZRCommodityListModel mj_objectWithKeyValues:_collectionArray[indexPath.item]];
        cell.commodityList = _commodityList;
        
        UIImageView *productImgView = [[UIImageView alloc] init];
        [productImgView sd_setImageWithURL:[NSURL URLWithString:_commodityList.img] placeholderImage:ZRImage(@"Default") completed:nil];
        [cell.contentView addSubview:productImgView];
        
        [productImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            //make.centerY.equalTo(@(myCell.contentView.centerY));
            //make.centerY.equalTo(myCell.contentView.mas_centerY);
            make.top.equalTo(@0);
            make.width.equalTo(@(cell.contentView.width));
            make.height.equalTo(@(cell.contentView.width*0.6));
            
        }];
        
        
    }
   
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item != 0) {
        _commodityList = [ZRCommodityListModel mj_objectWithKeyValues:_collectionArray[indexPath.item]];
        if ([self.delegate respondsToSelector:@selector(integralMallClickToProductDetail:WithIndex:WithData:)]) {
            [self.delegate integralMallClickToProductDetail:self WithIndex:indexPath.item WithData:_commodityList];
            
            
            
            
        }
        
    }
    
}




#pragma mark - UITableViewDataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.cellIndex == index0) {
        if (self.navImgArr.count>0 || self.navTitleArr.count>0) {
            return self.dataArray.count+1;
        }else{
            return self.dataArray.count;
        }

        
       
    }else
       return 1;
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cellIndex == index0) {
        if (section == 0) {
            return 1;
        }else
            _recommendModel = self.dataArray[section-1];
           
            return _recommendModel.groupList.count;
        
    }else
        return self.dataArray.count;
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRDiscoveryTableCell *cell = [ZRDiscoveryTableCell cellWithTableView:self.tableView withIndexPath:indexPath withKinds:self.cellIndex];
    cell.delegate = self;
    //cell.dic = nil;
    cell.findNewProduct = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    if (self.cellIndex == index0) {
        if (indexPath.section == 0) {
            cell.navImageArray = self.navImgArr;
            cell.navTitleArray = self.navTitleArr;
            
        }else{
            _recommendModel = self.dataArray[indexPath.section-1];
            cell.groupListModel = _recommendModel.groupList[indexPath.row];
            
        }
        
        
    }else{
        _findNewProduct = [ZRFindNewProduct mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        cell.findNewProduct = _findNewProduct;
        
    }
    
//    cell.layer.borderColor = [UIColor grayColor].CGColor;
//    cell.layer.borderWidth = 1;
    
    
    return cell;
    
}


#pragma mark - UITableViewDelegate methods

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.cellIndex == index0 && section != 0) {
        _headerView = [[ZRRecommentHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 105)];
        //NSDictionary *dic = self.dataArray[section-1];
        
        _recommendModel = self.dataArray[section-1];

        _headerView.titleStr = [[NSString alloc] initWithFormat:@"热门%@",_recommendModel.navName];
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sellAllTap:)];
        [_headerView addGestureRecognizer:tap];
        
        return _headerView;
    }else
        return nil;
    
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBCOLOR(173, 173, 173);
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
        
    }];
    
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellIndex == index0){
        if (indexPath.section == 0) {
            return 100;
        }else
            return 125;
    }else
        return 170;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.cellIndex == index0 && section != 0) {
        return 105;
    }else
        return 0.1;
    
    
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRDiscoveryTableCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (self.cellIndex == index0) {
        _recommendModel = self.dataArray[indexPath.section-1];
        cell.groupListModel = _recommendModel.groupList[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(pushToGroupBuyingDetailsControllerWithGroupList:)]) {
            [self.delegate pushToGroupBuyingDetailsControllerWithGroupList:cell.groupListModel];
        }

    }else{
        //NSLog(@"=========ddd=========%@",[self.dataArray[indexPath.section] class]);
        _findNewProduct = [ZRFindNewProduct mj_objectWithKeyValues:self.dataArray[indexPath.row]];
        cell.findNewProduct = _findNewProduct;
        if ([self.delegate respondsToSelector:@selector(pushToGroupBuyingDetailsControllerWithList:)]) {
            [self.delegate pushToGroupBuyingDetailsControllerWithList:cell.findNewProduct];
        }
        
        
        
    }
    
    
    

}


#pragma mark - ZRDiscoveryTableCellDelegate method
/**
 *  推荐：分类点击事件
 *
 *  @param sender 美食、丽人、娱乐、旅行、购物、生活
 */
-(void)categoriesClick:(NSInteger)btnTag withCell:(ZRDiscoveryTableCell *)tableCell
{
    if (btnTag<kDiscover_Category1+_navClick.count) {
        switch (btnTag) {
            case kDiscover_Category1:
            {
                
                CGRect rect = [self.tableView rectForFooterInSection:0];
                [self.tableView setContentOffset:CGPointMake(0,CGRectGetMaxY(rect)) animated:YES];
                
            }
                break;
            case kDiscover_Category1+1:
            {
                CGRect rect = [self.tableView rectForFooterInSection:1];
                [self.tableView setContentOffset:CGPointMake(0,CGRectGetMaxY(rect)) animated:YES];
                
            }
                break;
            case kDiscover_Category1+2:
            {
                CGRect rect = [self.tableView rectForFooterInSection:2];
                [self.tableView setContentOffset:CGPointMake(0,CGRectGetMaxY(rect)) animated:YES];
            }
                break;
            case kDiscover_Category1+3:
            {
                CGRect rect = [self.tableView rectForFooterInSection:3];
                [self.tableView setContentOffset:CGPointMake(0,CGRectGetMaxY(rect)) animated:YES];
            }
                break;
            case kDiscover_Category1+4:
            {
                CGRect rect = [self.tableView rectForFooterInSection:4];
                [self.tableView setContentOffset:CGPointMake(0,CGRectGetMaxY(rect)) animated:YES];
            }
                break;
            case kDiscover_Category1+5:
            {
                CGRect rect = [self.tableView rectForFooterInSection:5];
                [self.tableView setContentOffset:CGPointMake(0,CGRectGetMaxY(rect)) animated:YES];
            }
                break;
                
            default:
                break;
        }

        
    }else{

        [SVProgressHUD showErrorWithStatus:@"暂无推荐"];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
    }
    
}





#pragma mark - click methods
/**
 *  浮动向上的按钮点击事件
 *
 *  @param sender
 */
- (void)upButtonClick:(UIButton *)sender
{
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

/**
 *  推荐：查看全部
 *
 *  @param ges 手势
 */
- (void)sellAllTap:(UIGestureRecognizer *)ges
{
    if ([self.delegate respondsToSelector:@selector(recommendSeeAll:WithTitle:)]) {
        [self.delegate recommendSeeAll:self WithTitle:_headerView.titleStr];
    }
}



//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.1;
//}


@end

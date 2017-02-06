//
//  ZRBusinessDetailsCollectionCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBusinessDetailsCollectionCell.h"
#import "ZROrderingNavModel.h"
#import "ZROrderingAddress.h"
@interface ZRBusinessDetailsCollectionCell ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * myTableView;
@property (nonatomic , strong) NSMutableArray * businessInfoArr; //商家详情信息
@property (nonatomic , strong) NSArray * noticeInfoArr; // 公告
@property (nonatomic , assign) CGFloat offsetY;
@end

@implementation ZRBusinessDetailsCollectionCell

-(void)setModel:(ZROrderingBusinessMsgModel *)model{
    _model = model;
    self.myTableView.delegate = self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(NSMutableArray *)businessInfoArr{
    if (_businessInfoArr == nil) {
        _businessInfoArr = [NSMutableArray array];
        if (_isLunch == YES) {
            //品类
//            ZROrderingNavModel * pinName = _model.nav[0];
            NSString * pin = [NSString stringWithFormat:@"下单时间: %@",_model.order_time];
            //营业时间
            NSString * openTime = [NSString stringWithFormat:@"送餐时间: %@",_model.send_time];
            //送餐时间
            NSString * sendTime = [NSString stringWithFormat:@"联系电话: %@",_model.tel];
             [_businessInfoArr addObject:pin];
             [_businessInfoArr addObject:openTime];
             [_businessInfoArr addObject:sendTime];
            // 地址
            
            NSArray * addressArr = _model.readdress;
            ZROrderingAddress * addressModel ;
            for (NSInteger i=0; i<addressArr.count; i++) {
                addressModel = addressArr[i];
                NSString * address =[NSString stringWithFormat:@"取餐地址: %@",addressModel.address ];
                [_businessInfoArr addObject:address];
            }

            //支付方式
            NSString * paymentMethod = [NSString stringWithFormat:@"支付方式:在线支付"];
            [_businessInfoArr addObject:paymentMethod];
        }else{
            //品类
            ZROrderingNavModel * pinName = _model.nav[0];
            NSString * pin = [NSString stringWithFormat:@"品类: %@",pinName.nav_name];
            //营业时间
            NSString * openTime = [NSString stringWithFormat:@"营业时间: %@",_model.openTime];
            //送餐时间
            NSString * sendTime = [NSString stringWithFormat:@"送餐时间: %@",_model.sendTime];
            //联系电话
            NSString * tel = [NSString stringWithFormat:@"联系电话: %@",_model.tel];
            //地址
            NSString * address = [NSString stringWithFormat:@"地址: %@",_model.address];
            //支付方式
            NSString * paymentMethod = [NSString stringWithFormat:@"支付方式: %@",_model.paymentMethod];
            [_businessInfoArr addObject:pin];
            [_businessInfoArr addObject:openTime];
            [_businessInfoArr addObject:sendTime];
            [_businessInfoArr addObject:tel];
            [_businessInfoArr addObject:address];
            [_businessInfoArr addObject:paymentMethod];
        }
       
    }
    return _businessInfoArr;
}

-(NSArray *)noticeInfoArr{
    if (_noticeInfoArr == NO) {
        _noticeInfoArr = @[@"公告",_model.notice];
    }
    return _noticeInfoArr;
}
-(UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth ,self.contentView.height   ) style:UITableViewStylePlain];
        
        [self addSubview:_myTableView];
        
        _myTableView.backgroundColor = [UIColor clearColor];
        
        _myTableView.rowHeight = UITableViewAutomaticDimension;
        _myTableView.estimatedRowHeight = 60.0;
        _myTableView.tableFooterView = [UIView new];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

#pragma mark - tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
       
        case 0:
            return self.businessInfoArr.count;
            break;
        case 1:
            return 2;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString * CellTwo = @"BusinessInfoCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellTwo];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTwo];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            
            cell.textLabel.text = self.businessInfoArr[indexPath.row];
            
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            return cell;
        }
            
            break;
        case 1:
        {
            static NSString * CellThree = @"NoticeInfoCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellThree];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellThree];
            }
            cell.textLabel.text = self.noticeInfoArr[indexPath.row];
            cell.textLabel.numberOfLines = 0;
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            return cell;
        }
            break;
        default:
        {
            static NSString * cellFour = @"shopReviewsCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellFour];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellFour];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"到店点评";
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            return cell;
        }
            break;
    }
    

}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.section == 1) {
//        return 100;
//    }else{
//        return  40;
//    }
//}

#pragma mark -- 监听滑动距离
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    //89
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tableViewDidScroll" object:nil userInfo:@{@"offsetY":@(offsetY - _offsetY)}];
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
    _offsetY = scrollView.contentOffset.y;
    
}
@end

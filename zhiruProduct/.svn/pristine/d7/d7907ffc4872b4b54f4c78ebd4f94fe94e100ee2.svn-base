//
//  ZROrderMenuCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
// cell高 = 8 + count *15 + count * 文字高

#import "ZROrderMenuCell.h"
#import "ZROrderingMenuModel.h"
#import "NSString+ZRString.h"
#import "ZRSupermarketGoodsListModel.h"
#import "ZRSupermarketHomeObj.h"
#import "ZROrderingMenuModel.h"
#define TitleSize [UIFont systemFontOfSize:15]

@interface ZROrderMenuCell ()
@property (nonatomic , strong) UILabel *numbLabel;

@property (nonatomic , assign)NSInteger count;
@property (nonatomic , strong) NSMutableArray * lableArr;
@end

@implementation ZROrderMenuCell

-(void)setMenuArr:(NSArray *)menuArr{
    
    _menuArr = menuArr;
    _count = menuArr.count;
    [self createMenuCell:menuArr.count];
}

-(void)createMenuCell :(NSInteger)count {
    for (UIView * view  in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _lableArr = [NSMutableArray array];
    for (int i =0; i<count; i++) {
        //标题
        UILabel * MenuTitle = [UILabel new];
        MenuTitle.numberOfLines = 0;
        NSArray * arr = _menuArr[i];
        
        
        
        if (self.type == NO) {
            ZROrderingMenuModel * model = arr[0];
            MenuTitle.text = model.name;
            MenuTitle.font = TitleSize;
            [self.contentView addSubview:MenuTitle];
            
//            CGSize titleSize = [NSString getSize:model.name strFont:TitleSize maxSize:CGSizeMake(100, MAXFLOAT)];
//            [MenuTitle setFrame:CGRectMake(15, 8 + i * 15 + i * titleSize.height, 100, titleSize.height)];
           
            
            WS(ws)
            [MenuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.contentView).with.offset(15);
                make.top.equalTo(ws.contentView).with.offset(15 +  i * 15 + i * 40);
                make.width.equalTo(@100);
                
            }];
            if (i== count -1) {
                [MenuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(ws.contentView).with.offset(-15);
                }];
            }
            
            
            //加号
            UIButton * addBtn = [UIButton new];
            [addBtn setImage:[UIImage imageNamed:@"jia_hong"] forState:UIControlStateNormal];
            [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            addBtn.tag = i;
            [addBtn sizeToFit];
            
            [self.contentView addSubview:addBtn];
            
            [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(MenuTitle.mas_centerY);
                make.right.equalTo(ws.contentView.mas_right).offset(-15);
            }];
            
            // 数字
            UILabel * numbLabel = [UILabel new];
            numbLabel.font = TitleSize;
            [_lableArr addObject:numbLabel];
            numbLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)arr.count];
            
            [self.contentView addSubview:numbLabel];
            
            [numbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(MenuTitle.mas_centerY);
                make.right.equalTo(addBtn.mas_left).offset(-10);
            }];
            
            //减号
            UIButton * jianBtn = [UIButton new];
            
            [jianBtn setImage:[UIImage imageNamed:@"jian_hong"] forState:UIControlStateNormal];
            jianBtn.tag = i;
            [jianBtn addTarget:self action:@selector(minBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [jianBtn sizeToFit];
            
            [self.contentView addSubview:jianBtn];
            
            [jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(MenuTitle.mas_centerY);
                make.right.equalTo(numbLabel.mas_left).offset(-10);
            }];
            
            //价格
            UILabel * moneyLabel = [UILabel new];
            moneyLabel.font = TitleSize;
            
            moneyLabel.text = [NSString stringWithFormat:@"$%@",[model.unit_price stringValue]];
            
            [self.contentView addSubview: moneyLabel];
            
            [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo (MenuTitle.mas_centerY);
                make.right.equalTo(jianBtn.mas_left).offset(-15);
            }];
            
            
            
        } else {
            ZRSupermarketGoodsListModel * model = arr[0];
            MenuTitle.text = model.goods_name;
            MenuTitle.font = TitleSize;
            [self.contentView addSubview:MenuTitle];
            
//            CGSize titleSize = [NSString getSize:model.goods_name strFont:TitleSize maxSize:CGSizeMake(100, 40)];
//            [MenuTitle setFrame:CGRectMake(15, 8 + i * 15 + i * titleSize.height, 100, titleSize.height)];
            WS(ws)
            [MenuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.contentView).with.offset(15);
                make.top.equalTo(ws.contentView).with.offset(15 +  i * 15 + i * 40);
                make.width.equalTo(@100);
            }];
            if (i== count -1) {
                [MenuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(ws.contentView).with.offset(-15);
                }];
            }
            
            //加号
            UIButton * addBtn = [UIButton new];
            [addBtn setImage:[UIImage imageNamed:@"jia_hong"] forState:UIControlStateNormal];
            [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            addBtn.tag = i;
            [addBtn sizeToFit];
            
            [self.contentView addSubview:addBtn];
//            WS(ws)
            [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(MenuTitle.mas_centerY);
                make.right.equalTo(ws.contentView.mas_right).offset(-15);
            }];
            
            // 数字
            UILabel * numbLabel = [UILabel new];
            numbLabel.font = TitleSize;
//            _numbLabel = numbLabel;
            [_lableArr addObject:numbLabel];
            numbLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)arr.count];
            
            [self.contentView addSubview:numbLabel];
            
            [numbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(MenuTitle.mas_centerY);
                make.right.equalTo(addBtn.mas_left).offset(-10);
            }];
            
            //减号
            UIButton * jianBtn = [UIButton new];
            
            [jianBtn setImage:[UIImage imageNamed:@"jian_hong"] forState:UIControlStateNormal];
            jianBtn.tag = i;
            [jianBtn addTarget:self action:@selector(minBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [jianBtn sizeToFit];
            
            [self.contentView addSubview:jianBtn];
            
            [jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(MenuTitle.mas_centerY);
                make.right.equalTo(numbLabel.mas_left).offset(-10);
            }];
            
            //价格
            UILabel * moneyLabel = [UILabel new];
            moneyLabel.font = TitleSize;
            
            moneyLabel.text = [NSString stringWithFormat:@"$%@",model.now_price];
            
            [self.contentView addSubview: moneyLabel];
            
            [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo (MenuTitle.mas_centerY);
                make.right.equalTo(jianBtn.mas_left).offset(-15);
            }];
            


        }
        
        
        
        
    }
}

#pragma mark - 加减号 点击方法


- (void)addBtnClick :(UIButton *)btn{
    
    NSInteger index = btn.tag;
    
    UILabel * myLabel =  _lableArr[index];
     NSInteger numb =  [myLabel.text integerValue];
    myLabel.text = [NSString stringWithFormat:@"%ld",(long)(numb+=1)];
    NSMutableArray * marr;
    if (self.type == YES) {
         marr =  [ZRSupermarketHomeObj shareInstance].allProductsArray;
    }else{
          marr =  [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
    }

    
    ZROrderingMenuModel * model = [marr[index] lastObject];
    [marr[index] addObject:model];
    
    //执行回调
    if (self.upDataCount) {
        self.upDataCount();
    }
}

//- (void)btnClick:(UIButton *)btn{

    //tag 0 加号 1 减号
//    NSArray * arr = _menuArr[i];
//    switch (btn.tag) {
//        case 0:
//        {
//            //点击加号
//            NSInteger numb =  [_numbLabel.text integerValue];
//            _numbLabel.text = [NSString stringWithFormat:@"%ld",numb+=1];
//            _count = numb;
////            //创建一个消息对象
////            NSNotification * notice = [NSNotification notificationWithName:ZRNotificationAdd object:nil userInfo:@{@"isAdd":@"1"}];
////            //发送消息
////            [[NSNotificationCenter defaultCenter]postNotification:notice];
//            //发送通知
//            
//            //执行回调
//            if (self.upDataCount) {
//                self.upDataCount();
//            }
//        }
//            break;
//        case 1:
//        {
//            NSInteger numb = [_numbLabel.text integerValue];
//            if (numb == 1) {
//                break;
//            }
//            NSNotification * notice = [NSNotification notificationWithName:ZRNotificationAdd object:nil userInfo:@{@"isAdd":@"0"}];
//            //发送消息
//            [[NSNotificationCenter defaultCenter]postNotification:notice];
//            _numbLabel.text = [NSString stringWithFormat:@"%ld",numb-=1];
//             _count = numb;
//            //执行回调
//            if (self.upDataCount) {
//                self.upDataCount();
//            }
//        }
//            break;
//        default:
//            break;
//    }
//}


- (void)minBtnClick:(UIButton *)btn{
    NSInteger index = btn.tag;
    
    UILabel * myLabel =  _lableArr[index];
    NSInteger numb =  [myLabel.text integerValue];
    
    if (numb == 1) {return;}
    
    myLabel.text = [NSString stringWithFormat:@"%ld",(long)(numb-=1)];
    NSMutableArray * marr =  [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
    
//    ZROrderingMenuModel * model = [marr[index] lastObject];
//    [marr[index] addObject:model];
    [marr[index] removeLastObject];

    if (self.upDataCount) {
        self.upDataCount();
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

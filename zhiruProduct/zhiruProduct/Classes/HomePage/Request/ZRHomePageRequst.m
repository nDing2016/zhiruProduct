

//
//  ZRHomePageRequst.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/23.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHomePageRequst.h"
#import "ZRAFNRequests.h"
#import "ZRHomeDataModel.h"
#import "ZRHomeNavModel.h"
#import "ZRBusinessDetailsModel.h"
#import "ZROrderingModel.h"
#import "ZROrderingDetailModel.h"
#import "ZROrderingBusinessMsg.h"
#import "ZRBusinessModel.h"
#import "ZRGroupModel.h"
#import "ZRPhotosModel.h"
#import "ZRCommentListModel.h"

static NSString * const zAppgameHome = @"recreation/index";
static NSString * const zAppHomePage= @"index";
static NSString * const zAppBusinessDetails= @"findtaste/details";
static NSString * const zAppBusinessAddComment = @"businessComment/add";
static NSString * const zAppGroupNavId = @"group/navIndex";
static NSString * const zAppOrderingList = @"ordering";
static NSString * const zAppOrderingDetails = @"ordering/details";
static NSString * const zAppOrderingQuery = @"ordering/list";
static NSString * const zAppFindtasteList = @"findtaste/list";
static NSString * const zAppFindtasteIndex = @"findtaste/index";
static NSString * const zAppGrouplist = @"group/list";
static NSString * const zAppModellingList = @"modelling/list";
static NSString * const zAppcollectionAddGroupCollection = @"collection/addGroupCollection";
static NSString * const zAppcollectionAddOrderingCollection = @"collection/addOrderingCollection";
static NSString * const zAppLunch = @"lunch/index";
static NSString * const addBusinessCollection = @"collection/addBusinessCollection";
//午餐添加订单
static NSString *const zAddLunchOrder = @"lunch/addLunchOrder";

//我的店铺店铺评论
static NSString *const zBusinessCommentList = @"businessComment/list";

@implementation ZRHomePageRequst


+ (void)requestGetAppHomePageWithLongitude :(NSString *)longitude
                               andLatitude :(NSString *)latitude
                                 andSuccess: (void(^)(NSMutableArray * marr))success
                                 andFailure:(void(^)(id error))failure {
    
    NSDictionary * parameter = @{@"longitude":longitude,@"latitude":latitude};
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppHomePage] parameters:parameter success:^(id result) {
        
        if (result[@"data"]) {
            NSMutableArray * marr = [NSMutableArray array];
            ZRHomeDataModel * dataM = [ZRHomeDataModel mj_objectWithKeyValues:result[@"data"]];
            
            [marr addObject:dataM];
            
            success(marr);
        }else{
            failure(@"null");
        }
        
    } failure:^(id error) {
        failure(error);
    }];

}

+ (void)requestGetMainNavWithUrl :(NSString*)url
                    andLongitude :(NSString *)longitude
                     andLatitude :(NSString *)latitude
                       andSuccess: (void(^)(NSMutableArray * marr))success
                       andFailure:(void(^)(id error))failure{
    
    NSDictionary * parameter = @{@"longitude":longitude,@"latitude":latitude};
    
    [ZRAFNRequests post:url parameters:parameter success:^(id result) {
       //请求筛选
        if (result[@"data"]) {
            NSMutableArray * marr = [NSMutableArray array];
            
            ZRHomeNavModel * navModel = [ZRHomeNavModel mj_objectWithKeyValues:result[@"data"]];
            
            [marr addObject:navModel];
            
            success(marr);
        }else{
            failure(@"null");
        }
    } failure:^(id error) {
        failure(error);
    }];
}

+ (void)requestGetBusinessDetailsWithBusinessId :(NSString *)businessId
                                      andSuccess: (void(^)(NSMutableArray * marr))success
                                      andFailure:(void(^)(id error))failure{
    
    NSDictionary * parameter = @{@"businessId":businessId};
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppBusinessDetails] parameters:parameter success:^(id result) {
        
        if (result[@"data"]) {
            NSMutableArray * marr = [NSMutableArray array];
            ZRBusinessDetailsModel * dataM = [ZRBusinessDetailsModel mj_objectWithKeyValues:result[@"data"]];
            
            [marr addObject:dataM];
            success(marr);
        }else{
            failure(@"null");
        }
    } failure:^(id error) {
        failure(error);
    }];
}


+ (void)requestAddBusinessCommentWithBusinessId :(NSString *)businessId
                                     andContent : (NSString *)content
                                   andPerCapita :(NSString *)perCapita
                                       andGrade :(NSString *)grade
                                    andGradeOne :(NSString *)gradeOne
                                    andGradeTwo :(NSString *)gradeTwo
                                  andGradeThree :(NSString *)gradeThree
                                  andCommentType:(NSString *)commentType
                                       andFiles :(NSArray *)commentImgList
                                      andSuccess: (void(^)(id success))success
                                      andFailure:(void(^)(id error))failure {
    
    NSDictionary * parameter = @{@"businessId":businessId , @"content" : content , @"perCapita" : perCapita , @"grade" : grade , @"gradeOne" : gradeOne , @"gradeTwo" : gradeTwo , @"gradeThree": gradeThree ,@"commentType" : commentType };
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppBusinessAddComment] parameters:parameter imageFile:commentImgList fileKey:@"commentImgList" success:^(id result) {
        
        success(result[@"message"]);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
//    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppBusinessAddComment]  parameters:parameter success:^(id result) {
//         success(result[@"message"]);
//    } failure:^(id error) {
//        failure(error);
//    }];
    
}


+ (void)requestGetGroupWithNavId :(NSString *)navId
                    andLongitude :(NSString *)longitude
                     andLatitude :(NSString *)latitude
                       andSuccess: (void(^)(id success))success
                       andFailure:(void(^)(id error))failure {
    NSDictionary * parameter = @{@"longitude":longitude , @"latitude":latitude , @"navId" : navId};
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppGroupNavId] parameters:parameter success:^(id result) {
        
        if (result[@"data"]) {
            NSMutableArray * marr = [NSMutableArray array];
            ZRHomeNavModel * dataM = [ZRHomeNavModel mj_objectWithKeyValues:result[@"data"]];
            
            [marr addObject:dataM];
            success(marr);
        }else{
            failure(@"null");
        }
        
        
    } failure:^(id error) {
        failure(error);
    }];
}

+ (void)requestOrderingListWithLongitude:(NSString *)longitude
                            andLatitude :(NSString *)latitude
                                andLabel: (NSString *)label
                              andSuccess: (void(^)(id success))success
                              andFailure:(void(^)(id error))failure {
    if (label == nil) {
        label = @"";
    }
    
    NSDictionary * parameter = @{@"longitude":longitude , @"latitude":latitude , @"label" : label};

    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppOrderingList] parameters:parameter success:^(id result) {
        
        if (result[@"data"]) {
             ZROrderingModel * dataM = [ZROrderingModel mj_objectWithKeyValues:result[@"data"]];
            
            success(dataM);
        }else{
            failure(@"NULL");
        }

    } failure:^(id error) {
        failure(error);
    }];
}


+ (void)requestOrderingDetailsWithLongitude :(NSString *)longitude
                                andLatitude :(NSString *)latitude
                              andBusinessId :(NSString *)businessId
                                  andSuccess: (void(^)(id success))success
                                  andFailure:(void(^)(id error))failure{
    
    NSDictionary * parameter = @{@"longitude":longitude , @"latitude":latitude , @"orderingId" : businessId};
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppOrderingDetails] parameters:parameter success:^(id result) {
        if (result[@"data"]) {

            ZROrderingDetailModel * dataM = [ZROrderingDetailModel mj_objectWithKeyValues:result[@"data"]];

            success(dataM);
        }else{
            failure(@"null");
        }
    } failure:^(id error) {
        failure(error);
    }];
}


+ (void)requestOrderingListQueryWithLongitude :(NSString *)longitude
                                  andLatitude :(NSString *)latitude
                                  andDistance :(NSString *)distance
                                      andLabel: (NSString *)label
                                      andSort :(NSString *)sort
                                    andScreen :(NSString *)screen
                                      andRows :(NSString *)rows
                                      andPage :(NSString *)page
                                    andSuccess: (void(^)(id success))success
                                    andFailure:(void(^)(id error))failure{
    NSDictionary * parameter = @{@"longitude":longitude , @"latitude" : latitude , @"distance" : distance , @"label" : label , @"sort" : sort , @"screen" : @"0", @"rows" : rows , @"page" : page};
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppOrderingQuery] parameters:parameter success:^(id result) {
        
        NSMutableArray * resultMarr = [NSMutableArray array];
        NSArray * resultArr = result[@"data"];
        for (int i =0;i < resultArr.count ; i++) {
            ZROrderingBusinessMsg *model = [ZROrderingBusinessMsg mj_objectWithKeyValues:resultArr[i]];
            [resultMarr addObject:model];
        }
        
        success (resultMarr);
    } failure:^(id error) {
        failure(error);
    }];
}

+ (void)requestGetFindtasteListWithLongitude :(NSString *)longitude
                                 andLatitude :(NSString *)latitude
                                 andRegionId :(NSString *)regionId
                                     andCity :(NSString *)city
                                    andLabel : (NSString *)label
                                     andSort :(NSString *)sort
                                   andScreen :(NSString *)screen
                                     andRows :(NSString *)rows
                                     andPage :(NSString *)page
                                   andSuccess: (void(^)(id success))success
                                   andFailure:(void(^)(id error))failure{
    
    NSDictionary * parameter = @{@"longitude": longitude ,@"latitude" : latitude , @"regionId" : regionId, @"city" : city  , @"label":label , @"sort":sort , @"screen":screen,@"rows" : rows , @"page" : page};
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppFindtasteList] parameters:parameter success:^(id result) {
        NSMutableArray * resultMarr = [NSMutableArray array];
        NSArray * resultArr = result[@"data"];
        for (int i =0;i < resultArr.count ; i++) {
            
            ZRBusinessModel *model = [ZRBusinessModel mj_objectWithKeyValues:resultArr[i]];
            [resultMarr addObject:model];
        }
        
        success (resultMarr);

    } failure:^(id error) {
        
        failure(error);
    }];
}


+ (void)requestGetFindtasteIndexWithLongitude :(NSString *)longitude
                                  andLatitude :(NSString *)latitude
                                     andLabel :(NSString *)label
                                    andSuccess: (void(^)(id success))success
                                    andFailure:(void(^)(id error))failure{
    
    if (longitude == nil || latitude == nil || label == nil) {
        longitude = ZRLongitude;
        latitude = ZRLatitude;
        label = @"0";
    }
    
    NSDictionary * parameter = @{@"longitude":longitude , @"latitude":latitude , @"label" : label};
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppFindtasteIndex] parameters:parameter success:^(id result) {
        
        if (result[@"data"]) {
            NSMutableArray * marr = [NSMutableArray array];
            ZRHomeNavModel * dataM = [ZRHomeNavModel mj_objectWithKeyValues:result[@"data"]];
            
            [marr addObject:dataM];
            success(marr);
        }else{
            failure(@"null");
        }
        
    } failure:^(id error) {
        failure(error);
    }];
}


+ (void)requestGetGroupListWithLongitude :(NSString *)longitude
                             andLatitude :(NSString *)latitude
                             andRegionId :(NSString *)regionId
                                 andNavId: (NSString *)navId
                                andLabel : (NSString *)label
                                 andSort :(NSString *)sort
                                 andRows :(NSString *)rows
                                 andPage :(NSString *)page
                               andSuccess: (void(^)(id success))success
                               andFailure:(void(^)(id error))failure{
    
    NSDictionary * parameter = @{@"longitude":longitude , @"latitude":latitude , @"label" : label , @"regionId" : regionId , @"sort" : sort , @"navId" : navId ,@"rows" : rows , @"page" : page};
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppGrouplist] parameters:parameter success:^(id result) {
        
        NSMutableArray * resultMarr = [NSMutableArray array];
        NSArray * resultArr = result[@"data"];
        for (int i =0;i < resultArr.count ; i++) {
            
            ZRGroupModel *model = [ZRGroupModel mj_objectWithKeyValues:resultArr[i]];
            [resultMarr addObject:model];
        }
        
        success (resultMarr);
    } failure:^(id error) {
        failure(error);
    }];
}


+ (void)requestGetModellingListWithLongitude :(NSString *)longitude
                                 andLatitude :(NSString *)latitude
                                 andRegionId :(NSString *)regionId
                                    andLabel : (NSString *)label
                                     andSort :(NSString *)sort
                                   andScreen :(NSString *)screen
                                     andRows :(NSString *)rows
                                     andPage :(NSString *)page
                                   andSuccess: (void(^)(id success))success
                                   andFailure:(void(^)(id error))failure {
    
    NSDictionary * parameter = @{@"longitude":longitude , @"latitude":latitude ,@"regionId":regionId, @"label" : label ,  @"sort" : sort , @"screen" : screen ,@"rows" : rows , @"page" : page};
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppModellingList] parameters:parameter success:^(id result) {

        NSMutableArray * resultMarr = [NSMutableArray array];
        NSArray * resultArr = result[@"data"];
        for (int i =0;i < resultArr.count ; i++) {
            
            ZRBusinessModel *model = [ZRBusinessModel mj_objectWithKeyValues:resultArr[i]];
            [resultMarr addObject:model];
        }
        
        success (resultMarr);
    } failure:^(id error) {
        failure(error);
    }];
}


//收藏
+ (void)requestCollectionAddGroupCollectionWithBusinessId:(NSString *) businessId
                                              andGroupId :(NSString *)groupId
                                               andSuccess: (void(^)(id success))success
                                               andFailure:(void(^)(id error))failure {
    
    NSDictionary * parameter = @{@"businessId":businessId  , @"groupId" : groupId };
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppcollectionAddGroupCollection] parameters:parameter success:^(id result) {
        
        success(result[@"massage"]);
    } failure:^(id error) {
        failure(error);
    }];
}

+ (void)requestCollectionAddBusinessCollectionWithBusinessId:(NSString *) businessId
                                                  andSuccess: (void(^)(id success))success
                                                  andFailure:(void(^)(id error))failure {
    
    NSDictionary * parameter = @{@"businessId":businessId };
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,addBusinessCollection] parameters:parameter success:^(id result) {
        
        success(result[@"message"]);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 店铺内部图片
 * @param businessId 店铺ID
 * @param callBack   成功
 * @param failure    失败
 */
+ (void)requestGetBusinessPhotosWithBusinessId:(NSString *)businessId
                                      CallBack:(void(^)(NSMutableArray * success))callBack
                                       Failure:(void(^)(id error))failure
{
    NSString * urlStr = [HOST stringByAppendingString:@"findtaste/businessImg"];
    NSDictionary * param = @{@"businessId":businessId};
    [ZRAFNRequests post:urlStr parameters:param success:^(id result) {
        NSDictionary * dict = result;
        NSMutableArray * array = [NSMutableArray array];
        NSArray * dataArray = [dict objectForKey:@"data"];
        for (NSInteger i = 0; i < dataArray.count; i++) {
            ZRPhotosModel * model = [ZRPhotosModel mj_objectWithKeyValues:dataArray[i]];
            [array addObject:model];
        }
        callBack(array);
    } failure:^(id error) {
        failure(error);
    }];
}

+ (void)requestGetLunchInfoAndSuccess: (void(^)(id success))success
                           andFailure:(void(^)(id error))failure{
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@%@",HOST,zAppLunch] parameters:@{} success:^(id result) {
        if (result[@"data"]) {
            ZROrderingDetailModel * dataM = [ZROrderingDetailModel mj_objectWithKeyValues:result[@"data"]];
            
            success(dataM);
        }else{
            failure(@"NULL");
        }
        
    } failure:^(id error) {
        failure(error);
    }];
}




/**
 *  午餐添加订单接口
 *
 *  @param sendTime        送达时间
 *  @param price           小费
 *  @param taxation        税费
 *  @param canadianDollar           总计
 *  @param receiptAddress  收货地址
 *  @param personName      负责人
 *  @param personPhone     负责人电话
 *  @param takeMealName    取餐人姓名
 *  @param takeMealPhone   取餐人电话
 *  @param payMethod       支付方式
 *  @param remarks         备注
 *  @param LunchOrderGoods 午餐列表
 *  @param callback        回调
 */
+ (void)requestForAddLunchOrderWithSendTime:(NSString *)sendTime
                                      Price:(NSString *)price
                                   Taxation:(NSString *)taxation
                             CanadianDollar:(NSString *)canadianDollar
                             ReceiptAddress:(NSString *)receiptAddress
                                 PersonName:(NSString *)personName
                                PersonPhone:(NSString *)personPhone
                               TakeMealName:(NSString *)takeMealName
                              TakeMealPhone:(NSString *)takeMealPhone
                                  PayMethod:(NSString *)payMethod
                                    Remarks:(NSString *)remarks
                            LunchOrderGoods:(NSArray *)LunchOrderGoods
                                   CallBack:(ZRAddLunchOrderCallback)callback
{
    NSString *url = [HOST stringByAppendingString:zAddLunchOrder];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:sendTime forKey:@"sendTime"];
    [parameters setObject:price forKey:@"price"];
    [parameters setObject:taxation forKey:@"taxation"];
    [parameters setObject:canadianDollar forKey:@"canadianDollar"];
    [parameters setObject:receiptAddress forKey:@"receiptAddress"];
    [parameters setObject:personName forKey:@"personName"];
    [parameters setObject:personPhone forKey:@"personPhone"];
    [parameters setObject:takeMealName forKey:@"takeMealName"];
    [parameters setObject:takeMealPhone forKey:@"takeMealPhone"];
    [parameters setObject:payMethod forKey:@"payMethod"];
    [parameters setObject:remarks forKey:@"remarks"];
    [parameters setObject:LunchOrderGoods forKey:@"LunchOrderGoods"];
    
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if ([result[@"code"] isEqualToString:@"S000"]) {
            if (result[@"data"]) {
                if (callback) {
                    callback(result[@"data"],nil);
                }
            }
        }

        
        
        
    } failure:^(id error) {
        if (callback) {
            callback(nil,error);
        }
        
    }];
    
    
}






+ (void)requestBusinessCommentListWithBusinessId : (NSString *)businessId
                                      withScreen :(NSString *)screen
                                    andCommentType:(NSString *)commentType
                                       andSuccess: (void(^)(id success))success
                                       andFailure:(void(^)(id error))failure{
    
    NSDictionary * parameters = @{@"businessId":businessId , @"screen":screen , @"commentType":commentType };
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@businessComment/list",HOST] parameters:parameters success:^(id result) {
        
        NSArray * commentListArr = result[@"data"];
        
        NSMutableArray * successMarr = [NSMutableArray array];
        
        for (NSInteger i =0; i<commentListArr.count; i++) {
            ZRCommentListModel * commentModel = [ZRCommentListModel mj_objectWithKeyValues:commentListArr[i]];
            [successMarr addObject:commentModel];
            
        }
        
        
        success(successMarr);
    } failure:^(id error) {
        failure(error);
    }];
}

+ (void)requestAgreeWithCommentId :(NSString *)commentId
                        andSuccess: (void(^)(id success))success
                        andFailure:(void(^)(id error))failure{
    
  
    
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@businessComment/agree",HOST] parameters:@{@"commentId":commentId} success:^(id result) {
        success(result[@"massage"]);
    } failure:^(id error) {
        failure(error);
    }];
}


+ (void)requestNoAgreeWithCommentId :(NSString *)commentId
                          andSuccess: (void(^)(id success))success
                          andFailure:(void(^)(id error))failure{
    
 
   
    [ZRAFNRequests post:[NSString stringWithFormat:@"%@businessComment/noagree",HOST] parameters:@{@"commentId":commentId} success:^(id result) {
        success(result[@"massage"]);
    } failure:^(id error) {
        failure(error);
    }];
}

+ (void)requestDeleteAgreeWithCommentId :(NSString *)commentId
                              andSuccess: (void(^)(id success))success
                              andFailure:(void(^)(id error))failure{
    

    [ZRAFNRequests post:[NSString stringWithFormat:@"%@businessComment/deleteAgree",HOST] parameters:@{@"commentId":commentId} success:^(id result) {
        success(result[@"massage"]);
    } failure:^(id error) {
        failure(error);
    }];
}




/**
 *  店铺评论-评论列表
 *
 *  @param businessId  店铺id
 *  @param commentType 评论类型1店铺评论2团购评论
 *  @param screen      筛选”0全部1好评2差评3带图
 *  @param rows        条数
 *  @param page        页码
 *  @param callback    回调
 */
+ (void)requestForBusinessCommentListWithBusinessId:(NSString *)businessId
                                        CommentType:(NSString *)commentType
                                             Screen:(NSString *)screen
                                               Rows:(NSString *)rows
                                               Page:(NSString *)page
                                           Callback:(ZRBusinessCommentCallback)callback
{
    NSString *url = [HOST stringByAppendingString:zBusinessCommentList];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:businessId forKey:@"businessId"];
    [parameters setObject:commentType forKey:@"commentType"];
    [parameters setObject:screen forKey:@"screen"];
    [parameters setObject:rows forKey:@"rows"];
    [parameters setObject:page forKey:@"page"];
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if ([result[@"code"] isEqualToString:@"S000"]) {
            if (callback) {
                callback(result[@"data"],nil);
            }
        }else{
            if (callback) {
                callback(nil,result[@"message"]);
            }
        }
        
        
        
        
    } failure:^(id error) {
        if (callback) {
            callback(nil, error);
        }
        
    }];
    
}







@end

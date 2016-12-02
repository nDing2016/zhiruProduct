//
//  ZRHomePageRequst.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/23.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZRAddLunchOrderCallback) (id details, NSError *error);
typedef void(^ZRBusinessCommentCallback) (id details, NSError *error);

@interface ZRHomePageRequst : NSObject

/**
 *  app首页数据请求
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestGetAppHomePageWithLongitude :(NSString *)longitude
                               andLatitude :(NSString *)latitude
                                 andSuccess: (void(^)(NSMutableArray * marr))success
                                 andFailure:(void(^)(id error))failure;

/**
 *  首页顶部按钮网络请求 例如 寻味,丽人
 *
 *  @param url       请求地址
 *  @param longitude 横坐标
 *  @param latitude  纵坐标
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestGetMainNavWithUrl :(NSString*)url
                    andLongitude :(NSString *)longitude
                     andLatitude :(NSString *)latitude
                       andSuccess: (void(^)(NSMutableArray * marr))success
                       andFailure:(void(^)(id error))failure;

/**
 *  店铺详情请求
 *
 *  @param businessId 店铺id
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)requestGetBusinessDetailsWithBusinessId :(NSString *)businessId
                                      andSuccess: (void(^)(NSMutableArray * marr))success
                                      andFailure:(void(^)(id error))failure;

/**
 *  发布评论
 *
 *  @param businessId     商户id
 *  @param content        评论内容
 *  @param perCapita      人均消费
 *  @param grade          总体评分
 *  @param gradeOne       详细评价1
 *  @param gradeTwo       详细评价2
 *  @param gradeThree     详细评价3
 *  @param commentType    ”评论类型: 1店铺评论2团购评论”
 *  @param commentImgList  评论图片
 *  @param success        成功
 *  @param failure        失败
 */
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
                                      andFailure:(void(^)(id error))failure;

/**
 *  团购分类
 *
 *  @param navId     分类id
 *  @param longitude 横坐标
 *  @param latitude  纵坐标
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestGetGroupWithNavId :(NSString *)navId
                    andLongitude :(NSString *)longitude
                     andLatitude :(NSString *)latitude
                       andSuccess: (void(^)(id success))success
                       andFailure:(void(^)(id error))failure;

/**
 *  寻味
 *
 *  @param navId     分类id
 *  @param longitude 横坐标
 *  @param latitud 纵坐标
 *  @param success   成功
 *  @param failure   失败 
 */
+ (void)requestListGroupWithNavId :(NSString *)navId
                     andLongitude :(NSString *)longitude
                      andLatitude :(NSString *)latitude
                        andSuccess: (void(^)(id success))success
                        andFailure:(void(^)(id error))failure;


/**
 *  分页请求寻味列表
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param regionId  地域
 *  @param city      城市id
 *  @param navId     分类
 *  @param label     标签
 *  @param sort      排序
 *  @param screen    筛选
 *  @param rows      条数
 *  @param page      页数
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestLookForTasteWithLongitude:(NSString *)longitude
                            andLatitude :(NSString *)latitude
                            andRegionId :(NSString *)regionId
                                andCity : (NSString *)city
                               andNavId : (NSString *)navId
                               andLabel :(NSString *)label
                                andSort :(NSString *)sort
                              andScreen :(NSString *)screen
                                andRows :(NSString *)rows
                                andPage :(NSString *)page
                              andSuccess: (void(^)(id success))success
                              andFailure:(void(^)(id error))failure;


/**
 *  订餐首页请求
 *
 *  @param longitude 横坐标
 *  @param latitude  纵坐标
 *  @param label     分类
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestOrderingListWithLongitude:(NSString *)longitude
                            andLatitude :(NSString *)latitude
                                andLabel: (NSString *)label
                              andSuccess: (void(^)(id success))success
                              andFailure:(void(^)(id error))failure;
/**
 *  餐厅详情页
 *
 *  @param longitude  横坐标
 *  @param latitude   纵坐标
 *  @param businessId 店铺id
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)requestOrderingDetailsWithLongitude :(NSString *)longitude
                                andLatitude :(NSString *)latitude
                              andBusinessId :(NSString *)businessId
                                  andSuccess: (void(^)(id success))success
                                  andFailure:(void(^)(id error))failure;

/**
 *  订餐查询列表
 *
 *  @param longitude 横坐标
 *  @param latitude  纵坐标
 *  @param distance  距离区间
 *  @param label     分类
 *  @param sort      排序
 *  @param screen    筛选
 *  @param rows      条数
 *  @param page      页数
 *  @param success   成功
 *  @param failure      失败
 */
+ (void)requestOrderingListQueryWithLongitude :(NSString *)longitude
                                  andLatitude :(NSString *)latitude
                                  andDistance :(NSString *)distance
                                      andLabel: (NSString *)label
                                      andSort :(NSString *)sort
                                    andScreen :(NSString *)screen
                                      andRows :(NSString *)rows
                                      andPage :(NSString *)page
                                    andSuccess: (void(^)(id success))success
                                    andFailure:(void(^)(id error))failure;

/**
 *  寻味查询列表
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param regionId  地域
 *  @param city      城市id
 *  @param navId     分类
 *  @param label     标签
 *  @param sort      排序
 *  @param screen    筛选
 *  @param rows      条数
 *  @param page      页数
 *  @param success   成功
 *  @param failure   失败
 */
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
                                   andFailure:(void(^)(id error))failure;


/**
 *  寻味顶部8个按钮点击请求
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param label     分类id
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestGetFindtasteIndexWithLongitude :(NSString *)longitude
                                  andLatitude :(NSString *)latitude
                                     andLabel :(NSString *)label
                                    andSuccess: (void(^)(id success))success
                                    andFailure:(void(^)(id error))failure;

/**
 *  团购列表
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param regionId  地域
 *  @param navId     大分类
 *  @param label     标签
 *  @param sort      排序
 *  @param rows      条数
 *  @param page      页数
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestGetGroupListWithLongitude :(NSString *)longitude
                             andLatitude :(NSString *)latitude
                            andRegionId :(NSString *)regionId
                                 andNavId: (NSString *)navId
                                andLabel : (NSString *)label
                                 andSort :(NSString *)sort
                                 andRows :(NSString *)rows
                                 andPage :(NSString *)page
                               andSuccess: (void(^)(id success))success
                               andFailure:(void(^)(id error))failure;

/**
 *  丽人查询列表
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param regionId  地域
 *  @param label     分类
 *  @param sort      排序
 *  @param screen    筛选
 *  @param rows      条数
 *  @param page      页数
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestGetModellingListWithLongitude :(NSString *)longitude
                                    andLatitude :(NSString *)latitude
                                 andRegionId :(NSString *)regionId
                                    andLabel : (NSString *)label
                                     andSort :(NSString *)sort
                                   andScreen :(NSString *)screen
                                     andRows :(NSString *)rows
                                     andPage :(NSString *)page
                                    andSuccess: (void(^)(id success))success
                                    andFailure:(void(^)(id error))failure;


/**
 *  添加我的收藏 - 团购
 *
 *  @param businessId 店铺Id
 *  @param groupId    团购Id
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)requestCollectionAddGroupCollectionWithBusinessId:(NSString *) businessId
                                              andGroupId :(NSString *)groupId
                                               andSuccess: (void(^)(id success))success
                                               andFailure:(void(^)(id error))failure;
/**
 *  添加我的收藏- 店铺
 *
 *  @param businessId 店铺id
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)requestCollectionAddBusinessCollectionWithBusinessId:(NSString *) businessId
                                                  andSuccess: (void(^)(id success))success
                                                  andFailure:(void(^)(id error))failure;

/**
 * 店铺内部图片
 * @param businessId 店铺ID
 * @param callBack   成功
 * @param failure    失败
 */
+ (void)requestGetBusinessPhotosWithBusinessId:(NSString *)businessId
                                      CallBack:(void(^)(NSMutableArray * success))callBack
                                       Failure:(void(^)(id error))failure;


//午餐

/**
 *  获取午餐信息
 *
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)requestGetLunchInfoAndSuccess: (void(^)(id success))success
                           andFailure:(void(^)(id error))failure;




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
                                   CallBack:(ZRAddLunchOrderCallback)callback;

/**
 *  筛选评论
 *
 *  @param businessId 店铺id
 *  @param screen     筛选条件 1好评 2差评 3带图
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)requestBusinessCommentListWithBusinessId : (NSString *)businessId
                                      withScreen :(NSString *)screen
                                   andCommentType:(NSString *)commentType
                                       andSuccess: (void(^)(id success))success
                                       andFailure:(void(^)(id error))failure;

/**
 *  点 好评 接口
 *
 *  @param commentId 评论id
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestAgreeWithCommentId :(NSString *)commentId
                        andSuccess: (void(^)(id success))success
                        andFailure:(void(^)(id error))failure;

/**
 *  点 差评 接口
 *
 *  @param commentId 评论id
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestNoAgreeWithCommentId :(NSString *)commentId
                          andSuccess: (void(^)(id success))success
                          andFailure:(void(^)(id error))failure;
/**
 *  取消 好评或差评
 *
 *  @param commentId 评论id
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)requestDeleteAgreeWithCommentId :(NSString *)commentId
                              andSuccess: (void(^)(id success))success
                              andFailure:(void(^)(id error))failure;





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
                                           Callback:(ZRBusinessCommentCallback)callback;


/**
 *  丽人列表
 *
 *  @param longitude <#longitude description#>
 *  @param latitude  <#latitude description#>
 *  @param regionId  <#regionId description#>
 *  @param city      <#city description#>
 *  @param label     <#label description#>
 *  @param sort      <#sort description#>
 *  @param screen    <#screen description#>
 *  @param rows      <#rows description#>
 *  @param page      <#page description#>
 *  @param success   <#success description#>
 *  @param failure   <#failure description#>
 */
+ (void)requestGetLiRenListWithLongitude :(NSString *)longitude
                             andLatitude :(NSString *)latitude
                             andRegionId :(NSString *)regionId
                                 andCity :(NSString *)city
                                andLabel : (NSString *)label
                                 andSort :(NSString *)sort
                               andScreen :(NSString *)screen
                                 andRows :(NSString *)rows
                                 andPage :(NSString *)page
                               andSuccess: (void(^)(id success))success
                               andFailure:(void(^)(id error))failure;

+ (void)requestGetYuLeListWithLongitude :(NSString *)longitude
                             andLatitude :(NSString *)latitude
                             andRegionId :(NSString *)regionId
                                 andCity :(NSString *)city
                                andLabel : (NSString *)label
                                 andSort :(NSString *)sort
                               andScreen :(NSString *)screen
                                 andRows :(NSString *)rows
                                 andPage :(NSString *)page
                               andSuccess: (void(^)(id success))success
                              andFailure:(void(^)(id error))failure;

+ (void)requestGetLiRenIndexWithLongitude :(NSString *)longitude
                              andLatitude :(NSString *)latitude
                                 andLabel :(NSString *)label
                                andSuccess: (void(^)(id success))success
                                andFailure:(void(^)(id error))failure;

+ (void)requestGetYuleIndexWithLongitude :(NSString *)longitude
                             andLatitude :(NSString *)latitude
                                andLabel :(NSString *)label
                               andSuccess: (void(^)(id success))success
                               andFailure:(void(^)(id error))failure;
@end

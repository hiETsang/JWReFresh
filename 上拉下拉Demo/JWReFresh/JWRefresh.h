//
//  JWRefresh.h
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyHeaderView.h"
#import "MyFooterView.h"

@interface JWRefresh : NSObject

/**
 *  初始化方法
 */
+ (instancetype)jwRefresh;


/**
 *  下拉刷新  加载数据在bloack中实现
 */
+ (void)addHeaderWithTableView:(UITableView *)tableView andBlock:(void(^)(MyHeaderView *headerView,MyHeaderViewStatus status))beginRefreashData;


/**
 *  上拉加载更多
 */
+ (void)addFooterWithTableView:(UITableView *)tableView andBlock:(void (^)(MyFooterView *footerView, MyFooterViewStatus status))beginLoadData;

/**
 *  加载结束调用此方法
 */
+ (void)downLoadEnd;


/**
 *  设置下拉刷新的三种状态的提示
 */
+ (void)headerViewWithTitle:(NSString *)beginTitle dragTitle:(NSString *)dragTitle loadingTitle:(NSString *)loadTitle;

/**
 *  设置上拉加载更多的三种状态的提示
 */
+ (void)footerViewWithTitle:(NSString *)beginTitle dragTitle:(NSString *)dragTitle loadingTitle:(NSString *)loadTitle;

@end

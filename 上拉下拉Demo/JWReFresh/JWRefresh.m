//
//  JWRefresh.m
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "JWRefresh.h"


@interface JWRefresh ()

@property(nonatomic,strong)MyFooterView *footerView;

@property (nonatomic , strong) MyHeaderView *headerView;

@end

@implementation JWRefresh

+ (instancetype)jwRefresh
{
    static JWRefresh *jwRefresh;
    if(!jwRefresh)
    {
        jwRefresh = [[JWRefresh alloc] init];
    }
    return jwRefresh;
}

-(MyFooterView *)footerView
{
    if(_footerView == nil)
    {
        MyFooterView * footer = [MyFooterView footerView];
        _footerView = footer;
    }
    return _footerView;
}

-(MyHeaderView *)headerView
{
    if(_headerView == nil)
    {
        MyHeaderView * header = [MyHeaderView headerView];
        _headerView = header;
    }
    return _headerView;
}

+ (void)downLoadEnd
{
    JWRefresh *refresh = [JWRefresh jwRefresh];
    [refresh.footerView stopAnimation];
    [refresh.headerView stopAnimation];
}

+ (void)addHeaderWithTableView:(UITableView *)tableView andBlock:(void (^)(MyHeaderView *, MyHeaderViewStatus))beginRefreashData
{
    JWRefresh *refresh = [JWRefresh jwRefresh];
    refresh.headerView.beginRefreashData = beginRefreashData;
    [tableView addSubview:refresh.headerView];
}

+ (void)addFooterWithTableView:(UITableView *)tableView andBlock:(void (^)(MyFooterView *footerView, MyFooterViewStatus status))beginLoadData
{
    JWRefresh *refresh = [JWRefresh jwRefresh];
    refresh.footerView.beginLoadData = beginLoadData;
    [tableView addSubview:refresh.footerView];
}

+ (void)footerViewWithTitle:(NSString *)beginTitle dragTitle:(NSString *)dragTitle loadingTitle:(NSString *)loadTitle
{
    JWRefresh *refresh = [JWRefresh jwRefresh];
    [refresh.footerView titleWithString:beginTitle status:MyFooterViewStatusBeginDrag];
    [refresh.footerView titleWithString:dragTitle status:MyFooterViewStatusDraging];
    [refresh.footerView titleWithString:loadTitle status:MyFooterViewStatusEndDrag];
}

+ (void)headerViewWithTitle:(NSString *)beginTitle dragTitle:(NSString *)dragTitle loadingTitle:(NSString *)loadTitle
{
    JWRefresh *refresh = [JWRefresh jwRefresh];
    [refresh.headerView headerTitleWithString:beginTitle status:MyHeaderViewStatusBeginDrag];
    [refresh.headerView headerTitleWithString:dragTitle status:MyHeaderViewStatusDraging];
    [refresh.headerView headerTitleWithString:loadTitle status:MyHeaderViewStatusEndDrag];
}


@end

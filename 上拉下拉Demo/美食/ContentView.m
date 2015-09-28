//
//  ContentView.m
//  美食
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//
/**
 *  目标:像第三方库一样   只需要添加子视图  就能正确的显示并且关联  复杂逻辑自己内部实现
 *
 *  思路:将scrollView的代理方法迁移到myfooterVIew当中   在myFooterView内部实现相同的逻辑
 *
 *  步骤:在子视图中添加一个tableView的属性  通过监听属性的值的变化来实现
 */

//0.将代码规范  主视图只调用[self.tableView addSubview:_footerView];  
//1.模拟网络下载
//2.网络下载的时候不允许刷新
//3.加载完成后需重新设置状态
//4.给外界修改字的接口

#import "ContentView.h"
#import "MyCell.h"
#import "JWRefresh.h"

@interface ContentView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ContentView

//从xib加载后会调用此方法
-(void)awakeFromNib
{
    [JWRefresh addHeaderWithTableView:self.tableView andBlock:^(MyHeaderView *footerView, MyHeaderViewStatus status) {
        [self performSelector:@selector(downLoadEnd) withObject:nil afterDelay:4.0];
    }];
    
    [JWRefresh addFooterWithTableView:self.tableView andBlock:^(MyFooterView *footerView, MyFooterViewStatus status) {
        [self performSelector:@selector(downLoadEnd) withObject:nil afterDelay:4.0];
    }];

    //下载数据
}

-(void)downLoadEnd
{
    NSLog(@"下载完成");
    [JWRefresh downLoadEnd];
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

+ (id)contentView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ContentView" owner:nil options:nil] lastObject];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [MyCell cellWithTableView:tableView];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end

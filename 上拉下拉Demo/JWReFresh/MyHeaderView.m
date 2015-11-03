//
//  MyHeaderView.m
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView ()

@property(nonatomic , strong)UIScrollView *scrollView;

@property(nonatomic,weak)UIButton *button;

@property(nonatomic,weak)UIView *loadingView;

@end

@implementation MyHeaderView
/**
 *  三种状态下的文字
 */
{
    NSString *_beginDrag;
    NSString *_draging;
    NSString *_endDrag;
}

+(id)headerView
{
    return [[self alloc]init];
}


#pragma mark - 下拉加载更多视图上控件的懒加载
-(UIView *)loadingView
{
    if(_loadingView == nil)
    {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        _loadingView = view;
        [self addSubview:_loadingView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.text = _endDrag;
        [view addSubview:label];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.frame = CGRectMake(100, 10, 40, 40);
        [view addSubview:activity];
        
        [activity startAnimating];
    }
    return _loadingView;
}

- (UIButton *)button
{
    if(_button == nil)
    {
        UIButton *alertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _button = alertButton;
        [self addSubview:_button];
        
        alertButton.frame = self.bounds;
        
        [alertButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _button;
}

/**
 *  文字的接口设置
 */
- (void)headerTitleWithString:(NSString *)title status:(MyHeaderViewStatus)status
{
    switch (status) {
        case MyHeaderViewStatusBeginDrag:
            _beginDrag = title?title:@"下拉刷新";
            break;
        case MyHeaderViewStatusDraging:
            _draging = title?title:@"松开即可刷新";
            break;
        case MyHeaderViewStatusEndDrag:
            _endDrag = title?title:@"正在刷新中";
            break;
        default:
            break;
    }
}

#pragma mark - 视图加载
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView *tableView = (UITableView *)newSuperview;
    CGFloat selfX = tableView.frame.origin.x;
    CGFloat selfY = tableView.frame.origin.y - 60;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.status = MyHeaderViewStatusBeginDrag;
}

-(void)didMoveToSuperview
{
    self.scrollView = (UITableView *)self.superview;
    [self headerTitleWithString:nil status:MyHeaderViewStatusBeginDrag];
    [self headerTitleWithString:nil status:MyHeaderViewStatusDraging];
    [self headerTitleWithString:nil status:MyHeaderViewStatusEndDrag];
}


#pragma mark - 状态设置
-(void)setStatus:(MyHeaderViewStatus)status
{
    _status = status;
    
    switch (status) {
        case MyHeaderViewStatusBeginDrag:
            [self.button setTitle:[NSString stringWithFormat:@"   %@",_beginDrag] forState:UIControlStateNormal];
            [self.button setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            //开始下拉
            break;
        case MyHeaderViewStatusDraging:
            [self.button setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
            [self.button setTitle:[NSString stringWithFormat:@"   %@",_draging] forState:UIControlStateNormal];
            //松开下拉
            break;
        case MyHeaderViewStatusEndDrag:
            self.button.hidden = YES;
            self.loadingView.hidden = NO;
            //正在刷新
            break;
        default:
            break;
    }
}

-(void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.status == MyHeaderViewStatusEndDrag) return;
    
    CGFloat y = self.scrollView.contentOffset.y;
    
    if(self.scrollView.isDragging)  //如果在拖拽
    {
        if(y < 0 && y >= - self.frame.size.height)
        {
            self.status = MyHeaderViewStatusBeginDrag;
        }
        else if (y < - self.frame.size.height)
        {
            self.status = MyHeaderViewStatusDraging;
        }
    }
    else                            //松开
    {
        if(self.status == MyHeaderViewStatusDraging)
        {
            self.status = MyHeaderViewStatusEndDrag;
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
            } completion:^(BOOL finished) {
                if(self.beginRefreashData)
                {
                    self.beginRefreashData(self,MyHeaderViewStatusEndDrag);
                }
            }];
        }
    }
}


#pragma mark - 停止加载
- (void)stopAnimation
{
    self.status = MyHeaderViewStatusBeginDrag;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self clear];
    }];
}

-(void)clear
{
    [self.button removeFromSuperview];
    [self.loadingView removeFromSuperview];
}

@end

//
//  MyFooterView.m
//  美食
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "MyFooterView.h"

@interface MyFooterView()

@property(nonatomic , strong)UIScrollView *scrollView;

@property(nonatomic,weak)UIButton *button;

@property(nonatomic,weak)UIView *loadingView;

@end

@implementation MyFooterView
/**
 *  三种状态下的文字
 */
{
    NSString *_beginDrag;
    NSString *_draging;
    NSString *_endDrag;
}

+ (id)footerView
{
    return [[self alloc] init];
}


#pragma mark - 上拉加载更多视图上控件的懒加载
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


#pragma mark - 监听tableView的偏移量
-(void)setScrollView:(UIScrollView *)scrollView
{
    /**
     *  注意:在添加监听方法的时候需要删除上一个监听方法
     */
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView = scrollView;
    //添加监听方法
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  实现监听
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //防止正在刷新的时候再次刷新
    if(self.status == MyFooterViewStatusEndDrag) return;
    
    /**
     *  实现判断逻辑
     */
    [self willMoveToSuperview:_scrollView];
    
    if(_scrollView.isDragging) //如果正在拖拽
    {
        //偏移量
        CGFloat Y = _scrollView.contentSize.height - _scrollView.frame.size.height;
        
        if(_scrollView.contentOffset.y > Y && _scrollView.contentOffset.y <= Y + self.frame.size.height)
        {
            self.status = MyFooterViewStatusBeginDrag;
        }
        else if(_scrollView.contentOffset.y >= Y + self.frame.size.height && self.status != MyFooterViewStatusDraging)
        {
            self.status = MyFooterViewStatusDraging;
        }
    }
    else   //如果没有拖拽
    {
        if(self.status == MyFooterViewStatusDraging)  //如果正在拖拽
        {
            self.status = MyFooterViewStatusEndDrag;
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
            } completion:^(BOOL finished) {
                if(self.beginLoadData)
                {
                    self.beginLoadData(self,MyFooterViewStatusEndDrag);
                }
            }];
            
        }
    }
}


#pragma mark - 视图位置
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    
    UITableView *tableView = (UITableView *)newSuperview;
    CGFloat selfX = 0;
    CGFloat selfY = tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
}

-(void)didMoveToSuperview
{
    self.scrollView = (UITableView *)self.superview;
    [self titleWithString:nil status:MyFooterViewStatusBeginDrag];
    [self titleWithString:nil status:MyFooterViewStatusDraging];
    [self titleWithString:nil status:MyFooterViewStatusEndDrag];
}

/**
 *  设置不同状态对应的View
 */
-(void)setStatus:(MyFooterViewStatus)status
{
    _status = status;
    
    switch (status) {
        case MyFooterViewStatusBeginDrag:
            [self.button setTitle:[NSString stringWithFormat:@"   %@",_beginDrag] forState:UIControlStateNormal];
            [self.button setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
            break;
        case MyFooterViewStatusDraging:
            [self.button setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            [self.button setTitle:[NSString stringWithFormat:@"   %@",_draging] forState:UIControlStateNormal];
            break;
        case MyFooterViewStatusEndDrag:
            self.button.hidden = YES;
            self.loadingView.hidden = NO;
            break;
        default:
            break;
    }
}

/**
 *  文字的接口设置
 */
- (void)titleWithString:(NSString *)title status:(MyFooterViewStatus)status
{
    switch (status) {
        case MyFooterViewStatusBeginDrag:
            _beginDrag = title?title:@"上拉加载更多";
            break;
        case MyFooterViewStatusDraging:
            _draging = title?title:@"松开加载更多";
            break;
        case MyFooterViewStatusEndDrag:
            _endDrag = title?title:@"正在加载";
            break;
        default:
            break;
    }
}

#pragma mark - 收起footerView
-(void)stopAnimation
{
    self.status = MyFooterViewStatusBeginDrag;
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

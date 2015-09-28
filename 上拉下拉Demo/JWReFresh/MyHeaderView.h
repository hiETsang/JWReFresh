//
//  MyHeaderView.h
//  美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeaderView : UIView

typedef NS_ENUM(NSUInteger, MyHeaderViewStatus) {
    MyHeaderViewStatusBeginDrag,
    MyHeaderViewStatusDraging,
    MyHeaderViewStatusEndDrag,
};

@property(nonatomic,copy) void(^beginRefreashData)(MyHeaderView *footerView,MyHeaderViewStatus status);

- (void)setBeginRefreashData:(void (^)(MyHeaderView *footerView, MyHeaderViewStatus status))beginRefreashData;

@property(nonatomic , assign) MyHeaderViewStatus status;

+ (id)headerView;

- (void)stopAnimation;

- (void)headerTitleWithString:(NSString *)title status:(MyHeaderViewStatus)status;

@end

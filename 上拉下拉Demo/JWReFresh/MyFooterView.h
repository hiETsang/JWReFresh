//
//  MyFooterView.h
//  美食
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MyFooterViewStatus) {
    MyFooterViewStatusBeginDrag,
    MyFooterViewStatusDraging,
    MyFooterViewStatusEndDrag,
};

@interface MyFooterView : UIView

@property(nonatomic,assign) MyFooterViewStatus status;

//当处于正在加载状态时开始网络请求
@property(nonatomic,copy) void(^beginLoadData)(MyFooterView *footerView,MyFooterViewStatus status);

+ (id)footerView;

- (void)stopAnimation;

- (void)titleWithString:(NSString *)title status:(MyFooterViewStatus)status;

-(void)setBeginLoadData:(void (^)(MyFooterView *footerView, MyFooterViewStatus status))beginLoadData;

@end

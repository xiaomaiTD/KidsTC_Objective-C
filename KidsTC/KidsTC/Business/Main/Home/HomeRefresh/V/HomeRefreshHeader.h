//
//  HomeRefreshHeader.h
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RefreshHeader.h"

@interface HomeRefreshHeader : RefreshHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end

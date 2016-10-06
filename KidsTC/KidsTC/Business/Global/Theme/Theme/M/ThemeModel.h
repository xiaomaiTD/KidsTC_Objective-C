//
//  ThemeModel.h
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "Model.h"

@interface DownloadedTabBarItemElementModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleColorNor;
@property (nonatomic, copy) NSString *titleColorSel;
@property (nonatomic, copy) NSString *imgNorName;
@property (nonatomic, copy) NSString *imgSelName;
@end

@interface ThemeDownloadedConfigModel : NSObject
@property (nonatomic, strong) NSString *version;//主题的版本号
@property (nonatomic, assign) NSTimeInterval startTime;//主题开始时间
@property (nonatomic, assign) NSTimeInterval expireTime;//主题终止时间
@property (nonatomic, strong) NSString *topColor;//导航栏背景色
@property (nonatomic, strong) NSString *bgColor;//tabBar的背景色
@property (nonatomic, strong) DownloadedTabBarItemElementModel *home;
@property (nonatomic, strong) DownloadedTabBarItemElementModel *news;
@property (nonatomic, strong) DownloadedTabBarItemElementModel *strategy;
@property (nonatomic, strong) DownloadedTabBarItemElementModel *me;
@end

//======================================================================

@interface ThemeData : Model
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *downLink;
@end

@interface ThemeModel : Model
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ThemeData *data;
@end

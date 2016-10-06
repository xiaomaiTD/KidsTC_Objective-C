//
//  AppVersionModel.h
//  KidsTC
//
//  Created by zhanping on 8/19/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppVersionData : NSObject
@property (nonatomic, strong) NSString *appNewVersion;
@property (nonatomic, assign) BOOL isForceUpdate;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *downLink;
@property (nonatomic, strong) NSString *bgImgUrl;
@property (nonatomic, strong) NSString *btnImgUrl;
@property (nonatomic, assign) BOOL isUpdate;
/*selfDefin*/
@property (nonatomic, strong) UIImage *bgImg;
@property (nonatomic, strong) UIImage *btnImg;
@end

@interface AppVersionModel : NSObject
@property (nonatomic, assign) NSInteger Code;
@property (nonatomic, strong) AppVersionData *data;
@end

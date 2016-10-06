//
//  HomeRefreshModel.h
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "Model.h"

@interface HomeRefreshData : Model
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval endTime;
@property (nonatomic, strong) NSString *pageUrl;
@end

@interface HomeRefreshModel : Model
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) HomeRefreshData *data;
@end

//
//  HomeActivityModel.h
//  KidsTC
//
//  Created by zhanping on 8/9/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "Model.h"

@interface HomeActivityDataItem : Model

@property (nonatomic, assign) long ID;
@property (nonatomic, strong) NSString *tit;
@property (nonatomic, strong) NSString *thumbImg;
@property (nonatomic, strong) NSString *pageUrl;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval endTime;

@property (nonatomic, assign) BOOL webPageCanShow;
@property (nonatomic, assign) BOOL imageCanShow;
@end

@interface HomeActivityModel : Model
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) HomeActivityDataItem *data;
@end

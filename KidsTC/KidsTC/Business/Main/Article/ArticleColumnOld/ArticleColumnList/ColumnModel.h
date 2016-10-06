//
//  ColumnModel.h
//  KidsTC
//
//  Created by zhanping on 4/14/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDataItem : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *tit;
@property (nonatomic, strong) NSString *subTit;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) NSString *imgUrl;
@end

@interface ColumnResponse : NSObject
@property (nonatomic, strong) NSArray   *data;
@property (nonatomic, strong) NSString  *page;
@end
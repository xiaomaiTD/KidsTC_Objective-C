//
//  AreaAndAgeModel.h
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "Model.h"

@interface AreaAndAgeListItem : Model
@property (nonatomic, strong) NSString *Value;
@property (nonatomic, strong) NSString *Name;
+(instancetype)itemWithName:(NSString *)name value:(NSString *)value;
@end

@interface AreaAndAgeData : Model
@property (nonatomic, strong) NSArray<AreaAndAgeListItem *> *Addr;
@property (nonatomic, strong) NSArray<AreaAndAgeListItem *> *Age;
@end

@interface AreaAndAgeModel : Model
@property (nonatomic, strong) AreaAndAgeData *data;
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSString *md5;
@end

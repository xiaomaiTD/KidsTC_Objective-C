//
//  AddressModel.h
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "Model.h"

@interface AddressDataItem : Model
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) BOOL hasNextLevelAddress;
@property (nonatomic, strong) NSArray<AddressDataItem *> *subAddress;

@property (nonatomic, assign) BOOL selected;
+ (instancetype)itemWithID:(NSString *)ID address:(NSString *)address level:(NSInteger)level hasNext:(BOOL)hasNext;
@end

@interface AddressModel : Model
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSString *md5;
@property (nonatomic, strong) NSArray<AddressDataItem *> *data;
@end

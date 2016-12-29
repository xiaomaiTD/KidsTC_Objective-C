//
//  SettlementPickStoreModel.h
//  KidsTC
//
//  Created by zhanping on 8/12/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettlementPickStoreDataItem : NSObject
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) NSUInteger hotCount;
@property (nonatomic, assign) NSUInteger attentNum;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *officeHoursDesc;

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSAttributedString *storeDesc;
@property (nonatomic, strong) NSAttributedString *pickStoreDesc;
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic;
@end

@interface SettlementPickStoreModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<SettlementPickStoreDataItem *> *data;
@end

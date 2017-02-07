//
//  InterfaceModel.h
//  KidsTC
//
//  Created by 詹平 on 16/7/10.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "Model.h"

typedef enum : NSUInteger {
    RequestTypeGet = 1, //get
    RequestTypePost     //post
} RequestType;

@interface InterfaceItem : Model
@property (nonatomic, assign) RequestType method;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *name;//请求名称
@property (nonatomic, assign) NSTimeInterval start;
@property (nonatomic, assign) NSTimeInterval end;
@end

@interface InterfaceModel : Model
@property (nonatomic, strong) NSString *version;
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSDictionary *data;
- (InterfaceItem *)interfaceItemWithName:(NSString *)name;
@end

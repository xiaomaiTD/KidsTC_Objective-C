//
//  InterfaceModel.m
//  KidsTC
//
//  Created by 詹平 on 16/7/10.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "InterfaceModel.h"
#import "Macro.h"
#import "NSString+Category.h"

@implementation InterfaceItem
+ (instancetype)itemWithDic:(NSDictionary *)dic name:(NSString *)name{
    return [[self alloc]initWithDic:dic name:name];
}
- (instancetype)initWithDic:(NSDictionary *)dic name:(NSString *)name{
    self = [super init];
    if (self) {
        
        if (!dic || ![dic isKindOfClass:[NSDictionary class]] || dic.count<1) {
            TCLog(@"无效的接口列表");
            return nil;
        }
        
        if (![name isNotNull]) {
            TCLog(@"请求名称为空");
            return nil;
        }else{
            self.name = name;
        }
        
        NSDictionary *itemDic = dic[name];
        
        if (!itemDic || ![itemDic isKindOfClass:[NSDictionary class]] || itemDic.count<1) {
            TCLog(@"无效的接口字典-请求名称:%@",name);
            return nil;
        }
        
        NSString *method = itemDic[@"method"];
        if ([method isEqualToString:@"get"]) {
            self.method = RequestTypeGet;
        }else if ([method isEqualToString:@"post"]) {
            self.method = RequestTypePost;
        }else{
            TCLog(@"无效的请求方式-请求名称:%@",name);
            return nil;
        }
        
        NSString *url = itemDic[@"url"];
        if (![url isNotNull]) {
            TCLog(@"无效的请求路径-请求名称:%@",name);
            return nil;
        }else{
            self.url = url;
        }
        
    }
    return self;
}

- (NSString *)description{
    
    NSString *method = @"";
    if (self.method == RequestTypeGet) {
        method = @"get";
    }else if (self.method == RequestTypePost){
        method = @"post";
    }else{
        return @"无效的接口描述信息";
    }
    return [NSString stringWithFormat:@"\n=============接口信息:=============\n请求方式:%@\n请求名称:%@\n请求路径:%@\n==================================",method,self.name,self.url];
}
@end

@implementation InterfaceModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
- (InterfaceItem *)interfaceItemWithName:(NSString *)name{
    return [InterfaceItem itemWithDic:self.data name:name];
}
@end

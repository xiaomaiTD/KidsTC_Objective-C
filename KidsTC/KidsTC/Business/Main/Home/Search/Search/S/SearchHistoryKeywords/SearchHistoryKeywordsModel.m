//
//  SearchHistoryKeywordsModel.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchHistoryKeywordsModel.h"

@implementation SearchHistoryKeywordsModel

-(NSMutableArray<NSString *> *)article{
    if (!_article) {
        _article = [NSMutableArray<NSString *> array];
    }
    return _article;
}
-(NSMutableArray<NSString *> *)product{
    if (!_product) {
        _product = [NSMutableArray<NSString *> array];
    }
    return _product;
}
-(NSMutableArray<NSString *> *)store{
    if (!_store) {
        _store = [NSMutableArray<NSString *> array];
    }
    return _store;
}

// 解码
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.article=[aDecoder decodeObjectForKey:@"article"];
        self.product=[aDecoder decodeObjectForKey:@"product"];
        self.store=[aDecoder decodeObjectForKey:@"store"];
    }
    return  self;
}
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.article forKey:@"article"];
    [aCoder encodeObject:self.product forKey:@"product"];
    [aCoder encodeObject:self.store forKey:@"store"];
}

@end

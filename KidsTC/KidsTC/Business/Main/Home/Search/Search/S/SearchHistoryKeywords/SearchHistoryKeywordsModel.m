//
//  SearchHistoryKeywordsModel.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchHistoryKeywordsModel.h"

@implementation SearchHistoryKeywordsModel
-(NSMutableArray<SearchHotKeywordsItem *> *)store{
    if (!_history) {
        _history = [NSMutableArray<SearchHotKeywordsItem *> array];
    }
    return _history;
}

// 解码
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.history=[aDecoder decodeObjectForKey:@"history"];
    }
    return  self;
}
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.store forKey:@"history"];
}

@end

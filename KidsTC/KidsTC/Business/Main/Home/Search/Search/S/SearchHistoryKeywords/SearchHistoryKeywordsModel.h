//
//  SearchHistoryKeywordsModel.h
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    SearchType_Product=1,
    SearchType_Store,
    SearchType_Article
} SearchType;
@interface SearchHistoryKeywordsModel : NSObject<NSCoding>
@property (nonatomic, strong) NSMutableArray<NSString *> *article;
@property (nonatomic, strong) NSMutableArray<NSString *> *product;
@property (nonatomic, strong) NSMutableArray<NSString *> *store;
@end

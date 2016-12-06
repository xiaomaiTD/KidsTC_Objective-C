//
//  HotKeywordsModel.h
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "Model.h"
#import "SearchHotKeywordsData.h"

@interface SearchHotKeywordsModel : Model
@property (nonatomic, strong) SearchHotKeywordsData *data;
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSString *md5;
@end

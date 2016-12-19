//
//  BrowseHistoryServiceListItemModel.h
//  KidsTC
//
//  Created by Altair on 12/3/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrowseHistoryServiceListItemModel : NSObject

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) NSString *channelId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSURL *imageUrl;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *priceStr;

@property (nonatomic, assign) ProductDetailType productRedirect;

- (instancetype)initWithRawData:(NSDictionary *)data;

@end

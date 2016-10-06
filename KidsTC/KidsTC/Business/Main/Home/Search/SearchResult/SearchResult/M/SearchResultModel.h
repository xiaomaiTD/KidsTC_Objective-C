//
//  SearchResultModel.h
//  KidsTC
//
//  Created by zhanping on 7/5/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    ProductStatusReadyForSale = 1,
    ProductStatusHasSoldOut = 2,
    ProductStatusNoStore = 3,
    ProductStatusNotBegin = 4,
    ProductStatusHasTakenOff = 5
}ProductStatus;

@interface SearchResultProductItem : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) ProductStatus status;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) NSUInteger sale;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSArray<NSString *> *fullCut;
@property (nonatomic, assign) BOOL isHaveCoupon;
@property (nonatomic, assign) BOOL isGqt;
@property (nonatomic, assign) BOOL isSst;
@property (nonatomic, assign) BOOL isBft;

@property (nonatomic, strong) NSAttributedString *tipStr;
@property (nonatomic, strong) NSAttributedString *firstFullCutStr;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@interface SearchResultProductModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<SearchResultProductItem *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end

/**
 *  =========================================================
 */

@interface SearchResultStoreItemEvent : NSObject
@property (nonatomic, assign) BOOL gift;
@property (nonatomic, assign) BOOL tuan;
@end

@interface SearchResultStoreItem : NSObject
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) SearchResultStoreItemEvent *event;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSArray<NSString *> *storeGift;
@property (nonatomic, strong) NSArray<NSString *> *storeDiscount;
@property (nonatomic, assign) NSUInteger commentCount;
@property (nonatomic, strong) NSString *feature;
@property (nonatomic, strong) NSString *businessZone;
@property (nonatomic, strong) NSArray<NSString *> *fullCut;
@property (nonatomic, assign) BOOL isHaveCoupon;

@property (nonatomic, strong) NSAttributedString *commentCountStr;
@property (nonatomic, strong) NSAttributedString *firstStoreGiftStr;
@property (nonatomic, strong) NSAttributedString *firstFullCutStr;
@property (nonatomic, strong) NSAttributedString *firstStoreDiscountStr;
@property (nonatomic, assign, getter=isHaveActivity) BOOL haveActivity;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@interface SearchResultStoreModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<SearchResultStoreItem *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end

/**
 *  =========================================================
 */

@interface SearchResultArticleItem : NSObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, assign) NSUInteger commentCount;
@property (nonatomic, assign) NSUInteger viewCount;
@property (nonatomic, assign) NSInteger articleKind;
@property (nonatomic, strong) NSString *linkUrl;

//@property (nonatomic, assign) CGFloat cellHeight;
@end

@interface SearchResultArticleModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<SearchResultArticleItem *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end




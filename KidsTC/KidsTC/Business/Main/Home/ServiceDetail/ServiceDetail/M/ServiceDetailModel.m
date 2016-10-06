//
//  ServiceDetailModel.m
//  KidsTC
//
//  Created by 钱烨 on 8/8/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "ServiceDetailModel.h"
#import "ToolBox.h"

@interface ServiceDetailModel ()

@property (nonatomic, assign) CGFloat noticeHeight;

@end

@implementation ServiceDetailModel

- (BOOL)fillWithRawData:(NSDictionary *)data {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    self.serviceId = data[@"serveId"];
    
    NSArray *product_standards = [data objectForKey:@"product_standards"];
    NSMutableArray *product_standardsTempArray = [[NSMutableArray alloc] init];
    self.currentProductStandardsItem = nil;
    self.currentProductStandardsItemIndex = 0;
    if ([product_standards isKindOfClass:[NSArray class]]) {
        
        for (int i = 0; i<product_standards.count; i++) {
            NSDictionary *rawData = product_standards[i];
            ProductStandardsItem *model = [[ProductStandardsItem alloc] initWithRawData:rawData];
            if (model) {
                [product_standardsTempArray addObject:model];
            }
            if ([[NSString stringWithFormat:@"%ld",model.productId] isEqualToString:self.serviceId]) {
                self.currentProductStandardsItem = model;
                self.currentProductStandardsItemIndex = i;
            }
        }
    }
    self.product_standards = [NSArray arrayWithArray:product_standardsTempArray];
    
    self.channelId = [NSString stringWithFormat:@"%@", [data objectForKey:@"chId"]];
    self.type = [[data objectForKey:@"productType"] integerValue];
    
    NSArray *imageUrlStrings = [data objectForKey:@"imgUrl"];
    NSMutableArray *imageUrlsTempArray = [[NSMutableArray alloc] init];
    if ([imageUrlStrings isKindOfClass:[NSArray class]]) {
        for (NSString *urlString in imageUrlStrings) {
            NSURL *url = [NSURL URLWithString:urlString];
            if (url) {
                [imageUrlsTempArray addObject:url];
            }
        }
    }
    self.imageUrls = [NSArray arrayWithArray:imageUrlsTempArray];
    
    
    NSArray *narrowimageUrlStrings = [data objectForKey:@"narrowImg"];
    NSMutableArray *narrowImageUrlsTempArray = [[NSMutableArray alloc] init];
    if ([narrowimageUrlStrings isKindOfClass:[NSArray class]]) {
        for (NSString *urlString in narrowimageUrlStrings) {
            NSURL *url = [NSURL URLWithString:urlString];
            if (url) {
                [narrowImageUrlsTempArray addObject:url];
            }
        }
    }
    self.narrowImageUrls = [NSArray arrayWithArray:narrowImageUrlsTempArray];
    
    self.imageRatio = [[data objectForKey:@"picRate"] floatValue];
    self.relationType = (CommentRelationType)[[data objectForKey:@"productType"] integerValue];
    
    self.serviceName = [data objectForKey:@"serveName"];
    self.serviceBriefName = [data objectForKey:@"simpleName"];
    self.serviceBriefName = nil;
    if (![self.serviceBriefName isKindOfClass:[NSString class]] || [self.serviceBriefName length] == 0) {
        self.serviceBriefName = @"服务详情";
    }
    self.starNumber = [[data objectForKey:@"level"] floatValue];
    self.commentsNumber = [[data objectForKey:@"evaluate"] integerValue];
    self.saleCount = [[data objectForKey:@"saleCount"] integerValue];
    self.currentPrice = [[data objectForKey:@"price"] floatValue];
    self.originalPrice = [[NSString stringWithFormat:@"%@",[data objectForKey:@"originalPrice"]] floatValue];
    self.priceDescription = [data objectForKey:@"priceSortName"];
    if ([self.priceDescription length] > 0) {
        self.priceDescription = [NSString stringWithFormat:@"%@: ", self.priceDescription];
    }
    self.serviceContent = [data objectForKey:@"content"];
    if (![self.serviceContent isKindOfClass:[NSString class]]) {
        self.serviceContent = @"";
    }
    NSArray *coupons = [data objectForKey:@"coupon_provide"];
    self.couponName = nil;
    self.couponProvideCount = 0;
    if ([coupons isKindOfClass:[NSArray class]] && [coupons count] > 0) {
        self.couponName = [[coupons firstObject] objectForKey:@"name"];
        self.couponProvideCount = [[[coupons firstObject] objectForKey:@"provideNum"] integerValue];
    }
    self.couponUrlString = [data objectForKey:@"couponLink"];
    //store relation-----------------------------------------------------------
    
    NSDictionary *relationDic = [data objectForKey:@"product_relation"];
    NSMutableArray *moreServiceItemsTempArray = [[NSMutableArray alloc] init];
    if ([relationDic isKindOfClass:[NSDictionary class]]) {
        //strategy
        NSArray *products = [relationDic objectForKey:@"relatedDiscountProductLs"];
        if ([products isKindOfClass:[NSArray class]]) {
            for (NSDictionary *strategyDic in products) {
                ServiceMoreDetailHotSalesItemModel *model = [[ServiceMoreDetailHotSalesItemModel alloc] initWithRawData:strategyDic];
                if (model) {
                    [moreServiceItemsTempArray addObject:model];
                }
            }
        }
    }
    self.moreServiceItems = [NSArray arrayWithArray:moreServiceItemsTempArray];
    //--------------------------------------------------------------------------
    
    //activity
    NSArray *fullCut = [data objectForKey:@"fullCut"];
    NSMutableArray *activeModelsTempArray = [[NSMutableArray alloc] init];
    if ([fullCut isKindOfClass:[NSArray class]] && [fullCut count] > 0) {
        for (NSString *fullCutTitle in fullCut) {
            if ([fullCutTitle isKindOfClass:[NSString class]]) {
                ActivityLogoItem *item = [[ActivityLogoItem alloc] initWithType:ActivityLogoItemTypeDiscount description:fullCutTitle];
                if (item) {
                    [activeModelsTempArray addObject:item];
                }
            }
        }
    }
    self.activeModelsArray = [NSArray arrayWithArray:activeModelsTempArray];
    
    self.countdownTime = [[data objectForKey:@"countDownTime"] integerValue];
    self.showCountdown = [[data objectForKey:@"showCountDown"] integerValue];
    self.supportedInsurances = [Insurance InsurancesWithRawData:[data objectForKey:@"insurance"]];
    
    NSArray *array = [data objectForKey:@"buyNotice"];
    self.noticeHeight = 10;
    NSMutableArray *noticeTempArray = [[NSMutableArray alloc] init];
    if ([array isKindOfClass:[NSArray class]]) {
        for (NSDictionary *singleEle in array) {
            ServiceDetailNoticeItem *item = [[ServiceDetailNoticeItem alloc] initWithRawData:singleEle];
            if (item) {
                [noticeTempArray addObject:item];
                self.noticeHeight += [item itemHeight];
            }
        }
    }
    self.noticeArray = [NSArray arrayWithArray:noticeTempArray];
    
    NSDictionary *recommendDic = [data objectForKey:@"note"];
    self.recommenderFaceImageUrl = nil;
    self.recommenderName = nil;
    self.recommendString = nil;
    if ([recommendDic isKindOfClass:[NSDictionary class]] && [recommendDic count] > 0) {
        self.recommenderFaceImageUrl = [NSURL URLWithString:[recommendDic objectForKey:@"imgUrl"]];
        self.recommenderName = [recommendDic objectForKey:@"name"];
        self.recommendString = [recommendDic objectForKey:@"note"];
    }
    
    self.serviceDescription = [data objectForKey:@"promote"];
    if (!self.serviceDescription) {
        self.serviceDescription = @"";
    }
    NSArray *promotionLinks = [data objectForKey:@"promotionLink"];
    NSMutableArray *promotionSegueModelsTempArray = [[NSMutableArray alloc] init];
    if ([promotionLinks isKindOfClass:[NSArray class]]) {
        for (NSDictionary *rawData in promotionLinks) {
            TextSegueModel *model = [[TextSegueModel alloc] initWithLinkParam:rawData promotionWords:self.serviceDescription];
            if (model) {
                [promotionSegueModelsTempArray addObject:model];
            }
        }
    }
    self.promotionSegueModels = [NSArray arrayWithArray:promotionSegueModelsTempArray];
    
    self.introductionUrlString = [data objectForKey:@"detailUrl"];
    
    self.isFavourate = [[data objectForKey:@"isFavor"] boolValue];
    
    self.stockNumber = [[data objectForKey:@"remainCount"] integerValue];
    self.maxLimit = [[data objectForKey:@"buyMaxNum"] integerValue];
    self.minLimit = [[data objectForKey:@"buyMinNum"] integerValue];
    if (self.stockNumber < self.maxLimit) {
        self.maxLimit = self.stockNumber;
    }
    
    NSArray *storesArray = [data objectForKey:@"store"];
    NSMutableArray *storeItemstempArray = [[NSMutableArray alloc] init];
    NSMutableArray *phoneItemstempArray = [[NSMutableArray alloc] init];
    if ([storesArray isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary *singleDic in storesArray) {
            StoreListItemModel *item = [[StoreListItemModel alloc] initWithRawData:singleDic];
            if (item) {
                [storeItemstempArray addObject:item];
                ServiceDetailPhoneItem *phoneItem = [[ServiceDetailPhoneItem alloc] initWithTitle:item.storeName andPhoneNumberString:item.phoneNumber];
                if (phoneItem) {
                    [phoneItemstempArray addObject:phoneItem];
                }
            }
            
        }
        
    }
    self.storeItemsArray = [NSArray arrayWithArray:storeItemstempArray];
    _phoneItems = [NSArray arrayWithArray:phoneItemstempArray];
    
    
    NSArray *commentsArray = [data objectForKey:@"commentList"];
    NSMutableArray *commentItemsTempArray = [[NSMutableArray alloc] init];
    if ([commentsArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *singleDic in commentsArray) {
            CommentListItemModel *item = [[CommentListItemModel alloc] initWithRawData:singleDic];
            [commentItemsTempArray addObject:item];
        }
    }
    self.commentItemsArray = [NSArray arrayWithArray:commentItemsTempArray];
    
    
    NSDictionary *commentDic = [data objectForKey:@"comment"];
    self.commentAllNumber = 0;
    self.commentGoodNumber = 0;
    self.commentNormalNumber = 0;
    self.commentBadNumber = 0;
    self.commentPictureNumber = 0;
    if ([commentDic isKindOfClass:[NSDictionary class]] && [commentDic count] > 0) {
        self.commentAllNumber = [[commentDic objectForKey:@"all"] integerValue];
        self.commentGoodNumber = [[commentDic objectForKey:@"good"] integerValue];
        self.commentNormalNumber = [[commentDic objectForKey:@"normal"] integerValue];
        self.commentBadNumber = [[commentDic objectForKey:@"bad"] integerValue];
        self.commentPictureNumber = [[commentDic objectForKey:@"pic"] integerValue];
    }
    
    self.shareObject = [CommonShareObject shareObjectWithRawData:[data objectForKey:@"share"]];
    if (self.shareObject) {
        self.shareObject.identifier = self.serviceId;
        self.shareObject.followingContent = @"【童成】";
    }
    
    NSUInteger status = [[data objectForKey:@"status"] integerValue];
    if (status == 1) {
        self.canBuy = YES;
    } else {
        self.canBuy = NO;
    }
    self.buyButtonTitle = nil;
    if ([data objectForKey:@"statusDesc"]) {
        self.buyButtonTitle = [NSString stringWithFormat:@"%@", [data objectForKey:@"statusDesc"]];
    }
    
    return YES;
}


- (CGFloat)topCellHeight {
    //image
    CGFloat height = SCREEN_WIDTH * self.imageRatio;
    //service name
    height += [ToolBox heightForLabelWithWidth:SCREEN_WIDTH - 20 LineBreakMode:NSLineBreakByCharWrapping Font:[UIFont systemFontOfSize:17] topGap:10 bottomGap:10 maxLine:0 andText:self.serviceName];
    //service description
//    height += [ToolBox heightForLabelWithWidth:SCREEN_WIDTH - 20 LineBreakMode:NSLineBreakByCharWrapping Font:[UIFont systemFontOfSize:13] topGap:10 bottomGap:0 maxLine:0 andText:self.serviceDescription];
    height += [ToolBox heightForAttributeLabelWithWidth:SCREEN_WIDTH - 20 LineBreakMode:NSLineBreakByCharWrapping Font:[UIFont systemFontOfSize:13] topGap:10 bottomGap:10 maxLine:0 andText:self.serviceDescription];
    
    return height;
}

- (CGFloat)priceCellHeight {
    return 40;
}

- (CGFloat)insuranceCellHeight {
    return 30;
}

- (CGFloat)couponCellHeight {
    return 40;
}

- (CGFloat)activityCellHeightAtIndex:(NSUInteger)index {
    if ([self.activeModelsArray count] > index) {
        CGFloat maxWidth = SCREEN_WIDTH - 50;
        ActivityLogoItem *item = [self.activeModelsArray objectAtIndex:index];
        CGFloat height = [ToolBox heightForLabelWithWidth:maxWidth LineBreakMode:NSLineBreakByCharWrapping Font:[UIFont systemFontOfSize:15] topGap:13 bottomGap:13 andText:item.itemDescription];
        if (height < 40) {
            height = 40;
        }
        return height;
    }
    return 40;
}

- (CGFloat)contentCellHeight {
    CGFloat height = [ToolBox heightForLabelWithWidth:SCREEN_WIDTH - 20 LineBreakMode:NSLineBreakByCharWrapping Font:[UIFont systemFontOfSize:14] topGap:10 bottomGap:10 maxLine:0 andText:self.serviceContent];
    
    return height;
}

- (CGFloat)noticeTitleCellHeight {
    return 40;
}

- (CGFloat)noticeCellHeight {
    return self.noticeHeight;
}

- (CGFloat)mealTitleCellHeight {
    return 40;
}

- (CGFloat)mealCellHeight {
    return 80;
}

- (CGFloat)recommendCellHeight {
    CGFloat height = [ToolBox heightForLabelWithWidth:SCREEN_WIDTH - 90 LineBreakMode:NSLineBreakByCharWrapping Font:[UIFont systemFontOfSize:13] topGap:10 bottomGap:10 maxLine:0 andText:self.recommendString];
    if (height < 80) {
        height = 80;
    }
    
    return height;
}

- (CGFloat)moreServiceTitleCellHeight {
    return 40;
}

- (CGFloat)moreServiceCellHeightAtIndex:(NSUInteger)index {
    return 100;
}

- (BOOL)hasCoupon {
    return ([self.couponName length] > 0);
}

@end

@implementation ServiceDetailNoticeItem

- (instancetype)initWithRawData:(NSDictionary *)data {
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.title = [NSString stringWithFormat:@"%@：", [data objectForKey:@"clause"]];
        self.content = [data objectForKey:@"notice"];
    }
    return self;
}

- (CGFloat)itemHeight {
    CGFloat wordWidth = 15;
    CGFloat margin = 10;
    CGFloat height = 0;
    CGFloat labelWidth = SCREEN_WIDTH - margin * 2 - [self.title length] * wordWidth;
    if (labelWidth < 100) {
        height += wordWidth;
    }
    
    height += [ToolBox heightForLabelWithWidth:labelWidth LineBreakMode:NSLineBreakByCharWrapping Font:[UIFont systemFontOfSize:wordWidth] topGap:0 bottomGap:margin andText:self.content];
    
    return height;
}

@end

@implementation ServiceDetailPhoneItem

- (instancetype)initWithTitle:(NSString *)title andPhoneNumbers:(NSArray *)numbers {
    if (!title || ![title isKindOfClass:[NSString class]]) {
        title = @"门店";
    }
    if (!numbers || ![numbers isKindOfClass:[NSArray class]]) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.title = title;
        self.phoneNumbers = numbers;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title andPhoneNumberString:(NSString *)string {
    if (!title || ![title isKindOfClass:[NSString class]]) {
        title = @"门店";
    }
    if (!string || ![string isKindOfClass:[NSString class]] || [string length] == 0) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.title = title;
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        self.phoneNumbers = [string componentsSeparatedByString:@";"];
    }
    return self;
}

@end

@implementation ProductStandardsItem

- (instancetype)initWithRawData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        self.productId = [data[@"productId"] longValue];
        self.standardName = data[@"standardName"];
        self.productName = data[@"productName"];
    }
    return self;
}

@end


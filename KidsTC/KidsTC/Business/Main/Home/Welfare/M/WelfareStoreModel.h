//
//  WelfareStoreModel.h
//  KidsTC
//
//  Created by zhanping on 7/22/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WelfareStoreItem : NSObject
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *coordinate;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) long ID;
@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate2D;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@interface WelfareStoreModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<WelfareStoreItem *> *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSString *page;
@end

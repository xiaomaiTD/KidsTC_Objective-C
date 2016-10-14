//
//  SegueModel.m
//  KidsTC
//
//  Created by 钱烨 on 10/10/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "SegueModel.h"

//H5
NSString *const kSegueParameterKeyLinkUrl = @"kSegueParameterKeyLinkUrl";

@implementation SegueModel

+ (instancetype)modelWithDestination:(SegueDestination)destination{
    return [[self alloc] initWithDestination:destination];
}

+ (instancetype)modelWithDestination:(SegueDestination)destination paramRawData:(NSDictionary *)data{
    return [[self alloc] initWithDestination:destination paramRawData:data];
}

- (instancetype)initWithDestination:(SegueDestination)destination {
    self = [super init];
    if (self) {
        _destination = destination;
    }
    return self;
}

- (instancetype)initWithDestination:(SegueDestination)destination paramRawData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        _destination = destination;
        [self fillSegueParamWithData:data];
    }
    return self;
}

- (void)fillSegueParamWithData:(NSDictionary *)data {
    switch (self.destination) {
        case SegueDestinationH5:
        {
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSString *linkUrlString = [NSString stringWithFormat:@"%@",[data objectForKey:@"linkurl"]];
                if (linkUrlString.length>0) {
                    _segueParam = [NSDictionary dictionaryWithObject:linkUrlString forKey:kSegueParameterKeyLinkUrl];
                } else {
                    _destination = SegueDestinationNone;
                }
            } else {
                _destination = SegueDestinationNone;
            }
        }
            break;
        case SegueDestinationNone:
        case SegueDestinationNewsRecommend:
        case SegueDestinationActivity:
        case SegueDestinationLoveHouse:
        case SegueDestinationHospital:
        case SegueDestinationStrategyList:
        case SegueDestinationColumnList:
            break;
        case SegueDestinationNewsList:
        case SegueDestinationServiceList:
        case SegueDestinationStoreList:
        case SegueDestinationServiceDetail:
        case SegueDestinationStoreDetail:
        case SegueDestinationStrategyDetail:
        case SegueDestinationCouponList:
        case SegueDestinationOrderDetail:
        case SegueDestinationOrderList:
        case SegueDestinationFlashDetail:
        case SegueDestinationColumnDetail:
        case SegueDestinationArticleAlbumn:
        case SegueDestinationStrategyTag:
        {
            if ([data isKindOfClass:[NSDictionary class]]) {
                _segueParam = [NSDictionary dictionaryWithDictionary:data];
            } else {
                _destination = SegueDestinationNone;
            }
        }
            break;
        case SegueDestinationArticalComment:
        {
            if ([data isKindOfClass:[NSDictionary class]]) {
            _segueParam = data;
            }
        }
            break;
        default:
        {
            _destination = SegueDestinationNone;
        }
            break;
    }
}

-(NSString *)description{
    return [NSString stringWithFormat:@"destination:%d,params:%@", self.destination, self.segueParam];
}
@end

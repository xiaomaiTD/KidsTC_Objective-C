//
//  CollectionSCTViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    CollectionSCTTypeStore = 0,
    CollectionSCTTypeContent,
    CollectionSCTTypeTarento,
} CollectionSCTType;

@interface CollectionSCTViewController : ViewController
@property (nonatomic, assign) CollectionSCTType type;;
@end

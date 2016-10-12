//
//  TCHomeCollectionViewBaseLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewBaseLayout.h"

@implementation TCHomeCollectionViewBaseLayout

- (instancetype)initWithCount:(int)count
                  columnCount:(int)columnCount
             layoutAttributes:(TCHomeLayoutAttributes)layoutAttributes
{
    self = [super init];
    if (self) {
        self.count = count;
        self.columnCount = columnCount;
        self.layoutAttributes = layoutAttributes;
    }
    return self;
}

+ (instancetype)layoutWithCount:(int)count
                    columnCount:(int)columnCount
               layoutAttributes:(TCHomeLayoutAttributes)layoutAttributes
{
    return [[self alloc] initWithCount:count columnCount:columnCount layoutAttributes:layoutAttributes];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end

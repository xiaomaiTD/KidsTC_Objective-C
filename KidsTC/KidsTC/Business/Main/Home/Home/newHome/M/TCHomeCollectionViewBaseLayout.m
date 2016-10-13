//
//  TCHomeCollectionViewBaseLayout.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewBaseLayout.h"

@implementation TCHomeCollectionViewBaseLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributes;
}

@end

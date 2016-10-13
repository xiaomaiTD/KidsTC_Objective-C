//
//  TCHomeFloor.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCHomeFloorTitleContent.h"
#import "TCHomeFloorContent.h"

@interface TCHomeFloor : NSObject
@property (nonatomic, assign) BOOL hasTitle;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) TCHomeFloorTitleContentType titleType;
@property (nonatomic, strong) TCHomeFloorTitleContent *titleContent;
@property (nonatomic, assign) TCHomeFloorContentType contentType;
@property (nonatomic, strong) NSArray<TCHomeFloorContent *> *contents;
//以下这个属性只有在contentType为2的时候才会有
@property (nonatomic, strong) NSString *bgImgUrl;
//以下两个属性只有在contentType为5的时候才会有
@property (nonatomic, assign) CGFloat centerSeparation;//左右间距
@property (nonatomic, assign) CGFloat bottomSeparation;//底部间距
/**SelfDefine*/
@property (nonatomic, assign) CGFloat floorHeight;
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;
@end

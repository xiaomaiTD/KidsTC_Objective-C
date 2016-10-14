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

extern CGFloat const kTitleContentHeight;
extern int const kTCHomeCollectionViewCellMaxSections;

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
@property (nonatomic, assign) BOOL showTitleContainer;
@property (nonatomic, assign) BOOL showBgImageView;
@property (nonatomic, assign) BOOL showPageControl;
@property (nonatomic, assign) BOOL canAddYYTimer;
@property (nonatomic, assign) CGFloat floorHeight;
@property (nonatomic, assign) CGRect collectionViewFrame;
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic;
@end

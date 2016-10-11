//
//  TCHomeCollectionViewTwoColumnLayout.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCHomeCollectionViewTwoColumnLayout : UICollectionViewFlowLayout
//以下两个属性只有在contentType为5的时候才会有
@property (nonatomic, assign) CGFloat centerSeparation;//左右间距
@property (nonatomic, assign) CGFloat bottomSeparation;//底部间距
@end

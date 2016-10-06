//
//  ZPPhotoBrowerViewController.h
//  ZPPhotoBrower
//
//  Created by 詹平 on 16/4/22.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ViewController.h"
#import "ArticleModel.h"
@interface ZPPhotoBrowserViewController : ViewController
@property (nonatomic, strong) NSString *articleId;
@property (nonatomic, assign) NSUInteger currentIndex;
@end

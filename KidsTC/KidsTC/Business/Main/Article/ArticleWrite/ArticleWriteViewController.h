//
//  ArticleWriteViewController.h
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ComposeClass.h"
@class ArticleHomeClassItem;
@interface ArticleWriteViewController : ViewController
@property (nonatomic, strong) NSArray<ArticleHomeClassItem *> *classes;
@property (nonatomic, strong) NSArray<ComposeClass *> *articleClasses;
@end

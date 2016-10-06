//
//  ArticleWriteModel.h
//  KidsTC
//
//  Created by zhanping on 9/8/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "Model.h"

typedef enum : NSUInteger {
    ArticleWriteModelTypeClass=1,//分类
    ArticleWriteModelTypeTitle,//标题
    ArticleWriteModelTypeContent,//内容
    ArticleWriteModelTypeCover,//封面
    ArticleWriteModelTypeImage,//图片
} ArticleWriteModelType;

@interface ArticleWriteModel : Model
@property (nonatomic,assign) ArticleWriteModelType type;
@property (nonatomic, assign) BOOL canEdit;//是否可以编辑
@property (nonatomic,strong) NSAttributedString *words;   //文本
@property (nonatomic,strong) NSAttributedString *place;   //占位符
@property (nonatomic,strong) UIFont *font;      //字体
@property (nonatomic,assign) BOOL     lineShow; //对应的cell下划线是否展示
@property (nonatomic,strong) UIImage  *image;   //图片
+(instancetype)modelWith:(ArticleWriteModelType)type;
@end

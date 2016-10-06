//
//  HomeTwoThreeFourCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/22.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeTwoThreeFourCell.h"
#import "AUIStackView.h"
#import "Macro.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "HomeDataManager.h"
#import "SegueMaster.h"
@interface HomeTwoThreeFourCell ()

@property (nonatomic, strong) AUIStackView *stackView;

- (void)didClickedOnImage:(id)sender;

@end


@implementation HomeTwoThreeFourCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.contentView.backgroundColor = COLOR_BG_CEll;
    [self.contentView addSubview:self.stackView];
}

#pragma mark-
#pragma mark 赋值
-(void)setFloorsItem:(HomeFloorsItem *)floorsItem{
    HomeFloorsItem *floorItem1 = floorsItem;
    NSUInteger count = [floorsItem.contents count];
    
    CGFloat hMargin = 10;
    CGFloat hGap = 5;
    CGFloat vMargin = 5;
    CGFloat xPosition = hMargin;
    CGFloat yPosition = vMargin;
    CGFloat width = (SCREEN_WIDTH - 2 * hMargin - (count - 1) * hGap) / count;
    CGFloat height = width * floorsItem.ratio.floatValue;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < count; index ++) {
        HomeItemContentItem *item = floorsItem.contents[index];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosition, yPosition, width, height)];
        //imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setUserInteractionEnabled:YES];
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
        imageView.tag = index;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedOnImage:)];
        [imageView addGestureRecognizer:gesture];
        [tempArray addObject:imageView];
        xPosition += width + hGap;
    }
    [self.stackView setSubViews:[NSArray arrayWithArray:tempArray]];
    [super setFloorsItem:floorItem1];
}

#pragma mark-
#pragma mark lzy
-(AUIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[AUIStackView alloc] initWithFrame:CGRectMake(10, 5, self.contentView.bounds.size.width,self.contentView.bounds.size.height )];
        _stackView.viewGap = 5;
    }
    return _stackView;
}

- (void)didClickedOnImage:(id)sender {
    
    UIView *view = ((UITapGestureRecognizer *)sender).view;
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[self.sectionNo];
    HomeItemContentItem *content = floor.contents[view.tag];
    
    [SegueMaster makeSegueWithModel:content.contentSegue fromController:[HomeDataManager shareHomeDataManager].targetVc];
    
}

@end

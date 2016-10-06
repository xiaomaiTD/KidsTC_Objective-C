//
//  ArticleHomeTagImgCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeTagImgCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ArticleHomeBottomView.h"
#import "ArticleHomeTagImgTableViewCell.h"
#import "ZPTag.h"

#define ICON_H_INSETS 12

static NSString *const ArticleHomeTagImgTableViewCellID = @"ArticleHomeTagImgTableViewCellID";

@interface ArticleHomeTagImgCell ()<UITableViewDelegate,UITableViewDataSource,ZPTagDelegate>
@property (weak, nonatomic) IBOutlet UILabel *coulmnLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ArticleHomeBottomView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConstraintHeight;

@property (nonatomic, strong) NSMutableArray<ZPTag *> *tags;
@end

@implementation ArticleHomeTagImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tags = [NSMutableArray array];
    self.coulmnLabel.textColor = COLOR_PINK;
//    self.iconImageView.layer.borderWidth = LINE_H;
//    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleHomeTagImgTableViewCell" bundle:nil] forCellReuseIdentifier:ArticleHomeTagImgTableViewCellID];
}

- (void)setItem:(ArticleHomeItem *)item {
    [super setItem:item];
    self.iconImageViewConstraintHeight.constant = item.ratio*(SCREEN_WIDTH-2*ICON_H_INSETS);
    self.coulmnLabel.text = item.columnTitle;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    self.bottomView.item = item;
    [self.tableView reloadData];
    self.tableViewConstraintHeight.constant = self.item.products.count * 75;
    [self addTags:item.tags];
}

- (void)addTags:(NSArray<ArticleHomeTag *> *)tags {
    
    [self.tags makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tags removeAllObjects];
    
    CGFloat iconImageView_w = SCREEN_WIDTH-2*ICON_H_INSETS;
    CGFloat iconImageView_h = self.item.ratio*iconImageView_w;
    [tags enumerateObjectsUsingBlock:^(ArticleHomeTag *tag, NSUInteger idx, BOOL *stop) {
        CGPoint point = CGPointMake((tag.left/100)*iconImageView_w , (tag.top/100)*iconImageView_h);
        ZPTag *zpTag = [ZPTag CreatTagWithOriginPoint:point];
        zpTag.tagDirectionByInput = tag.direction;
        zpTag.title = tag.title;
        zpTag.delegate = self;
        zpTag.tag = idx;
        [self.iconImageView addSubview:zpTag];
        [self.tags addObject:zpTag];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.item.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleHomeTagImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ArticleHomeTagImgTableViewCellID];
    cell.product = self.item.products[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(articleHomeBaseCell:actionType:value:)]) {
        [self.delegate articleHomeBaseCell:self actionType:ArticleHomeBaseCellActionTypeSegue value:self.item.products[indexPath.row].segueModel];
    }
}

#pragma mark - ZPTagDelegate

- (void)didClickTag:(ZPTag *)tag {
    if ([self.delegate respondsToSelector:@selector(articleHomeBaseCell:actionType:value:)]) {
        ArticleHomeTag *tagItem = self.item.tags[tag.tag];
        [self.delegate articleHomeBaseCell:self actionType:ArticleHomeBaseCellActionTypeSegue value:tagItem.segueModel];
    }
}



@end

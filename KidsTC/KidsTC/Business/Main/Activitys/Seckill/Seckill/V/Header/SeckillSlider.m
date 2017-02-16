//
//  SeckillSlider.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillSlider.h"
#import "SeckillSliderDateItem.h"
#import "SeckillSliderTimeItem.h"
#import "SeckillSliderCountDownView.h"

CGFloat const kSeckillSliderH = 122;

@interface SeckillSlider ()<SeckillSliderDateItemDelegate,SeckillSliderTimeItemDelegate,SeckillSliderCountDownViewDelegate>
@property (weak, nonatomic  ) IBOutlet UIView *dateBGView;
@property (weak, nonatomic  ) IBOutlet UIScrollView *dateScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateBGViewH;

@property (weak, nonatomic  ) IBOutlet UIView *timeBGView;
@property (weak, nonatomic  ) IBOutlet UIScrollView *timeScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeBGViewH;

@property (weak, nonatomic  ) IBOutlet SeckillSliderCountDownView *countDownView;

@property (nonatomic, strong) NSArray<SeckillSliderDateItem *> *dates;
@property (nonatomic, strong) NSArray<UIImageView *> *dateArrows;
@property (nonatomic, strong) NSArray<SeckillSliderTimeItem *> *times;

@property (weak, nonatomic  ) SeckillSliderDateItem *selDateItem;
@property (weak, nonatomic  ) SeckillSliderTimeItem *selTimeItem;
@end

@implementation SeckillSlider

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.countDownView.delegate = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat date_bg_w = CGRectGetWidth(self.dateBGView.bounds);
    CGFloat date_bg_h = CGRectGetHeight(self.dateBGView.bounds);
    
    CGFloat arrow_s = 11;
    CGFloat arrow_y = (date_bg_h-arrow_s)*0.5-4;
    
    CGFloat date_item_w = 0;
    NSUInteger dateCount = self.dates.count;
    if (dateCount>3) {
        date_item_w = (date_bg_w - arrow_s*3)/3.5;
    }else if (dateCount>0) {
        date_item_w = (date_bg_w - arrow_s*2)/3.0;
    }
    [self.dates enumerateObjectsUsingBlock:^(SeckillSliderDateItem *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectMake((date_item_w+arrow_s)*idx, 0, date_item_w, date_bg_h);
        if (idx<self.dateArrows.count) {
            UIImageView *dateArrow = self.dateArrows[idx];
            dateArrow.frame = CGRectMake(date_item_w+(date_item_w+arrow_s)*idx, arrow_y, arrow_s, arrow_s);
        }
    }];
    self.dateScrollView.contentSize = CGSizeMake(dateCount*date_item_w+(dateCount-1)*arrow_s, date_bg_h);
    
    CGFloat time_bg_h = CGRectGetHeight(self.timeBGView.bounds);
    CGFloat time_bg_w = CGRectGetWidth(self.timeBGView.bounds);
    CGFloat time_item_w = 0;
    NSUInteger timeCount = self.times.count;
    if (timeCount>4) {
        time_item_w = time_bg_w/4.5;
    }else if (timeCount>0){
        time_item_w = time_bg_w/4.0;
    }
    [self.times enumerateObjectsUsingBlock:^(SeckillSliderTimeItem *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectMake(time_item_w*idx, 0, time_item_w, time_bg_h);
    }];
    self.timeScrollView.contentSize = CGSizeMake(time_item_w*timeCount, time_bg_h);
}

- (void)setTimeData:(SeckillTimeData *)timeData {
    _timeData = timeData;
    self.hidden = (timeData==nil||timeData.tabs.count<1);
    if (self.dates.count>0) {
        [self.dates makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.dates = nil;
    }
    
    
    NSMutableArray *dates = [NSMutableArray array];
    NSMutableArray *dateArrows = [NSMutableArray array];
    NSUInteger dateCount = timeData.tabs.count;
    __block SeckillSliderDateItem *selDateItem = nil;
    [timeData.tabs enumerateObjectsUsingBlock:^(SeckillTimeDate *date, NSUInteger idx, BOOL *stop) {
        SeckillSliderDateItem *dateItem = [[NSBundle mainBundle] loadNibNamed:@"SeckillSliderDateItem" owner:self options:nil].firstObject;
        dateItem.date = date;
        dateItem.tag = idx;
        dateItem.delegate = self;
        [self.dateScrollView addSubview:dateItem];
        if (dateItem) [dates addObject:dateItem];
        if (!selDateItem && date.isChecked) {
            selDateItem = dateItem;
        }
        
        if (idx!=dateCount-1) {
            UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Seckill_dateArrow"]];
            [self.dateScrollView addSubview:arrow];
            if (arrow) [dateArrows addObject:arrow];
        }
    }];
    self.dates = [NSArray arrayWithArray:dates];
    self.dateArrows = dateArrows;
    
    if (dates.count>0 && !selDateItem) {
        selDateItem = dates.firstObject;
    }
    if (selDateItem) {
        [self didSelectDateItem:selDateItem];
    }
    
    if (timeData.tabs.count<2) {
        self.dateScrollView.hidden = YES;
        self.dateBGViewH.constant = 0;
    }else{
        self.dateScrollView.hidden = NO;
        self.dateBGViewH.constant = 30;
    }
}

- (void)setDataData:(SeckillDataData *)dataData {
    _dataData = dataData;
    self.countDownView.data = dataData;
}

- (void)didSelectDateItem:(SeckillSliderDateItem *)dateItem {
    
    self.selDateItem.selected = NO;
    dateItem.selected = YES;
    self.selDateItem = dateItem;
    
    if (self.times.count>0) {
        [self.times makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.times = nil;
    }
    NSMutableArray *times = [NSMutableArray array];
    NSArray<SeckillTimeTime *> *timeItems = dateItem.date.tabs;
    __block SeckillSliderTimeItem *selTimeItem = nil;
    [timeItems enumerateObjectsUsingBlock:^(SeckillTimeTime *time, NSUInteger idx, BOOL *stop) {
        SeckillSliderTimeItem *timeItem = [[NSBundle mainBundle] loadNibNamed:@"SeckillSliderTimeItem" owner:self options:nil].firstObject;
        timeItem.time = time;
        timeItem.tag = idx;
        timeItem.delegate = self;
        [self.timeScrollView addSubview:timeItem];
        if (timeItem) [times addObject:timeItem];
        if (!selTimeItem && time.isChecked) {
            selTimeItem = timeItem;
        }
    }];
    self.times = [NSArray arrayWithArray:times];
    
    if (times.count>0 && !selTimeItem) {
        selTimeItem = times.firstObject;
    }
    self.selTimeItem = nil;
    if (selTimeItem) {
        [self didSelectTimeItem:selTimeItem];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [self scroll:self.dateScrollView target:dateItem];
    
    if (timeItems.count<2) {
        self.timeBGView.hidden = YES;
        self.timeBGViewH.constant = 0;
    }else{
        self.timeBGView.hidden = NO;
        self.timeBGViewH.constant = 53;
    }
}

- (void)didSelectTimeItem:(SeckillSliderTimeItem *)timeItem {
    
    self.selTimeItem.selected = NO;
    timeItem.selected = YES;
    self.selTimeItem = timeItem;
    if ([self.delegate respondsToSelector:@selector(seckillSlider:didSelectTimeItem:)]) {
        [self.delegate seckillSlider:self didSelectTimeItem:timeItem.time];
    }
    [self scroll:self.timeScrollView target:timeItem];
}

- (void)scroll:(UIScrollView *)scrollView target:(UIView *)target {
    if (!target || !scrollView) return;
    [UIView animateWithDuration:0.2 animations:^{
        CGFloat maxOffsetX = scrollView.contentSize.width-scrollView.frame.size.width;
        if (maxOffsetX>=0) {
            CGFloat offsetX = target.center.x-scrollView.frame.size.width*0.5;
            CGFloat minOffsetX = 0;
            if (offsetX < minOffsetX) {
                offsetX = minOffsetX;
            }else if (offsetX > maxOffsetX) {
                offsetX = maxOffsetX;
            }
            [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }
    }];
}

#pragma mark - SeckillSliderDateItemDelegate

- (void)didClickSeckillSliderDateItem:(SeckillSliderDateItem *)item {
    [self didSelectDateItem:item];
}

#pragma mark - SeckillSliderTimeItemDelegate

- (void)didClickSeckillSliderTimeItem:(SeckillSliderTimeItem *)item {
    [self didSelectTimeItem:item];
}

#pragma mark - SeckillSliderCountDownViewDelegate

- (void)seckillSliderCountDownViewCountDownOver:(SeckillSliderCountDownView *)view {
    if ([self.delegate respondsToSelector:@selector(seckillSliderCountDownOver:)]) {
        [self.delegate seckillSliderCountDownOver:self];
    }
}

@end

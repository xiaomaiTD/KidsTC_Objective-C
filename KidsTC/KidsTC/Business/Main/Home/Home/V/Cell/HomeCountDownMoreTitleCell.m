//
//  HomeCountDownMoreTitleCell.m
//  appDelegate
//
//  Created by ling on 16/7/19.
//  Copyright © 2016年 潘灵. All rights reserved.
//

#import "HomeCountDownMoreTitleCell.h"
#import "Masonry.h"
#import "GHeader.h"
#import "UILabel+Additions.h"
#import "HomeModel.h"
#import "ATCountDown.h"
@interface CountdownView ()

@property (nonatomic, strong) UILabel *lb_des;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UILabel *lb_hour;
@property (nonatomic, strong) UILabel *lb_sym1;//:分隔符
@property (nonatomic, strong) UILabel *lb_sym2;
@property (nonatomic, strong) UILabel *lb_minute;
@property (nonatomic, strong) UILabel *lb_second;

@end

@implementation CountdownView

#pragma mark-
#pragma mark 初始化
-(instancetype)init{
    if(self = [super init]){
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    [self addSubview:self.lb_des];
    [self addSubview:self.separator];
    [self addSubview:self.lb_hour];
    [self addSubview:self.lb_minute];
    [self addSubview:self.lb_second];
    [self addSubview:self.lb_sym1];
    [self addSubview:self.lb_sym2];
    
    [self setupConstraint];
}

-(void)setupConstraint{
    
    [self.lb_des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self).offset(5);
    }];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(@1);
        make.height.equalTo(@12);
        make.leading.equalTo(self.lb_des.mas_trailing).offset(5);
    }];
    
    [self.lb_hour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.separator.mas_trailing).offset(5);
    }];
    
    [self.lb_sym1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.lb_hour.mas_trailing).offset(5);
    }];
    
    [self.lb_minute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.lb_sym1.mas_trailing).offset(5);
    }];
    
    [self.lb_sym2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.lb_minute.mas_trailing).offset(5);
    }];

    [self.lb_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.lb_sym2.mas_trailing).offset(5);
    }];

    
}


-(UILabel *)lb_des{
    
    if (!_lb_des) {
        
        _lb_des = [[UILabel alloc] initWithTitle:@"距离开始" FontSize:13 FontColor:[UIColor darkGrayColor]];
    }
    return _lb_des;
}
-(UIView *)separator{
    
    if (!_separator) {
        
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor lightGrayColor];
    }
    return _separator;
}
-(UILabel *)lb_hour{
    
    if (!_lb_hour) {
        
        _lb_hour = [[UILabel alloc] initWithTitle:@"00" FontSize:13 FontColor:COLOR_PINK];
    }
    return _lb_hour;
}
-(UILabel *)lb_minute{
    
    if (!_lb_minute) {
        
        _lb_minute = [[UILabel alloc] initWithTitle:@"00" FontSize:13 FontColor:COLOR_PINK];
    }
    return _lb_minute;
}
-(UILabel *)lb_second{
    
    if (!_lb_second) {
        
        _lb_second = [[UILabel alloc] initWithTitle:@"00" FontSize:13 FontColor:COLOR_PINK];
    }
    return _lb_second;
}
-(UILabel *)lb_sym1{
    
    if (!_lb_sym1) {
        
        _lb_sym1 = [[UILabel alloc] initWithTitle:@":" FontSize:13 FontColor:[UIColor darkGrayColor]];
    }
    return _lb_sym1;
}
-(UILabel *)lb_sym2{
    
    if (!_lb_sym2) {
        
        _lb_sym2 = [[UILabel alloc] initWithTitle:@":" FontSize:13 FontColor:[UIColor darkGrayColor]];
    }
    return _lb_sym2;
}
@end




@interface SubTitleView()

@property (nonatomic, strong) UILabel *lb_subTitle;
@property (nonatomic, strong) UIImageView *iv_arrow;

@end

@implementation SubTitleView

-(instancetype)init{
    
    if(self = [super init]){
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    [self addSubview:self.lb_subTitle];
    [self addSubview:self.iv_arrow];
    
    [self setupConstraint];
}

-(void)setupConstraint{
    
    [self.lb_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.centerY.equalTo(self);
        make.trailing.equalTo(self.iv_arrow.mas_leading);
    }];
    
    [self.iv_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lb_subTitle.mas_trailing);
        make.width.height.equalTo(@15);
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-5);
    }];
}

-(UILabel *)lb_subTitle{
    
    if (!_lb_subTitle) {
        
        _lb_subTitle = [[UILabel alloc] initWithTitle:@"副标题" FontSize:12 FontColor:[UIColor lightGrayColor]];
        _lb_subTitle.textAlignment = NSTextAlignmentRight;
    }
    return _lb_subTitle;
}

-(UIImageView *)iv_arrow{
    
    if (!_iv_arrow) {
        _iv_arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_r"]];
    }
    return _iv_arrow;
}
@end




@interface HomeCountDownMoreTitleCell ()

@property (nonatomic, strong) UIView *tagView;
@property (nonatomic, strong) UILabel *lb_title;
@property (nonatomic, strong) CountdownView *countdown;
@property (nonatomic, strong) SubTitleView *subTitle;

@property (nonatomic, strong) ATCountDown *countDownTimer;
@property (nonatomic, assign) BOOL hasStartCountDown;

@end


@implementation HomeCountDownMoreTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUI];
    }
    return self;
}

#pragma mark-
#pragma mark setupUI
-(void)setUI{
    
    [self.contentView addSubview:self.tagView];
    [self.contentView addSubview:self.lb_title];
    [self.contentView addSubview:self.countdown];
    [self.contentView addSubview:self.subTitle];
    
    [self setupConstraint];
    
}

-(void)setupConstraint{
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.width.equalTo(@3);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.tagView.mas_trailing).offset(10);
    }];
    
    [self.countdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lb_title.mas_trailing).offset(5);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
        make.centerY.equalTo(self);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.equalTo(self);
        make.leading.equalTo(self.countdown.mas_trailing);
    }];
    
}

#pragma mark-
#pragma mark 赋值
-(void)setFloorsItem:(HomeFloorsItem *)floorItem{
   
    HomeFloorsItem *floorItem1 = floorItem;
    
    HomeTitleCellType type = floorItem.titleType;
    HomeItemTitleItem *titleItem = floorItem.titleContent;
    
    self.lb_title.text = titleItem.name;//标题
    switch (type) {
        case HomeTitleCellTypeNormalTitle:{
            self.countdown.hidden = YES;
            self.subTitle.hidden = YES;
        }
            break;
        case HomeTitleCellTypeMoreTitle:{
            self.subTitle.hidden = NO;
            self.countdown.hidden = YES;
            self.subTitle.lb_subTitle.text = titleItem.subName;
        }
            break;
        case HomeTitleCellTypeCountDownTitle:{
            self.countdown.hidden = NO;
            self.subTitle.hidden = YES;
            
            self.countdown.lb_des.text = titleItem.remainName;
            NSTimeInterval leftTime = [titleItem.remainTime integerValue];
            [self setLeftTime:leftTime];
        }
            break;
        case HomeTitleCellTypeCountDownMoreTitle:{
            self.countdown.hidden = NO;
            self.subTitle.hidden = NO;
            
            self.countdown.lb_des.text = titleItem.remainName != nil ? titleItem.remainName : @"";
            TCLog(@"副标题%@",titleItem.subName);
            NSTimeInterval leftTime = [titleItem.remainTime integerValue];
            [self setLeftTime:leftTime];
            self.subTitle.lb_subTitle.text = titleItem.subName;
        }
            break;
        default:
            break;
    }
     [super setFloorsItem:floorItem1];
}

#pragma mark-
#pragma mark timmer
- (void)setLeftTime:(NSTimeInterval)leftTime {
    if (!self.hasStartCountDown) {
        self.hasStartCountDown = YES;
        self.countDownTimer = [[ATCountDown alloc] initWithLeftTimeInterval:leftTime];
        WeakSelf(self)
        [weakself.countDownTimer startCountDownWithCurrentTimeLeft:^(NSTimeInterval currentTimeLeft) {
            [weakself setLabelsWithTime:[ATCountDown countDownTimeStructHMSWithLeftTime2:currentTimeLeft]];
        }];
    }
}

- (void)setLabelsWithTime:(TimeStructHMS)timeStruct {
    NSString *hourString = [NSString stringWithFormat:@"%02lu", (unsigned long)(timeStruct.hour)];
    NSString *minuteString = [NSString stringWithFormat:@"%02lu", (unsigned long)(timeStruct.min)];
    NSString *secondString = [NSString stringWithFormat:@"%02lu", (unsigned long)(timeStruct.sec)];
    [self.countdown.lb_hour setText:hourString];
    [self.countdown.lb_minute setText:minuteString];
    [self.countdown.lb_second setText:secondString];
}


- (void)stopCountDown {
    [self.countDownTimer stopCountDown];
    self.hasStartCountDown = NO;
}


#pragma mark-
#pragma mark lzy
-(UIView *)tagView{
    
    if (!_tagView) {
        
        _tagView = [[UIView alloc] init];
        _tagView.backgroundColor = COLOR_PINK;
    }
    return _tagView;
}

-(UILabel *)lb_title{
    
    if (!_lb_title) {
        
        _lb_title = [[UILabel alloc] initWithTitle:@"掌上秒杀" FontSize:17 FontColor:COLOR_PINK];
    }
    return _lb_title;
}

-(CountdownView *)countdown{
    
    if (!_countdown) {
        
        _countdown = [[CountdownView alloc] init];
        
    }
    return _countdown;
}

-(SubTitleView *)subTitle{
    
    if (!_subTitle) {
        
        _subTitle = [[SubTitleView alloc] init];
        
    }
    return _subTitle;
}
@end

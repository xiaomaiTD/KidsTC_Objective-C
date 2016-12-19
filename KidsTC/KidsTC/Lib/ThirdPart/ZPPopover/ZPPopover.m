//
//  ZpMenuView.m
//  ZpMenuController
//
//  Created by zhanping on 3/16/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ZPPopover.h"
#import "ZPPopoverCell.h"
#import "AppDelegate.h"
#import "Colours.h"

static NSString *identifier = @"ZPPopoverCellReuseIdentifier";
#define ViewBackgroundColor [UIColor clearColor] //整个大视图的背景色
#define MenuBackgroundColor [[UIColor colorFromHexString:@"3D3D3D"] colorWithAlphaComponent:0.94] //视图的背景色

CGFloat const PopoverItemHight = 44; //每一行的高度
CGFloat const PopoverItemWidth = 156; //每一行的宽度,也就是tableView的宽度
CGFloat const PopoverTipHight = 8; //小三角的高度
CGFloat const PopoverTipWidth = 15; //小三角的宽度
CGFloat const PopoverEdgeInset = 8; //tableView的左右下最少间距
CGFloat const PopoverCornerRadius = 8; //tableView的圆角半径

@interface ZPPopover ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<ZPPopoverItem *> *items;//一个个用于显示的Model元素
@property (nonatomic, assign) BOOL isVisiable;//是否已经显示在界面上
@property (nonatomic, assign) CGPoint topPoint;//小三角的顶点坐标

@end

@implementation ZPPopover


+(ZPPopover *)popoverWithTopPointInWindow:(CGPoint)topPoint items:(NSArray<ZPPopoverItem *> *)items{
    
    return [[ZPPopover alloc]initWithTopPointInWindow:topPoint items:items];
}

- (instancetype)initWithTopPointInWindow:(CGPoint)topPoint items:(NSArray<ZPPopoverItem *> *)items{
    
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self = [super initWithFrame:frame];
    if (self) {
        self.topPoint = [self resetTopPoint:topPoint];
        self.items = items;
        
        self.backgroundColor = ViewBackgroundColor;
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake([self getTableViewX], self.topPoint.y+PopoverTipHight, PopoverItemWidth, [self getTableViewHight])];
        [self setUpTableView];
        
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - private methods

-(CGPoint)resetTopPoint:(CGPoint)topPoint{
    
    CGFloat topPointMinX = PopoverEdgeInset + PopoverCornerRadius + PopoverTipWidth/2.0;
    
    CGFloat topPointMaxX = CGRectGetWidth([UIScreen mainScreen].bounds) - PopoverEdgeInset - PopoverCornerRadius - PopoverTipWidth/2.0;
    
    if (topPoint.x<topPointMinX) {
        topPoint.x = topPointMinX;
    }else if (topPoint.x>topPointMaxX){
        topPoint.x = topPointMaxX;
    }
    
    return topPoint;
}

//画小三角
-(void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint leftPoint = CGPointMake(self.topPoint.x-PopoverTipWidth/2.0, self.topPoint.y+PopoverTipHight);
    CGPoint rightPoint = CGPointMake(self.topPoint.x+PopoverTipWidth/2.0, self.topPoint.y+PopoverTipHight);
    
    [path moveToPoint:self.topPoint];
    [path addLineToPoint:leftPoint];
    [path addLineToPoint:rightPoint];
    [path addLineToPoint:self.topPoint];
    
    [MenuBackgroundColor setFill];
    [path fill];
}

//计算tableView的x坐标值
-(CGFloat)getTableViewX{
    
    CGFloat tableViewX = 0;
    
    CGFloat rightPointX = self.topPoint.x+PopoverTipWidth/2.0;//小三角的右顶点的x值
    CGFloat rightTableViewPointX = PopoverEdgeInset + PopoverItemWidth - PopoverCornerRadius;//tableView的上边框和右上角的圆弧相切的点的x值
    
    CGFloat leftPointX = self.topPoint.x - PopoverTipWidth/2.0;//小三角的左顶点的x值
    CGFloat leftTableViewPointX = CGRectGetWidth([UIScreen mainScreen].bounds) - PopoverEdgeInset - PopoverItemWidth + PopoverCornerRadius;//tableView的上边框和左上角的圆弧相切的点的x值
    
    if (rightPointX<=rightTableViewPointX) {
        tableViewX = PopoverEdgeInset;//让tableView靠左
    }else if (leftPointX>=leftTableViewPointX){//让tableView靠右
        tableViewX = CGRectGetWidth([UIScreen mainScreen].bounds) - PopoverEdgeInset - PopoverItemWidth;
    }else{//让tableView和topPint居中对齐
        tableViewX = self.topPoint.x - PopoverItemWidth/2.0;
    }
    
    return tableViewX;
}

//计算tableView的高度
-(CGFloat)getTableViewHight{
    
    CGFloat originalHight = self.items.count * PopoverItemHight;//本来应该占用的高度
    CGFloat leftHight = CGRectGetHeight([UIScreen mainScreen].bounds) - self.topPoint.y - PopoverTipHight - 8;//剩余可用高度
    CGFloat tableViewHight = originalHight >= leftHight ? leftHight:originalHight;
    
    return tableViewHight;
}

//tableView的一些相关设置
-(void)setUpTableView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = MenuBackgroundColor;
    [self setTableViewBounces];//设置TableView是否可滚动
    self.tableView.layer.cornerRadius = PopoverCornerRadius;
    self.tableView.layer.masksToBounds = YES;
}

//设置TableView是否可滚动
- (void)setTableViewBounces{
    
    CGFloat originalHight = self.items.count * PopoverItemHight;//本来应该占用的高度
    CGFloat leftHight = CGRectGetHeight([UIScreen mainScreen].bounds) - self.topPoint.y - PopoverTipHight - 8;//剩余可用高度
    
    if (originalHight > leftHight) {//若果本来应该占用的高度大于剩余可用的高度就让tableView可以滚动
        self.tableView.bounces = YES;
    }else{
        self.tableView.bounces = NO;
    }
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PopoverItemHight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZPPopoverCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZPPopoverCell" owner:self options:nil] lastObject];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.item = self.items[indexPath.row];
    
    //隐藏最后一行的分割线
    if (indexPath.row == self.items.count - 1) {
        cell.separatorImageView.hidden = YES;
    }else{
        cell.separatorImageView.hidden = NO;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectMenuItemAtIndex:)]) {
        [self.delegate didSelectMenuItemAtIndex:indexPath.row];
    }
    [self hide];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hide];
}

#pragma mark - 控制视图显示或隐藏

- (void)show{
    if (self.isVisiable) {
        return;
    }
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if ([window isKeyWindow] == NO)
    {
        [window makeKeyAndVisible];
    }
    if (window && self) {
        [window addSubview:self];
        self.isVisiable = YES;
        self.hidden = NO;
    }
}

- (void)hide{
    self.isVisiable = NO;
    self.hidden = YES;
}

-(void)dealloc{
    
}

@end

//
//  Created by 詹平 on 15/6/26.
//  Copyright (c) 2015年 jcjzwork. All rights reserved.
//

#import "ActionSheet.h"
#import "SheetCell.h"
#define SheetCell_HEIGHT 50
#define  DEVICE_WIDTH_ActionSheet CGRectGetWidth([[UIScreen mainScreen]bounds])
#define  DEVICE_HEIGHT_ActionSheet CGRectGetHeight([[UIScreen mainScreen]bounds])
#define  APPDELEGATE_ActionSheet [UIApplication sharedApplication].delegate
@interface ActionSheet ()<UITableViewDataSource,UITableViewDelegate,ActionSheetDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *sectionAry;
@property (nonatomic,assign)int itemsCount;
@property (nonatomic,assign)BOOL isHaveTitle;
@property (nonatomic,assign)BOOL isHaveCancleButtonTitle;
@property (nonatomic,assign)BOOL isHaveDestructiveButtonTitle;

@property (nonatomic,strong)NSString *title;
@property (nonatomic,weak)id<ActionSheetDelegate> delegate;
@property (nonatomic,strong)NSString *cancelButtonTitle;
@property (nonatomic,strong)NSString *destructiveButtonTitle;
@property (nonatomic,strong)NSMutableArray *otherButtonTitles;

@property (nonatomic,assign)float tableView_height;
@property (nonatomic,getter = isShowing) BOOL show;//是否正在显示
@end

@implementation ActionSheet

-(instancetype __nullable)initWithTitle:(NSString *__nullable)title delegate:(id<ActionSheetDelegate>__nullable)delegate cancelButtonTitle:(NSString *__nullable)cancelButtonTitle destructiveButtonTitle:(NSString *__nullable)destructiveButtonTitle otherButtonTitles:(NSString *__nullable)otherButtonTitles,...NS_REQUIRES_NIL_TERMINATION{
    self=[super init];
    if (self) {
        self.frame=CGRectMake(0, 0, DEVICE_WIDTH_ActionSheet, DEVICE_HEIGHT_ActionSheet);
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
        self.alpha = 0;
        self.title=title;
        self.delegate=delegate;
        self.cancelButtonTitle=cancelButtonTitle;
        self.destructiveButtonTitle=destructiveButtonTitle;
        self.otherButtonTitles=[NSMutableArray array];
        
        NSString* curStr;
        va_list list;
        if(otherButtonTitles){
            //1.取得第一个参数的值
            [self.otherButtonTitles addObject:otherButtonTitles];
            //2.从第2个参数开始，依此取得所有参数的值
            va_start(list, otherButtonTitles);
            while ((curStr=va_arg(list, NSString*))){
                [self.otherButtonTitles addObject:curStr];
            }
            va_end(list);
        }
        if (self.title) {
            self.isHaveTitle=YES;
        }
        
        self.sectionAry=[NSMutableArray array];
        NSMutableArray *rows0=[NSMutableArray array];
        for (NSString *otherButtonTitle in self.otherButtonTitles) {
            if (otherButtonTitle) {
                self.itemsCount++;
                [rows0 addObject:otherButtonTitle];
            }
        }
        
        if (self.destructiveButtonTitle) {
            self.isHaveDestructiveButtonTitle=YES;
            self.itemsCount++;
            [rows0 addObject:self.destructiveButtonTitle];
        }
        
        [self.sectionAry addObject:rows0];
        
        
        NSMutableArray *rows1=[NSMutableArray array];
        if (self.cancelButtonTitle) {
            self.isHaveCancleButtonTitle=YES;
            self.itemsCount++;
            [rows1 addObject:self.cancelButtonTitle];
        }
        [self.sectionAry addObject:rows1];
        
        
        self.tableView_height=(self.isHaveTitle?20:0)+(self.itemsCount*50)+(self.isHaveCancleButtonTitle?(10):0);
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT_ActionSheet, DEVICE_WIDTH_ActionSheet, self.tableView_height) style:UITableViewStyleGrouped];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.showsVerticalScrollIndicator=NO;
        self.tableView.showsHorizontalScrollIndicator=NO;
        self.tableView.scrollEnabled=NO;
        self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        [self addSubview:self.tableView];
        
        
        //透明的关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame=CGRectMake(0, 0, DEVICE_WIDTH_ActionSheet, DEVICE_HEIGHT_ActionSheet-self.tableView_height);
        [closeBtn addTarget:self action:@selector(cancelBtn_click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sectionAry[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SheetCell_HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.isHaveTitle) {
        if (section==0) {
            return 20;
        }else{
            return 10;
        }
    }else{
        if (section==0) {
            return .1;
        }else{
            return 10;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.isHaveTitle&&section==0) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH_ActionSheet, 20)];
        label.font=[UIFont systemFontOfSize:13];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.text=self.title;
        return label;
    }else{
        return nil;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SheetCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SheetCell"];
    if (!cell) {
        cell=(SheetCell *)[[[NSBundle mainBundle]loadNibNamed:@"SheetCell" owner:self options:0]lastObject];
    }
    cell.itemL.text=self.sectionAry[indexPath.section][indexPath.row];
    if (indexPath.row==[self.sectionAry[indexPath.section] count]-1) {
        cell.lineImg.hidden=YES;
    }else{
        cell.lineImg.hidden=NO;
    }
    if (self.isHaveDestructiveButtonTitle&&indexPath.section==0&&indexPath.row==[self.sectionAry[0] count]-1) {
        cell.itemL.textColor=COLOR_PINK;
    }else{
        cell.itemL.textColor=[UIColor darkGrayColor];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickActionSheet:clickedButtonAtIndex:)]) {
        
        if (self.isHaveCancleButtonTitle) {
            if (indexPath.section==self.sectionAry.count-1) {
                [self.delegate didClickActionSheet:self clickedButtonAtIndex:indexPath.row];
            }else{
                [self.delegate didClickActionSheet:self clickedButtonAtIndex:indexPath.row+1];
            }
        }else{
            [self.delegate didClickActionSheet:self clickedButtonAtIndex:indexPath.row+1];
        }
    }
}
-(void)cancelBtn_click{
    [self hide];
}
- (void)show{
    if (self.isShowing) {
        return;
    }
    
    [APPDELEGATE_ActionSheet.window addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.tableView.frame=CGRectMake(0, DEVICE_HEIGHT_ActionSheet-self.tableView_height, DEVICE_WIDTH_ActionSheet, self.tableView_height);
        self.show=YES;
    }];
}
- (void)hide{
    if (!self.isShowing) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.tableView.frame=CGRectMake(0, DEVICE_HEIGHT_ActionSheet, DEVICE_WIDTH_ActionSheet, self.tableView_height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.show=NO;
    }];
}


@end

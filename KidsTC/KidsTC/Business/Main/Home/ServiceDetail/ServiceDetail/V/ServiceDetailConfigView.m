//
//  ServiceDetailConfigView.m
//  KidsTC
//
//  Created by zhanping on 6/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ServiceDetailConfigView.h"
#import "ServiceDetailConfigTableHeaderView.h"
#import "ServiceDetailConfirmViewCell.h"
#import "UIButton+Category.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ToolBox.h"
@interface ServiceDetailConfigHeaderView : UIView
@end
@implementation ServiceDetailConfigHeaderView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}
@end

@interface ServiceDetailConfigView ()<UITableViewDelegate,UITableViewDataSource,ServiceDetailConfigTableHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) ServiceDetailConfigTableHeaderView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) NSArray<ProductStandardsItem *> *product_standards;
@end
static NSString *ID = @"ServiceDetailConfirmViewCell";
@implementation ServiceDetailConfigView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    CALayer *iconLayer = self.iconImageView.layer;
    iconLayer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    iconLayer.borderWidth = 2;
    iconLayer.cornerRadius = 8;
    iconLayer.masksToBounds = YES;
    
    [self.statusBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    UIColor *color = COLOR_PINK;
    [self.statusBtn setBackgroundColor:color forState:UIControlStateNormal];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceDetailConfirmViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ID];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"ServiceDetailConfigTableHeaderView" owner:self options:nil]firstObject];
    self.tableHeaderView.delegate = self;
    
}

- (void)setProduct_standards:(NSArray<ProductStandardsItem *> *)product_standards currentIndex:(int)index{
    _product_standards = product_standards;
    [self.tableHeaderView setProduct_standards:product_standards currentIndex:index];
    self.tableView.tableHeaderView = self.tableHeaderView;
}

- (void)setData:(ServiceDetailConfigData *)data{
    _data = data;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.productImg] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    
    [self setPriceLabelTextData:data];
    
    self.titleLabel.text = data.productName;
    
    self.tableHeaderView.data = data;
    
    [self.tableView reloadData];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    self.statusBtn.enabled = (data.status==1);
    [self.statusBtn setTitle:data.statusDesc forState:UIControlStateNormal];
    
}


- (void)setPriceLabelTextData:(ServiceDetailConfigData *)data{
    
    NSString *currentPriceStr = [NSString stringWithFormat:@"¥%0.1f ",data.price];
    NSString *originalPriceStr = [NSString stringWithFormat:@"%0.1f",data.storePrice];
    NSString *leftNumStr = [NSString stringWithFormat:@" (库存%zd)",data.remainStock];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]init];
    
    UIColor *color = COLOR_PINK;
    NSDictionary *currentPriceAtt = @{NSForegroundColorAttributeName:color,
                                      NSFontAttributeName:[UIFont systemFontOfSize:21]};
    NSAttributedString *currentPriceAttStr = [[NSAttributedString alloc]initWithString:currentPriceStr attributes:currentPriceAtt];
    [attStr appendAttributedString:currentPriceAttStr];
    
    NSDictionary *originalPriceAtt = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                       NSFontAttributeName:[UIFont systemFontOfSize:17],
                                       NSStrikethroughStyleAttributeName:@(1)};
    NSAttributedString *originalPriceAttStr = [[NSAttributedString alloc]initWithString:originalPriceStr attributes:originalPriceAtt];
    [attStr appendAttributedString:originalPriceAttStr];
    
    NSDictionary *leftNumAtt = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                 NSFontAttributeName:[UIFont systemFontOfSize:17]};
    NSAttributedString *leftNumAttStr = [[NSAttributedString alloc]initWithString:leftNumStr attributes:leftNumAtt];
    [attStr appendAttributedString:leftNumAttStr];
    
    self.priceLabel.attributedText = attStr;
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.stores.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceDetailConfirmViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    ServiceDetailConfigStoreItem *item = self.data.stores[indexPath.row];
    [cell setStoreName:item.storeName];
    [cell setStarNumber:item.commentAverage];
    [cell setDistance:item.distance];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.data.stores.count) {
        ServiceDetailConfigStoreItem *item = self.data.stores[indexPath.row];
        self.tableHeaderView.storeLabel.text = item.storeName;
        self.selectedIndex = indexPath.row;
    }
}

#pragma mark <ServiceDetailConfigTableHeaderViewDelegate>

- (void)serviceDetailConfigTableHeaderView:(ServiceDetailConfigTableHeaderView *)view didClickBtnAtIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(serviceDetailConfigView:didClickBtnWithPid:)]) {
        [self.delegate serviceDetailConfigView:self didClickBtnWithPid:self.product_standards[index].productId];
    }
}

- (void)serviceDetailConfigTableHeaderView:(ServiceDetailConfigTableHeaderView *)view didSelectBuyNum:(NSUInteger)num{
    NSString *totalStr = [NSString stringWithFormat:@"总计："];
    NSString *priceStr = [NSString stringWithFormat:@"%0.1f元",self.data.price * num];
    
    NSDictionary *totalAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                               NSForegroundColorAttributeName:[UIColor blackColor]};
    NSMutableAttributedString *totalAttStr = [[NSMutableAttributedString alloc]initWithString:totalStr attributes:totalAtt];
    
    UIColor *color = COLOR_PINK;
    NSDictionary *priceAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:21],
                               NSForegroundColorAttributeName:color};
    NSAttributedString *priceAttStr = [[NSAttributedString alloc]initWithString:priceStr attributes:priceAtt];
    
    [totalAttStr appendAttributedString:priceAttStr];
    
    [self.priceBtn setAttributedTitle:totalAttStr forState:UIControlStateNormal];
}

- (IBAction)statusAction:(UIButton *)sender {
    
    ServiceDetailConfigStoreItem *item = self.data.stores[self.selectedIndex];
    [self hideWithIsNeedToBuy:YES submitWithBuyNum:self.tableHeaderView.buyNum storeId:item.storeNo];
}

#pragma mark

- (void)show {
    
    if (!self.superview) {
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        if (!window.isKeyWindow) {
            [window becomeKeyWindow];
            [window makeKeyAndVisible];
        }
        [window addSubview:self];
    }
    self.hidden = NO;
    
}

- (void)hideWithIsNeedToBuy:(BOOL)isNeeToBuy submitWithBuyNum:(NSUInteger)buyNum storeId:(NSString *)storeId {
    self.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(serviceDetailConfigView:closeWithServiceId:channelId:isNeedToBuy:submitWithBuyNum:storeId:)]) {
        if (self.data.productId>0) {
            [self.delegate serviceDetailConfigView:self
                                closeWithServiceId:self.data.productId
                                         channelId:self.data.chid
                                       isNeedToBuy:isNeeToBuy
                                  submitWithBuyNum:buyNum
                                           storeId:storeId];
        }
    }
    
}

- (IBAction)hideBtnAction:(UIButton *)sender {
    [self hideWithIsNeedToBuy:NO submitWithBuyNum:0 storeId:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideWithIsNeedToBuy:NO submitWithBuyNum:0 storeId:nil];
}

@end

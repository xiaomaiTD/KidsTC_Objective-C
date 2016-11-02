//
//  ProductDetailTwoColumnCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnCell.h"
#import "NSArray+Category.h"

#import "ProductDetailTwoColumnTableViewBaseCell.h"
#import "ProductDetailTwoColumnTableViewTipCell.h"
#import "ProductDetailTwoColumnTableViewEmptyCell.h"
#import "ProductDetailTwoColumnTableViewConsultCell.h"

static NSString *const ID = @"ProductDetailTwoColumnTableViewBaseCell";

@interface ProductDetailTwoColumnCell ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,ProductDetailTwoColumnTableViewBaseCellDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, assign) BOOL webViewHasLoad;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ProductDetailTwoColumnTableViewTipCell *tipCell;
@property (nonatomic, strong) NSArray<NSArray<ProductDetailTwoColumnTableViewBaseCell *> *> *sections;

@end

@implementation ProductDetailTwoColumnCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self layoutIfNeeded];
    
    self.showType = ProductDetailTwoColumnShowTypeDetail;
    
    _webView.opaque = NO;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scalesPageToFit = YES;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.scrollEnabled = NO;
    _webView.scrollView.scrollsToTop = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.tableView.scrollsToTop = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 66.0f;
    self.tipCell = [self viewWithNib:@"ProductDetailTwoColumnTableViewTipCell"];
    [self setupSections];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat h = 0;
    switch (_showType) {
        case ProductDetailTwoColumnShowTypeDetail:
        {
            [self layoutIfNeeded];
            CGFloat webH = self.webView.scrollView.contentSize.height;
            if (_webViewHasOpen) {
                h = webH;
            }else{
                if (webH>SCREEN_HEIGHT) {
                    h = SCREEN_HEIGHT;
                }else{
                    h = webH * 0.8;
                }
            }
        }
            break;
        case ProductDetailTwoColumnShowTypeConsult:
        {
            [self layoutIfNeeded];
            h = self.tableView.contentSize.height;
        }
            break;
    }
    return CGSizeMake(size.width, h);
}

- (void)setShowType:(ProductDetailTwoColumnShowType)showType {
    _showType = showType;
    switch (showType) {
        case ProductDetailTwoColumnShowTypeDetail:
        {
            self.webView.hidden = NO;
            self.tableView.hidden = YES;
        }
            break;
        case ProductDetailTwoColumnShowTypeConsult:
        {
            self.webView.hidden = YES;
            self.tableView.hidden = NO;
        }
            break;
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    if (!_webViewHasLoad) {
        NSString *rulStr = data.detailUrl;
        rulStr = [rulStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:rulStr]];
        [self.webView loadRequest:request];
    }
    
    [self setupSections];
    
    [self.tableView reloadData];
    
    //if (!_selfHasload) {
        //if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
          //  [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeReloadWebViewOrConsult value:nil];
        //}
        //_selfHasload = YES;
    //}
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _webViewHasLoad = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)setupSections {
    
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    
    NSArray<ProductDetailConsultItem *> *consults = self.data.consults;
    
    _tipCell.count = self.data.advisoryCount;
    [section00 addObject:_tipCell];
    
    if (consults.count<1) {
        [section00 addObject:self.emptyCell];
    }else{
        [consults enumerateObjectsUsingBlock:^(ProductDetailConsultItem *obj, NSUInteger idx, BOOL *stop) {
            ProductDetailTwoColumnTableViewConsultCell *consultCell = self.consultCell;
            consultCell.item = obj;
            [section00 addObject:consultCell];
        }];
    }
    if (section00.count>0) [sections addObject:section00];
    
    self.sections = [NSArray arrayWithArray:sections];
}

- (ProductDetailTwoColumnTableViewEmptyCell *)emptyCell {
    return [self viewWithNib:@"ProductDetailTwoColumnTableViewEmptyCell"];
}

- (ProductDetailTwoColumnTableViewConsultCell *)consultCell {
    return [self viewWithNib:@"ProductDetailTwoColumnTableViewConsultCell"];
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == self.sections.count - 1)?0.001:12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (self.sections.count>section) {
        NSArray<ProductDetailTwoColumnTableViewBaseCell *> *rows = [self.sections objectAtIndexCheck:section];
        if (rows.count>row) {
            ProductDetailTwoColumnTableViewBaseCell *cell = [rows objectAtIndexCheck:row];
            cell.delegate = self;
            return cell;
        }
    }
    return [UITableViewCell new];
}

#pragma mark ProductDetailTwoColumnTableViewBaseCellDelegate

- (void)productDetailTwoColumnTableViewBaseCell:(ProductDetailTwoColumnTableViewBaseCell *)cell actionType:(ProductDetailTwoColumnTableViewBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeAddNewConsult value:nil];
    }
}



@end

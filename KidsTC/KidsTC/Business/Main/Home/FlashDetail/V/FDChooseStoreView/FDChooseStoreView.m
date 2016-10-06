//
//  FDChooseStoreView.m
//  KidsTC
//
//  Created by zhanping on 5/21/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FDChooseStoreView.h"
#import "FDChooseStoreCell.h"


@interface FDChooseButton : UIButton
@end
@implementation FDChooseButton
- (void)setHighlighted:(BOOL)highlighted{}
@end

@interface FDChooseStoreView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet FDChooseButton *selectedStoreBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet FDChooseButton *prePaidBtn;
@end

static NSString *FDChooseStoreCellReuseIndentifier = @"FDChooseStoreCellReuseIndentifier";
@implementation FDChooseStoreView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FDChooseStoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:FDChooseStoreCellReuseIndentifier];
    self.tableView.rowHeight = 70;
}
- (void)setData:(FDData *)data{
    _data = data;
    
    [self.prePaidBtn setTitle:[NSString stringWithFormat:@"预付：%0.0f元",data.prepaidPrice] forState:UIControlStateNormal];
    
    [self.tableView reloadData];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    self.hidden = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
}
- (IBAction)commitAction:(UIButton *)sender {
    if (self.commitBlock) {
        NSString *selectedStoreId = self.data.storeModels[self.selectedIndex].storeId;
        self.commitBlock(selectedStoreId);
    }
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.storeModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDChooseStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:FDChooseStoreCellReuseIndentifier];
    [cell configWithSotre:self.data.storeModels[indexPath.row] isSelected:self.selectedIndex==indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectedIndex = indexPath.row;
    
    NSString *selectedStoreName = self.data.storeModels[indexPath.row].storeName;
    NSString *selectedLabelString = [NSString stringWithFormat:@"   选择门店：%@",selectedStoreName];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    NSMutableAttributedString *selectedStoreAttributedString = [[NSMutableAttributedString alloc]initWithString:selectedLabelString
                                                                                                     attributes:attributes];
    NSRange range = [selectedStoreAttributedString.mutableString rangeOfString:selectedStoreName];
    [selectedStoreAttributedString addAttribute:NSForegroundColorAttributeName value:COLOR_PINK range:range];
    [self.selectedStoreBtn setAttributedTitle:selectedStoreAttributedString forState:UIControlStateNormal];
    [tableView reloadData];
    
}

@end

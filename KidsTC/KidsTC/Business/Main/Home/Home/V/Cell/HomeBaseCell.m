//
//  HomeBaseCell.m
//  KidsTC
//
//  Created by ling on 16/7/19.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeBaseCell.h"

@implementation HomeBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

@end

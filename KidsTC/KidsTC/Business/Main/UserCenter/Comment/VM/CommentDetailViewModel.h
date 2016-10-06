//
//  CommentDetailViewModel.h
//  KidsTC
//
//  Created by 钱烨 on 10/29/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//


#import "CommentDetailView.h"
#import "KTCCommentManager.h"

@interface CommentDetailViewModel : NSObject

@property (nonatomic, strong) CommentDetailModel *detailModel;

-(void)getMoreReplies;

- (instancetype)initWithView:(UIView *)view;

- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure;

@end

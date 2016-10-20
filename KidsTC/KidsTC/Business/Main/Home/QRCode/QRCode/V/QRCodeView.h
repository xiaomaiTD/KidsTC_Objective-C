//
//  QRCodeView.h
//  005-QRCodeDeom
//
//  Created by 詹平 on 2016/10/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    QRCodeViewActionTypeScanSuccess = 1
} QRCodeViewActionType;

@class QRCodeView;
@protocol QRCodeViewDelegate <NSObject>
- (void)qrCodeView:(QRCodeView *)view actionType:(QRCodeViewActionType)type value:(id)value;
@end

@interface QRCodeView : UIView
@property (nonatomic, weak) id<QRCodeViewDelegate> delegate;
- (void)startScan;
- (void)stopScan;
@end

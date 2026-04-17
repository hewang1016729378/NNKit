//
//  UIButton+Extensional.h
//  Menu
//
//  Created by wei.zhang on 16/3/23.
//  Copyright © 2016年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extensional)

/**
 使按钮失效3秒或者数秒，再恢复可点击状态。（防止操作太快，按钮被多次点击）
 
 ⚠️注意：不适合具有disable状态的按钮。
 */
- (void)disableContinueThreeSeconds;
- (void)disableWithDuration:(NSTimeInterval)fInterval;

/**
 缩放 按钮的响应范围

 @param size 宽值表示左右两边各缩放的值，高值表示上下两边各缩放的值。
 */
- (void)expandEventSize:(CGSize)size;

@end

//
//  UIButton+Extensional.m
//  Menu
//
//  Created by wei.zhang on 16/3/23.
//  Copyright © 2016年 zhangwei. All rights reserved.
//

#import "UIButton+Extensional.h"
#import <objc/runtime.h>

@implementation UIButton (Extensional)

static char expandEventSizeKey;

- (void)disableContinueThreeSeconds;
{
    [self disableWithDuration:3];
}

- (void)disableWithDuration:(NSTimeInterval)fInterval;
{
    __weak typeof(self) wSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        wSelf.enabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(fInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               wSelf.enabled = YES;
                           });
        });
    });
}

- (void)expandEventSize:(CGSize)size;
{
    //OBJC_EXPORT void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    //OBJC_EXPORT 打包lib时，用来说明该函数是暴露给外界调用的。
    //id object 表示关联者，是一个对象
    //id value 表示被关联者，可以理解这个value最后是关联到object上的
    //const void *key 被关联者也许有很多个，所以通过key可以找到指定的那个被关联者
    
    objc_setAssociatedObject(self, &expandEventSizeKey, NSStringFromCGSize(size), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark 增大按钮响应范围的相关方法
//获取设置的扩大size，来扩大button的rect
//当前只是设置了一个扩大的size，当然也可以设置4个扩大的size，上下左右，具体扩大多少对应button的四个边传入对应的size
- (CGRect)expandEventRect;
{
    NSString *expandEventSizeString = objc_getAssociatedObject(self, &expandEventSizeKey);
    
    if (expandEventSizeString)
    {
        CGSize expandEventSize = CGSizeFromString(expandEventSizeString);
        return CGRectMake(self.bounds.origin.x - expandEventSize.width,
                          self.bounds.origin.y - expandEventSize.height,
                          self.bounds.size.width + expandEventSize.width*2,
                          self.bounds.size.height + expandEventSize.height*2);
    }
    else
    {
        return self.bounds;
    }
}

//响应用户的点击事件
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;
{
    CGRect buttonEventRect = [self expandEventRect];
    if (CGRectEqualToRect(buttonEventRect, self.bounds))
    {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(buttonEventRect, point) ? YES : NO;
}

@end

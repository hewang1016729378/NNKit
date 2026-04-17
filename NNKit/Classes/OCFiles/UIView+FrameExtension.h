//
//  FrameExtension.h
//  NNAcc
//
//  Created by ly on 2021/12/7.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
- (UIViewController *)getViewController;
@end

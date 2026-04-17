//
//  UIImage+stretchable.m
//  NNIM
//
//  Created by Leigod on 2022/8/6.
//

#import "UIImage+stretchable.h"

@implementation UIImage (stretchable)
/**
 *  返回一张可以随意拉伸不变形的图片
 *  @param name 图片名字
 */
+(UIImage *)stretchableImageWithImgae:(NSString *)name{
 
    UIImage *normal = [UIImage imageNamed:name];
//    CGFloat w = normal.size.width * 0.1;
//    CGFloat h = normal.size.height * 0.1;
    return [normal stretchableImageWithLeftCapWidth:10 topCapHeight:10];
}
/**
 绘制图片
 
 @param color 背景色
 @param size 大小
 @param text 文字
 @param textFont 字体设置
 @param textColor 字体颜色
 @param isCircular 是否圆形
 @return 图片
 */
+(UIImage *)zd_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                            textFont:(UIFont *)textFont
                            textColor:(UIColor *)textColor
                      circular:(BOOL)isCircular
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    // color
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    // text
    NSMutableDictionary<NSAttributedStringKey,id> *textAttributes = [NSMutableDictionary new];
    [textAttributes setValue:textColor forKey:NSForegroundColorAttributeName];
    [textAttributes setValue:textFont forKey:NSFontAttributeName];
    
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

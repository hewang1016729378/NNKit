//
//  UIImage+stretchable.h
//  NNIM
//
//  Created by Leigod on 2022/8/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (stretchable)
+(UIImage *)stretchableImageWithImgae:(NSString *)name;
+(UIImage *)zd_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                            textFont:(UIFont *)textFont
                            textColor:(UIColor *)textColor
                      circular:(BOOL)isCircular;
@end

NS_ASSUME_NONNULL_END

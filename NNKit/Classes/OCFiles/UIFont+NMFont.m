//
//  UIFont+NMFont.m
//  NNIM
//
//  Created by Leigod on 2022/7/22.
//

#import "UIFont+NMFont.h"

@implementation UIFont (NMFont)
+ (UIFont *)PingFangSCRegular:(CGFloat)size{
    
    return  [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}
+ (UIFont *)PingFangSCMedium:(CGFloat)size{
    
    return  [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}
+ (UIFont *)HarmonyOSBold:(CGFloat)size{
    return  [self getFont:@"HarmonyOS Sans Bold" size:size];
}
+ (UIFont *)PingFangSemiBold:(CGFloat)size{
    return  [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}
+(UIFont *)getFont:(NSString *)fontName size:(CGFloat)size{
    if ([UIFont fontWithName:fontName size:size] == nil){
        return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    }
    return [UIFont fontWithName:fontName size:size];
}

@end

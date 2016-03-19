//
//  UIImage+Color.m
//  CurrentAddress
//
//  Created by Efim Polevoi on 17/03/2016.
//
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

//
//  NSString+Extent.m
//  MyWeiBo
//
//  Created by simplysky on 16/3/6.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import "NSString+Extent.h"

@implementation NSString (Extent)

-(CGFloat) heightWithText:(NSString *) text font:(UIFont *) font width:(CGFloat) width{
    NSDictionary * attributes = @{NSFontAttributeName : font};
    
    CGSize contentSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:attributes
                                            context:nil].size;
    
    return contentSize.height ;
}

@end

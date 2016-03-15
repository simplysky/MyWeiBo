//
//  NSString+Extent.h
//  MyWeiBo
//
//  Created by simplysky on 16/3/6.
//  Copyright © 2016年 simplysky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extent)

-(CGFloat) heightWithText:(NSString *) text font:(UIFont *) font width:(CGFloat) width;

@end

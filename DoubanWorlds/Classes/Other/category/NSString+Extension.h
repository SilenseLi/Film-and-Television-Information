//
//  NSString+Extension.h
//  
//
//  Created by apple on 14-5-30.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  计算属性字符文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *  @param lineSpacing 行间距
 *
 *  @return 占用的宽高
 */
- (CGSize)attrStrSizeWithFont:(UIFont *)font andmaxSize:(CGSize)maxSize lineSpacing:(CGFloat)lineSpacing;
/**
 *  检测一个是否唯恐
 *
 *  @param object 输入
 *
 *  @return 为空YES,不为空NO
 */
+ (BOOL)checkConvertNull:(NSString *)object;

/**
 *  匹配所有网址
 *
 *  @return 网址数组
 */
- (NSArray *)arrayOfAllMatches;

/**
 *  含有URL的属性字符串
 *
 *  @param LineSpacing 间距
 *
 *  @return 含有URL的属性字符串
 */
-(NSMutableAttributedString *)linkAttriWithLineSpacing:(CGFloat)LineSpacing urlColor:(UIColor *)urlColor;


@end

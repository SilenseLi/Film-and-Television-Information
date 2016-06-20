//
//  NSString+Extension.m
//
//
//  Created by apple on 14-5-30.
//
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

- (CGSize)attrStrSizeWithFont:(UIFont *)font andmaxSize:(CGSize)maxSize lineSpacing:(CGFloat)lineSpacing{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    NSDictionary *dict = @{NSFontAttributeName: font,
                           NSParagraphStyleAttributeName: paragraphStyle};
    CGSize sizeToFit = [self boundingRectWithSize:maxSize // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dict        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit;
}

-(NSArray *)arrayOfAllMatches{
    NSError *error;
    NSString *regulaStr = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *matches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    return matches;
}

-(NSMutableAttributedString *)linkAttriWithLineSpacing:(CGFloat)LineSpacing urlColor:(UIColor *)urlColor{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LineSpacing];
    //属性字典
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    
    NSArray *arrayOfAllMatches = [self arrayOfAllMatches];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [self substringWithRange:match.range];
        [attributedString addAttribute:NSForegroundColorAttributeName value:urlColor range:match.range];
        NSLog(@"substringForMatch  =%@",substringForMatch);
    }
    return attributedString;
}

+ (BOOL)checkConvertNull:(NSString *)object{
    if ([object isEqual:[NSNull null]] || [object isKindOfClass:[NSNull class]] ||object==nil || [object isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}

@end

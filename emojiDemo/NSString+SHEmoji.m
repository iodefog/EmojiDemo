//
//  NSString+SHEmoji.m
//  emojiDemo
//
//  Created by LHL on 16/4/22.
//
//

#import "NSString+SHEmoji.h"

#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);


@implementation NSString (SHEmoji)

#pragma mark - UTF16 to Emoji

+ (NSInteger)utf16StrToUncode:(NSString *)utfStr{
    NSString *newUtfStr = [utfStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    newUtfStr = [newUtfStr stringByReplacingOccurrencesOfString:@"[emoji:" withString:@""];
    newUtfStr = [newUtfStr stringByReplacingOccurrencesOfString:@"]" withString:@""];

    if (newUtfStr.length <= 4) {
        return  MULITTHREEBYTEUTF16TOUNICODE(0, strtol([newUtfStr UTF8String], 0, 16));
    }else if((newUtfStr.length > 4) && (newUtfStr.length <= 8)){
        NSString *firstStr = [newUtfStr substringToIndex:(newUtfStr.length-4)];
        NSString *lastStr = [newUtfStr substringFromIndex:(newUtfStr.length-4)];
        return  MULITTHREEBYTEUTF16TOUNICODE(strtol([firstStr UTF8String], 0, 16), strtol([lastStr UTF8String], 0, 16));
    }
    return 0;
}

+ (NSString *)utf16StrToUncodeStr:(NSString *)utfStr{
    NSString *result = nil;
    if ([self utf16StrToUncode:utfStr] != 0) {
      result = [NSString stringWithFormat:@"%1X",[self utf16StrToUncode:utfStr]];
    }
    return result;
}

+ (NSString *)utf16StrToEmoji:(NSString *)utfStr{
    NSString *result = nil;
    if ([self utf16StrToUncode:utfStr] != 0) {
        result = [self emojiWithCode:[self utf16StrToUncode:utfStr]];
    }
    return result;
}

+ (NSString *)emojiWithCode:(int)code {
    int sym = EMOJI_CODE_TO_SYMBOL(code);
    return [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringReplaceUtf16ToEmoji:(NSString *)searchText{
    NSString *resultStr = [NSString stringWithString:searchText];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[emoji:(.*?)]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:resultStr options:0 range:NSMakeRange(0, [resultStr length])];
    if (result) {
        NSString *utf16Str = [resultStr substringWithRange:result.range];
        NSString *emoji = [NSString utf16StrToEmoji:utf16Str];
        if (emoji) {
            resultStr = [resultStr stringByReplacingCharactersInRange:result.range withString:emoji];
            NSLog(@"%@", resultStr);
            return [NSString stringReplaceUtf16ToEmoji:resultStr];
        }
    }
    
    return resultStr;
}

#pragma mark - UTF8 to emoji

+ (NSInteger)utf8StrToUncode:(NSString *)utfStr{
    NSString *newUtfStr = [utfStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    newUtfStr = [newUtfStr stringByReplacingOccurrencesOfString:@"[emoji:" withString:@""];
    newUtfStr = [newUtfStr stringByReplacingOccurrencesOfString:@"]" withString:@""];
    
    NSMutableString *resultStr = [NSMutableString string];
    
    if (utfStr.length <= 8) {
        int loop = utfStr.length%2 ? utfStr.length/2+1 : utfStr.length/2;
        for (int i = loop-1 ; i >= 0 ; i--) {
            NSString *str = nil;
            if ((utfStr.length%2 == 1) && (i == 0)) {
                str = [utfStr substringWithRange:NSMakeRange(0, 1)];
            }else {
                str = [utfStr substringWithRange:NSMakeRange(utfStr.length - (loop - i)*2, 2)];
            }
//            [resultStr insertString:[NSString stringWithFormat:@"\x%@", str] atIndex:0];
        }
    }
    NSLog(@"%@", resultStr);

    
    if (newUtfStr.length <= 4) {
        return  MULITTHREEBYTEUTF16TOUNICODE(0, strtol([newUtfStr UTF8String], 0, 16));
    }else if((newUtfStr.length > 4) && (newUtfStr.length <= 8)){
        NSString *firstStr = [newUtfStr substringToIndex:(newUtfStr.length-4)];
        NSString *lastStr = [newUtfStr substringFromIndex:(newUtfStr.length-4)];
        return  MULITTHREEBYTEUTF16TOUNICODE(strtol([firstStr UTF8String], 0, 16), strtol([lastStr UTF8String], 0, 16));
    }
    return 0;
}

+ (NSString *)utf8StrToUncodeStr:(NSString *)utfStr{
    NSString *result = nil;
    if ([self utf16StrToUncode:utfStr] != 0) {
        result = [NSString stringWithFormat:@"%1X",[self utf16StrToUncode:utfStr]];
    }
    return result;
}

+ (NSString *)utf8StrToEmoji:(NSString *)utfStr{
    NSString *result = nil;
    if ([self utf8StrToUncode:utfStr] != 0) {
        result = [self emojiWithCode:[self utf8StrToUncode:utfStr]];
    }
    return result;
}

//+ (NSString *)utf8StrToEmoji:(NSString *)utfStr{
//    
//    NSString *newUtfStr = [utfStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//    newUtfStr = [newUtfStr stringByReplacingOccurrencesOfString:@"[emoji:" withString:@""];
//    newUtfStr = [newUtfStr stringByReplacingOccurrencesOfString:@"]" withString:@""];
//
//    NSMutableString *resultStr = [NSMutableString string];
//
//    if (utfStr.length <= 8) {
//        int loop = utfStr.length%2 ? utfStr.length/2+1 : utfStr.length/2;
//        for (int i = loop-1 ; i >= 0 ; i--) {
//            NSString *str = nil;
//            if ((utfStr.length%2 == 1) && (i == 0)) {
//                str = [utfStr substringWithRange:NSMakeRange(0, 1)];
//            }else {
//                str = [utfStr substringWithRange:NSMakeRange(utfStr.length - (loop - i)*2, 2)];
//            }
//            [resultStr insertString:[NSString stringWithFormat:@"\x%@", str] atIndex:0];
//        }
//    }
//    NSLog(@"%@", resultStr);
//    return resultStr;
//}

+ (NSString *)stringReplaceUtf8ToEmoji:(NSString *)searchText{
    NSString *resultStr = [NSString stringWithString:searchText];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[emoji:(.*?)]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:resultStr options:0 range:NSMakeRange(0, [resultStr length])];
    if (result) {
        NSString *utf16Str = [resultStr substringWithRange:result.range];
        NSString *emoji = [NSString utf8StrToEmoji:utf16Str];
        if (emoji) {
            resultStr = [resultStr stringByReplacingCharactersInRange:result.range withString:emoji];
            NSLog(@"%@", resultStr);
            [NSString stringReplaceUtf8ToEmoji:resultStr];
        }
    }
    
    return resultStr;
}

@end

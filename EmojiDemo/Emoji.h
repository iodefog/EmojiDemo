//
//  Emoji.h
//  EmojiDemo
//
//  Created by LHL on 16/4/22.
//  Copyright © 2016年 LHL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAKE_Q(x) @#x
#define MAKE_EM(x,y) MAKE_Q(x##y)
#define MAKE_EMOJI(x) MAKE_EM(\U000,x)
#define EMOJI_METHOD(x,y) + (NSString *)x { return MAKE_EMOJI(y); } //method implementions at .m file
#define EMOJI_HMETHOD(x) + (NSString *)x;   //method define at .h file
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);


@interface Emoji : NSObject

+ (NSString *)emojiWithCode:(int)code;
+ (NSArray *)allEmoji;

@end

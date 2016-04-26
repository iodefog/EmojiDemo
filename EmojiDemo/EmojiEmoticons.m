//
//  EmojiEmoticons.m
//  EmojiDemo
//
//  Created by LHL on 16/4/22.
//  Copyright © 2016年 LHL. All rights reserved.
//

#import "EmojiEmoticons.h"

@implementation EmojiEmoticons


+ (NSArray *)allEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            [array addObject:[Emoji emojiWithCode:i]];
        }
    }
    return array;
}

EMOJI_METHOD(grinningFace,1F600);

@end

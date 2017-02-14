//
//  CViewController.m
//  emojiDemo
//
//  Created by f fsh on 13-3-10.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CViewController.h"
#import "NSString+SHEmoji.h"

@implementation CViewController
@synthesize viewtxt;
@synthesize lbtext;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSString *firstStr = [@"125678" substringToIndex:(@"125678".length-4)];
//    NSString *lastStr = [@"145678" substringFromIndex:(@"145678".length-4)];
//
//    NSString *ss =  [NSString utf16StrToEmoji:@"d83dde04"];
    
    NSLog(@"%@", [NSString utf16StrToEmoji:@"d83ddd2"]);
    NSLog(@"%@", [NSString utf16StrToEmoji:@"d83cdfec"]);
    NSLog(@"%@", [NSString utf16StrToEmoji:@"d83cdfe9"]);
    NSLog(@"%@", [NSString utf16StrToEmoji:@"d83ddc2e"]);

    NSString *testStr = @"[emoji:d83dde1d][emoji:d83dde1d][emoji:d83dde1d][emoji:d83dde1c][emoji:d83dde1c][emoji:d83dde1a][emoji:d83dde0d][emoji:d83dde0d][emoji:d83dde1e][emoji:d83dde23][emoji:d83dde18][emoji:d83dde1e][emoji:d83dde1e][emoji:d83ddc2e][emoji:d83ddc2e][emoji:d83ddc2e][emoji:d83cdf85][emoji:d83cdf85][emoji:d83cdf85][emoji:d83cdf90][emoji:d83cdfe9][emoji:d83cdfe4][emoji:d83cdfec][emoji:d83cdfec]#⃣8⃣[emoji:d83ddd23]";
    
    NSString* xxx= [NSString stringReplaceUtf16ToEmoji:testStr];
    
    NSLog(@"%@",xxx);
    [self.viewtxt setText:xxx];
}


@end

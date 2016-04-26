//
//  CViewController.m
//  emojiDemo
//
//  Created by f fsh on 13-3-10.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CViewController.h"
#import "Emoji.h"
#import "EmojiEmoticons.h"
#import "NSString+SHEmoji.h"

@implementation CViewController
@synthesize tv;
@synthesize viewtxt;
@synthesize emojiView;
@synthesize scrollview;
@synthesize imgview;
@synthesize btnOK;
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
	// Do any additional setup after loading the view, typically from a nib.
    viewtxt.delegate = self;
    
   ;
    [tv setText: [NSString utf8StrToEmoji:@"f09f9884"]];

    
    NSString *firstStr = [@"125678" substringToIndex:(@"125678".length-4)];
    NSString *lastStr = [@"145678" substringFromIndex:(@"145678".length-4)];

    NSString *ss =  [NSString utf16StrToEmoji:@"d83dde04"];
    
//    NSLog(@"%@", EMOJI_CODE_TO_SYMBOL([NSString utf16StrToUncode:@"d83dde04"]));
//    NSLog(@"%@", MAKE_EMOJI([NSString utf16StrToUncode:@"d83dde04"]));
    
    [tv setText:ss];
    
    NSLog(@"%@", [NSString utf16StrToEmoji:@"d83ddd2"]);
    NSLog(@"%@", [NSString utf16StrToEmoji:@"d83cdfec"]);
    NSLog(@"%@", [NSString utf16StrToEmoji:@"d83cdfe9"]);
    NSLog(@"%@", [NSString utf16StrToEmoji:@"d83ddc2e"]);

    NSString *testStr = @"[emoji:d83dde1d][emoji:d83dde1d][emoji:d83dde1d][emoji:d83dde1c][emoji:d83dde1c][emoji:d83dde1a][emoji:d83dde0d][emoji:d83dde0d][emoji:d83dde1e][emoji:d83dde23][emoji:d83dde18][emoji:d83dde1e][emoji:d83dde1e][emoji:d83ddc2e][emoji:d83ddc2e][emoji:d83ddc2e][emoji:d83cdf85][emoji:d83cdf85][emoji:d83cdf85][emoji:d83cdf90][emoji:d83cdfe9][emoji:d83cdfe4][emoji:d83cdfec][emoji:d83cdfec]#⃣8⃣[emoji:d83ddd23]";
    
    NSString* xxx= [NSString stringReplaceUtf16ToEmoji:testStr];
    
    NSLog(@"%@",xxx);
}



- (void)viewDidUnload
{
    [self setBtnOK:nil];
    [self setLbtext:nil];
    [self setTv:nil];
    [self setViewtxt:nil];
    [self setEmojiView:nil];
    [self setScrollview:nil];
    [self setImgview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [btnOK release];
    [lbtext release];
    [tv release];
    [viewtxt release];
    [emojiView release];
    [scrollview release];
    [imgview release];
    [super dealloc];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *hexstr = @"";

    for (int i=0;i< [text length];i++)
    {
        hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%1X ",[text characterAtIndex:i]]];
    }
    NSLog(@"UTF16 [%@]",hexstr);
    
    hexstr = @"";
    
    int slen = strlen([text UTF8String]);
    
    for (int i = 0; i < slen; i++) 
    {
        //fffffff0 去除前面六个F & 0xFF 
        hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%X ",[text UTF8String][i] & 0xFF ]];
    }
    NSLog(@"UTF8 [%@]",hexstr);
    
    hexstr = @"";
    
    if ([text length] >= 2) {
        
        for (int i = 0; i < [text length] / 2 && ([text length] % 2 == 0) ; i++) 
        {
            // three bytes
            if (([text characterAtIndex:i*2] & 0xFF00) == 0 ) {
                hexstr = [hexstr stringByAppendingFormat:@"Ox%1X 0x%1X",[text characterAtIndex:i*2],[text characterAtIndex:i*2+1]];
            }
            else
            {// four bytes  
                hexstr = [hexstr stringByAppendingFormat:@"U+%1X ",MULITTHREEBYTEUTF16TOUNICODE([text characterAtIndex:i*2],[text characterAtIndex:i*2+1])];    
            }
            
        }
        NSLog(@"(unicode) [%@]",hexstr);
    }
    else
    {
        NSLog(@"(unicode) U+%1X",[text characterAtIndex:0]);
    }
    
    return YES;
}


-(void)displayEmoji
{
    NSString *emojistr = @"";
    int ic = [[Emoji allEmoji] count];
    for (int i=0 ;i < ic ;i++)
    {
        emojistr = [emojistr stringByAppendingFormat:@"%@",[[Emoji allEmoji]objectAtIndex:i]];
    }
    
    [emojiView setText:emojistr];
}

//loop 
-(NSString *)toBinary:(NSInteger)input
{
    if (input == 1 || input == 0) {
        return [NSString stringWithFormat:@"%d", input];
    }
    else {
        return [NSString stringWithFormat:@"%@%d", [self toBinary:input / 2], input % 2];
    }
} 

- (IBAction)onbtnokclick:(id)sender {
    
    [self displayEmoji];

    
    NSString * ss = [NSString stringWithFormat:@"ni ma bi%@fd", [Emoji emojiWithCode:0x1F601]];
    //lbtext.text = @"xx\ue415";
    
    ss = @"I Love Emoji \ue415";//softbank
    
    NSLog(@"byte ss =%i",[ss lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]);
    
    char c ;
    
    const char * cstr = [ss cStringUsingEncoding:NSUnicodeStringEncoding];
    NSLog(@"cstr = %s",cstr);
    NSLog(@"ss length = %i",[ss length]);
    
    //strtol
    
    for (int i = 0;i< [ss length];i++)
    {
        c = [ss characterAtIndex:i];
        //NSLog(@"C value = %x",c);
    }
    
    
    ss = @"I Love Emoji \xf0\x9f\x98\x84"; //UFT8
//    ss = @"I Love Emoji 0x1F604"; //UFT16
    [tv setText:ss];

    NSLog(@"%s", [@"d83dde04" cStringUsingEncoding:NSUTF16LittleEndianStringEncoding]);

    NSLog(@"ss length = %i",[ss length]);
    ss = [NSString stringWithFormat:@"%1x",65];//10 to 16
    NSLog(@"ss %@",ss );
    ss = [NSString stringWithFormat:@"%d",strtol("F0", 0, 16)];   //16 to 10
    NSLog(@"ss %@",ss );
    ss = [NSString stringWithFormat:@"%d",strtol([@"f0" UTF8String], 0, 16)];
    NSLog(@"ss %@",ss );
    
    int sym = -2120704016;
    
    ss = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];

    NSLog(@"ss %@",ss );

    ss = [self toBinary:65];
    NSLog(@"ss %@",ss );

    ss = @"\U0001F604";
    

    //ss = 0xD950 0xDF21;
//    ss = @"d83dde04";
    ss=@"\x32";
    ss = @"\xf0\x9f\x98\x84";
    //ss = @"\x31\u20e3";
    //ss = @"\u00ae";
    
    NSLog(@"%i",[ss length]);
    NSLog(@"%1X",[ss characterAtIndex:0] ^ 0xD800);
    NSLog(@"%1X",[ss characterAtIndex:1] ^ 0xDC00);
    
    NSLog(@"%1X",MULITTHREEBYTEUTF16TOUNICODE(([ss characterAtIndex:0] ^ 0xD800),([ss characterAtIndex:1] ^ 0xDC00)));
    
    NSLog(@"%1X",MULITTHREEBYTEUTF16TOUNICODE([ss characterAtIndex:0],[ss characterAtIndex:1]));
//d83dde04
    NSLog(@"%1X",MULITTHREEBYTEUTF16TOUNICODE(0xd83d,0xde04));

    
    //NSLog(@"%1X",ATEST);
    [viewtxt setText:ss];
    
    //[[Emoji allEmoji]objectAtIndex:0]
    lbtext.text =  [EmojiEmoticons smilingFaceWithOpenMouthAndSmilingEyes];//UTF16
}

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[[NSScanner alloc] initWithString:hexCharStr] autorelease];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString; 
    
    
}

//普通字符串转换为十六进制的。

+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}




@end

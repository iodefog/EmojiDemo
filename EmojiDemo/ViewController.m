//
//  ViewController.m
//  EmojiDemo
//
//  Created by LHL on 16/4/22.
//  Copyright © 2016年 LHL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
#define UNICODETOUTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&3FF) | 0xDC00))

#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000

#define MAKE_Q(x) @#x
#define MAKE_EM(x,y) MAKE_Q(x##y)
#define MAKE_EMOJI(x) MAKE_EM(\U000,x)
#define EMOJI_METHOD(x,y) + (NSString *)x { return MAKE_EMOJI(y); } //method implementions at .m file
#define EMOJI_HMETHOD(x) + (NSString *)x;   //method define at .h file
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

   self.textLabel.text = @"\ud83d\ude04";

}

+ (NSString *)emojiWithCode:(int)code {
    int sym = EMOJI_CODE_TO_SYMBOL(code);
    return [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
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
    
    long slen = strlen([text UTF8String]);
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

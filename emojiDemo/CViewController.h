//
//  CViewController.h
//  emojiDemo
//
//  Created by f fsh on 13-3-10.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000
#define UNICODETOUTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&3FF) | 0xDC00))

//#define ATEST ((((0x3D << 2) | (0x204 >> 8)) << 8) | (0x204 & 0xFF)) + 0x10000

@interface CViewController : UIViewController <UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UIButton *btnOK;
@property (retain, nonatomic) IBOutlet UILabel *lbtext;
- (IBAction)onbtnokclick:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *tv;
@property (retain, nonatomic) IBOutlet UITextView *viewtxt;
@property (retain, nonatomic) IBOutlet UITextView *emojiView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UIImageView *imgview;

@end

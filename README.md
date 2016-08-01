# EmojiDemo

Utf16字符串转变成Emoji表情，如@"d83dde04" to 😄   


/**
 *  utf16字符串进行Unicode编码 例如@"d83dde04" to 1F604
 *
 *  @param utfStr 需要转换的 utf16 字符串
 *
 *  @return 相对应的Unicode编码
 */
+ (NSInteger)utf16StrToUncode:(NSString *)utfStr;



/**
 *  utf16字符串进行Unicode编码 例如@"d83dde04" to @"1F604"
 *
 *  @param utfStr 需要转换的 utf16 字符串
 *
 *  @return 相对应的Unicode编码字符串
 */
+ (NSString *)utf16StrToUncodeStr:(NSString *)utfStr;


/**
 *  utf16字符串进行Unicode编码然后转换成Emoji表情 [emoji:d83dde1d]
 *
 *  @param utfStr 需要转换的 utf16 字符串
 *
 *  @return 相对应的emoji表情
 */
+ (NSString *)utf16StrToEmoji:(NSString *)utfStr;


/**
 *  转换字符串中utf16表情为emoji表情 [emoji:d83dde1d]
 *
 *  @param searchText 需要替换的字符串
 *
 *  @return 返回替换后的emoji字符串
 */
+ (NSString *)stringReplaceUtf16ToEmoji:(NSString *)searchText;


//-----------------------------

/**
 *  utf8字符串进行Unicode编码 例如@"d83dde04" to 1F604
 *
 *  @param utfStr 需要转换的 utf8 字符串
 *
 *  @return 相对应的Unicode编码
 */
+ (NSInteger)utf8StrToUncode:(NSString *)utfStr;



/**
 *  utf8字符串进行Unicode编码 例如@"d83dde04" to @"1F604"
 *
 *  @param utfStr 需要转换的 utf8 字符串
 *
 *  @return 相对应的Unicode编码字符串
 */
+ (NSString *)utf8StrToUncodeStr:(NSString *)utfStr;


/**
 *  utf8字符串进行Unicode编码然后转换成Emoji表情 [emoji:d83dde1d]
 *
 *  @param utfStr 需要转换的 utf8 字符串
 *
 *  @return 相对应的emoji表情
 */
+ (NSString *)utf8StrToEmoji:(NSString *)utfStr;


/**
 *  转换字符串中utf8表情为emoji表情 [emoji:d83dde1d]
 *
 *  @param searchText 需要替换的字符串
 *
 *  @return 返回替换后的emoji字符串
 */
+ (NSString *)stringReplaceUtf8ToEmoji:(NSString *)searchText;


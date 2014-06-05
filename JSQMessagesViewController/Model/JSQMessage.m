//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessage.h"

@implementation JSQMessage

#pragma mark - Initialization

+ (instancetype)messageWithSourceText:(NSString *)sourceText
                           sourceLang:(NSString *)sourceLang
                           targetText:(NSString *)targetText
                               sender:(NSString *)sender
                           attributes:(NSDictionary *)attributeDic
{
    return [[JSQMessage alloc] initWithSourceText:sourceText sourceLang:sourceLang targetText:targetText sender:sender date:[NSDate date] attributes:attributeDic];
}

- (instancetype)initWithSourceText:(NSString *)sourceText
                        sourceLang:(NSString *)sourceLang
                        targetText:(NSString *)targetText
                            sender:(NSString *)sender
                              date:(NSDate *)date
                        attributes:(NSDictionary *)attributeDic
{
    NSAssert(sourceText, @"ERROR: sourceText must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(targetText, @"ERROR: targetText must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(sender, @"ERROR: sender must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(date, @"ERROR: date must not be nil: %s", __PRETTY_FUNCTION__);
    
    self = [super init];
    if (self) {
        _text = [self combineWithSourceText:sourceText targetText:targetText attributes:attributeDic];
        _sender = sender;
        _date = date;
        _sourceText = sourceText;
        _sourceLang = sourceLang;
        _targetText = targetText;
        _attributeDic = attributeDic;
    }
    return self;
}

- (instancetype)initWithSourceText:(NSString *)sourceText
                        sourceLang:(NSString *)sourceLang
                        targetText:(NSString *)targetText
                            sender:(NSString *)sender
                              date:(NSDate *)date
                        attributes:(NSDictionary *)attributeDic
                       optionalDic:(NSDictionary*)optionalDic
{
    NSAssert(sourceText, @"ERROR: sourceText must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(targetText, @"ERROR: targetText must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(sender, @"ERROR: sender must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(date, @"ERROR: date must not be nil: %s", __PRETTY_FUNCTION__);
    
    self = [super init];
    if (self) {
        _text = [self combineWithSourceText:sourceText targetText:targetText attributes:attributeDic];
        _sender = sender;
        _date = date;
        _sourceText = sourceText;
        _sourceLang = sourceLang;
        _targetText = targetText;
        _attributeDic = attributeDic;
        _optionalDic = optionalDic;
    }
    return self;
}

- (void)dealloc
{
    _text = nil;
    _sender = nil;
    _date = nil;
    _sourceText = nil;
    _sourceLang = nil;
    _targetText = nil;
    _attributeDic = nil;
    _optionalDic = nil;
}

#pragma mark - JSQMessage

- (BOOL)isEqualToMessage:(JSQMessage *)aMessage
{
    return [self.text isEqualToAttributedString:aMessage.text]
            && [self.sender isEqualToString:aMessage.sender]
            && ([self.date compare:aMessage.date] == NSOrderedSame);
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToMessage:(JSQMessage *)object];
}

- (NSUInteger)hash
{
    return [self.text hash] ^ [self.sender hash] ^ [self.date hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@>[ %@, %@\n %@ ]", [self class], self.sender, self.date, self.text];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _text = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(text))];
        _sender = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sender))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
        _sourceText = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sourceText))];
        _sourceLang = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sourceLang))];
        _targetText = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(targetText))];
        _attributeDic = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(attributeDic))];
        _optionalDic = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(optionalDic))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeObject:self.sender forKey:NSStringFromSelector(@selector(sender))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
    [aCoder encodeObject:self.sourceText forKey:NSStringFromSelector(@selector(sourceText))];
    [aCoder encodeObject:self.sourceLang forKey:NSStringFromSelector(@selector(sourceLang))];
    [aCoder encodeObject:self.targetText forKey:NSStringFromSelector(@selector(targetText))];
    [aCoder encodeObject:self.attributeDic forKey:NSStringFromSelector(@selector(attributeDic))];
    [aCoder encodeObject:self.optionalDic forKey:NSStringFromSelector(@selector(optionalDic))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithSourceText:[self.sourceText copy] sourceLang:[self.sourceLang copy] targetText:[self.targetText copy] sender:[self.sender copy] date:[self.date copy] attributes:[self.attributeDic copy] optionalDic:[self.optionalDic copy]];
}

-(NSAttributedString*)combineWithSourceText:(NSString*)sourceText targetText:(NSString*)targetText attributes:(NSDictionary*)attributeDic
{
    NSString* combinedStr;
    if (targetText == nil) {
        combinedStr = [sourceText copy];
    }
    else {
        combinedStr = [NSString stringWithFormat:@"%@\n%@", sourceText, targetText];
    }
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:combinedStr];
    
    NSRange sourceTange = NSMakeRange(0, [sourceText length]);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:attributeDic[@"sourceText"][NSForegroundColorAttributeName] range:sourceTange];
    [attributedStr addAttribute:NSFontAttributeName value:attributeDic[@"sourceText"][NSFontAttributeName] range:sourceTange];
    
    NSRange targetRange = NSMakeRange([sourceText length]+1, [targetText length]);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:attributeDic[@"targetText"][NSForegroundColorAttributeName] range:targetRange];
    [attributedStr addAttribute:NSFontAttributeName value:attributeDic[@"targetText"][NSFontAttributeName] range:targetRange];
//    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, [combinedStr length])];
    return attributedStr;
}

@end

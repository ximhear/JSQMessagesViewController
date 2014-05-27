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
                           targetText:(NSString *)targetText
                               sender:(NSString *)sender
                           attributes:(NSDictionary *)attributeDic
{
    return [[JSQMessage alloc] initWithSourceText:sourceText targetText:targetText sender:sender date:[NSDate date] attributes:attributeDic];
}

- (instancetype)initWithSourceText:(NSString *)sourceText
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
    }
    return self;
}

- (instancetype)initWithText:(NSAttributedString *)text
                            sender:(NSString *)sender
                              date:(NSDate *)date
{
    NSAssert(text, @"ERROR: text must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(sender, @"ERROR: sender must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(date, @"ERROR: date must not be nil: %s", __PRETTY_FUNCTION__);
    
    self = [super init];
    if (self) {
        _text = text;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (void)dealloc
{
    _text = nil;
    _sender = nil;
    _date = nil;
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
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeObject:self.sender forKey:NSStringFromSelector(@selector(sender))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithText:[self.text copy]
                                                    sender:[self.sender copy]
                                                      date:[self.date copy]];
}

-(NSAttributedString*)combineWithSourceText:(NSString*)sourceText targetText:(NSString*)targetText attributes:(NSDictionary*)attributeDic
{
    NSString* combinedStr = [NSString stringWithFormat:@"%@\n%@", sourceText, targetText];
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

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

+ (instancetype)messageWithText:(NSString *)text
                         sender:(NSString *)sender
{
    return [[JSQMessage alloc] initWithText:text sourceText:text targetText:text sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithText:(NSString *)text
                     sourceText:(NSString *)sourceText
                     targetText:(NSString *)targetText
                         sender:(NSString *)sender
{
    return [[JSQMessage alloc] initWithText:text sourceText:sourceText targetText:targetText sender:sender date:[NSDate date]];
}

- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                        date:(NSDate *)date
{
    return [self initWithText:text sourceText:text targetText:text sender:sender date:date];
}

- (instancetype)initWithText:(NSString *)text
                  sourceText:(NSString *)sourceText
                  targetText:(NSString *)targetText
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
        _sourceText = sourceText;
        _targetText = targetText;
    }
    return self;
}

- (void)dealloc
{
    _text = nil;
    _sender = nil;
    _date = nil;
    _sourceText = nil;
    _targetText = nil;
}

#pragma mark - JSQMessage

- (BOOL)isEqualToMessage:(JSQMessage *)aMessage
{
    return [self.text isEqualToString:aMessage.text]
            && [self.sender isEqualToString:aMessage.sender]
            && ([self.date compare:aMessage.date] == NSOrderedSame)
    && [self.targetText isEqualToString:aMessage.targetText]
    && [self.sourceText isEqualToString:aMessage.sourceText];
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
    return [self.text hash] ^ [self.sender hash] ^ [self.date hash] ^ [self.sourceText hash] ^ [self.targetText hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@>[ %@, %@\n %@\n%@ ]", [self class], self.sender, self.date, self.sourceText, self.targetText];
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
        _targetText = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(targetText))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeObject:self.sender forKey:NSStringFromSelector(@selector(sender))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
    [aCoder encodeObject:self.sourceText forKey:NSStringFromSelector(@selector(sourceText))];
    [aCoder encodeObject:self.targetText forKey:NSStringFromSelector(@selector(targetText))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithText:[self.text copy]
                                                sourceText:[self.sourceText copy]
                                                targetText:[self.targetText copy]
                                                    sender:[self.sender copy]
                                                      date:[self.date copy]];
}

-(NSAttributedString*)combinedText
{
    NSString* combinedStr = [NSString stringWithFormat:@"%@\n%@", self.sourceText, self.targetText];
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:combinedStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, [self.sourceText length])];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([self.sourceText length]+1, [self.targetText length])];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, [combinedStr length])];
    return attributedStr;
}

@end

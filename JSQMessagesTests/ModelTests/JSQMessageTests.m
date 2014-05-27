//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>

#import "JSQMessage.h"


@interface JSQMessageTests : XCTestCase

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSDate *date;

@end


@implementation JSQMessageTests

- (void)setUp
{
    [super setUp];
    self.text = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque"
                @"laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi"
                @"architecto beatae vitae dicta sunt explicabo.";
    self.sender = @"Jesse Squires";
    self.date = [NSDate date];
}

- (void)tearDown
{
    self.text = nil;
    self.sender = nil;
    self.date = nil;
    [super tearDown];
}


@end

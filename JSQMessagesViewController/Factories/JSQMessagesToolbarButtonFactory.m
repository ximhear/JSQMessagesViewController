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

#import "JSQMessagesToolbarButtonFactory.h"

#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"


@implementation JSQMessagesToolbarButtonFactory

+ (UIButton *)defaultAccessoryButtonItem
{
#if 0 // gzonelee
    UIImage *cameraImage = [UIImage imageNamed:@"camera"];
    UIImage *cameraNormal = [cameraImage jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
    UIImage *cameraHighlighted = [cameraImage jsq_imageMaskedWithColor:[UIColor darkGrayColor]];
    
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [cameraButton setImage:cameraNormal forState:UIControlStateNormal];
    [cameraButton setImage:cameraHighlighted forState:UIControlStateHighlighted];
    
    cameraButton.contentMode = UIViewContentModeScaleAspectFit;
    cameraButton.backgroundColor = [UIColor clearColor];
    cameraButton.tintColor = [UIColor lightGrayColor];
    
    return cameraButton;
#else
    return nil;
#endif
}

+ (UIButton *)defaultSendButtonItem
{
    NSString *sendTitle = NSLocalizedString(@"Send", @"Text for the send button on the messages view toolbar");
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor jsq_messageBubbleBlueColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[[UIColor jsq_messageBubbleBlueColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    sendButton.contentMode = UIViewContentModeCenter;
    sendButton.backgroundColor = [UIColor clearColor];
    sendButton.tintColor = [UIColor jsq_messageBubbleBlueColor];
    
    return sendButton;
}

+ (UIButton *)defaultOkButtonItem
{
    NSString *sendTitle = NSLocalizedString(@"OK", @"Text for the send button on the messages view toolbar");
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[[UIColor whiteColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    sendButton.contentMode = UIViewContentModeCenter;
//    sendButton.backgroundColor = [UIColor clearColor];
//    sendButton.tintColor = [UIColor jsq_messageBubbleBlueColor];
    UIImage *originalImage = [UIImage imageNamed:@"text_input_enter_normal.png"];
    UIEdgeInsets insets = UIEdgeInsetsMake(originalImage.size.height/2-0.5, originalImage.size.width/2-0.5, originalImage.size.height/2+0.5, originalImage.size.width/2+0.5);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    
    [sendButton setBackgroundImage:stretchableImage forState:UIControlStateNormal];

    originalImage = [UIImage imageNamed:@"text_input_enter_pressed.png"];
    stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    [sendButton setBackgroundImage:stretchableImage forState:UIControlStateHighlighted];
    
    originalImage = [UIImage imageNamed:@"text_input_enter_normal.png"];
    stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    [sendButton setBackgroundImage:stretchableImage forState:UIControlStateDisabled];
    
    return sendButton;
}

@end

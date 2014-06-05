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

#import "JSQDemoViewController.h"


//static NSString * const kJSQDemoAvatarNameCook = @"Tim Cook";
static NSString * const kJSQDemoAvatarNameJobs = @"Jobs";
//static NSString * const kJSQDemoAvatarNameWoz = @"Steve Wozniak";


@implementation JSQDemoViewController

#pragma mark - Demo setup

- (void)setupTestModel
{
    /**
     *  Load some fake messages for demo.
     *
     *  You should have a mutable array or orderedSet, or something.
     */
    
    NSDictionary* attributeDic = @{
                                   @"sourceText":@{NSForegroundColorAttributeName:[UIColor greenColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:15]},
                                   @"targetText":@{NSForegroundColorAttributeName:[UIColor redColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                   };
    JSQMessage* msg = [[JSQMessage alloc] initWithSourceText:@"안녕하세요1111"
                                                  sourceLang:@"ko"
                                                  targetText:@"HelloHe1111"
                                                      sender:self.sender
                                                        date:[NSDate distantPast]
                                                  attributes:attributeDic];
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     msg,
                     [[JSQMessage alloc] initWithSourceText:@"안녕하세요1111"
                                                 sourceLang:@"ko"
                                                 targetText:@"HelloHe1111"
                                                     sender:self.sender
                                                       date:[NSDate distantPast]
                                                 attributes:attributeDic],
//                     [[JSQMessage alloc] initWithText:@"BBB" sender:self.sender date:[NSDate distantPast]],
//                     [[JSQMessage alloc] initWithText:@"BBB" sender:kJSQDemoAvatarNameWoz date:[NSDate distantPast]],
                     nil];
    
    /**
     *  Create avatar images once.
     *
     *  Be sure to create your avatars one time and reuse them for good performance.
     *
     *  If you are not using avatars, ignore this.
     */
    CGFloat outgoingDiameter = self.collectionView.collectionViewLayout.outgoingAvatarViewSize.width;
    
    UIImage *jsqImage = [JSQMessagesAvatarFactory avatarWithUserInitials:@"Me"
                                                         backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
                                                               textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
                                                                    font:[UIFont systemFontOfSize:14.0f]
                                                                diameter:outgoingDiameter];
    
    CGFloat incomingDiameter = self.collectionView.collectionViewLayout.incomingAvatarViewSize.width;
    
    UIImage *cookImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_cook"]
                                                          diameter:incomingDiameter];
    
    UIImage *jobsImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]
                                                          diameter:incomingDiameter];
    
    UIImage *wozImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_woz"]
                                                         diameter:incomingDiameter];
    self.avatars = @{ self.sender : jsqImage,
                      kJSQDemoAvatarNameJobs : jobsImage };
    
    /**
     *  Change to add more messages for testing
     */
    NSUInteger messagesToAdd = 0;
    NSArray *copyOfMessages = [self.messages copy];
    for (NSUInteger i = 0; i < messagesToAdd; i++) {
        [self.messages addObjectsFromArray:copyOfMessages];
    }
    
}



#pragma mark - View lifecycle

/**
 *  Override point for customization.
 *
 *  Customize your view.
 *  Look at the properties on `JSQMessagesViewController` to see what is possible.
 *
 *  Customize your layout.
 *  Look at the properties on `JSQMessagesCollectionViewFlowLayout` to see what is possible.
 */
- (void)viewDidLoad
{
    GZLogFunc0();
    
    [super viewDidLoad];
    
    self.title = @"JSQMessages";
    
    self.sender = @"me";
    
    [self setupTestModel];
    
    /**
     *  Remove camera button since media messages are not yet implemented
     *
     *   self.inputToolbar.contentView.leftBarButtonItem = nil;
     *
     *  Or, you can set a custom `leftBarButtonItem` and a custom `rightBarButtonItem`
     */
    
    /**
     *  Create bubble images.
     *
     *  Be sure to create your avatars one time and reuse them for good performance.
     *
     */
    self.outgoingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    
    self.incomingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    incomingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleGreenColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"typing"]
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(receiveMessagePressed:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.delegateModal) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                              target:self
                                                                                              action:@selector(closePressed:)];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /**
     *  Enable/disable springy bubbles, default is YES.
     *  For best results, toggle from `viewDidAppear:`
     */
    self.collectionView.collectionViewLayout.springinessEnabled = NO;
}



#pragma mark - Actions

- (void)receiveMessagePressed:(UIBarButtonItem *)sender
{
    GZLogFunc0();
    /**
     *  The following is simply to simulate received messages for the demo.
     *  Do not actually do this.
     */
    
    
    /**
     *  Show the tpying indicator
     */
    self.showTypingIndicator = !self.showTypingIndicator;

#if 0
    JSQMessage *copyMessage = [[self.messages lastObject] copy];
    
    if (!copyMessage) {
        return;
    }
#else
    NSDictionary* attributeDic = @{
                                   @"sourceText":@{NSForegroundColorAttributeName:[UIColor cyanColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:20]},
                                   @"targetText":@{NSForegroundColorAttributeName:[UIColor purpleColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:20]}
                                   };
    JSQMessage* copyMessage = [[JSQMessage alloc] initWithSourceText:@"Hello"
                                                          sourceLang:@"system"
                                                  targetText:@"안녕하시지요?"
                                                      sender:@"system"
                                                        date:[NSDate date]
                                                  attributes:attributeDic
                                                         optionalDic:@{@"usage": @"interpreter"}];
#endif
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *copyAvatars = [[self.avatars allKeys] mutableCopy];
        [copyAvatars removeObject:self.sender];
//        copyMessage.sender = [copyAvatars objectAtIndex:arc4random_uniform((int)[copyAvatars count])];
        
        /**
         *  This you should do upon receiving a message:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishReceivingMessage`
         */
        [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
        [self.messages addObject:copyMessage];
        [self finishReceivingMessage];
    });
}

- (void)closePressed:(UIBarButtonItem *)sender
{
    [self.delegateModal didDismissJSQDemoViewController:self];
}




#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                    sender:(NSString *)sender
                      date:(NSDate *)date
{
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Play sound (optional)
     *  2. Add new id<JSQMessageData> object to your data source
     *  3. Call `finishSendingMessage`
     */
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    NSDictionary* attributeDic = @{
                                   @"sourceText":@{NSForegroundColorAttributeName:[UIColor greenColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:15]},
                                   @"targetText":@{NSForegroundColorAttributeName:[UIColor redColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                   };
    
    JSQMessage *message = [[JSQMessage alloc] initWithSourceText:text
                                                      sourceLang:@"ko"
                                                      targetText:text
                                                          sender:sender
                                                            date:date
                                                      attributes:attributeDic];
    [self.messages addObject:message];
    
    [self finishSendingMessage];
}

- (void)didPressAccessoryButton:(UIButton *)sender
{
    NSLog(@"Camera pressed!");
    /**
     *  Accessory button has no default functionality, yet.
     */
}



#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.item];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  You may return nil here if you do not want bubbles.
     *  In this case, you should set the background color of your collection view cell's textView.
     */
    
    /**
     *  Reuse created bubble images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and bubbles would disappear from cells
     */
    
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.sender isEqualToString:self.sender]) {
        return [[UIImageView alloc] initWithImage:self.outgoingBubbleImageView.image
                                 highlightedImage:self.outgoingBubbleImageView.highlightedImage];
    }
    
    return [[UIImageView alloc] initWithImage:self.incomingBubbleImageView.image
                             highlightedImage:self.incomingBubbleImageView.highlightedImage];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Return `nil` here if you do not want avatars.
     *  If you do return `nil`, be sure to do the following in `viewDidLoad`:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
     *
     *  It is possible to have only outgoing avatars or only incoming avatars, too.
     */
    
    /**
     *  Reuse created avatar images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and avatars would disappear from cells
     *
     *  Note: these images will be sized according to these values:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize
     *
     *  Override the defaults in `viewDidLoad`
     */
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    UIImage *avatarImage = [self.avatars objectForKey:message.sender];
    return [[UIImageView alloc] initWithImage:avatarImage];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
     *  The other label text delegate methods should follow a similar pattern.
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    /**
     *  iOS7-style sender name labels
     */
#if 0 // gzonelee
    if ([message.sender isEqualToString:self.sender]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:message.sender]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.sender];
#else
    if (indexPath.item - 1 >= 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:message.sender] &&[previousMessage.sourceLang isEqualToString:message.sourceLang] == NO ) {
            return [[NSAttributedString alloc] initWithString:message.sourceLang];
        }
        else if ([[previousMessage sender] isEqualToString:message.sender] == NO)
        {
            return [[NSAttributedString alloc] initWithString:message.sourceLang];
        }
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:message.sourceLang];
    
#endif
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Override point for customizing cells
     */
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    /**
     *  Configure almost *anything* on the cell
     *  
     *  Text colors, label text, label colors, etc.
     *
     *
     *  DO NOT set `cell.textView.font` !
     *  Instead, you need to set `self.collectionView.collectionViewLayout.messageBubbleFont` to the font you want in `viewDidLoad`
     *
     *  
     *  DO NOT manipulate cell layout information!
     *  Instead, override the properties you want on `self.collectionView.collectionViewLayout` from `viewDidLoad`
     */
    
    JSQMessage *msg = [self.messages objectAtIndex:indexPath.item];
    
//    if ([msg.sender isEqualToString:self.sender]) {
//        cell.textView.textColor = [UIColor blackColor];
//    }
//    else {
//        cell.textView.textColor = [UIColor whiteColor];
//    }
    
    cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };

    if ([self isSelectedIndexPath:indexPath] == YES) {
        [cell.submenuBtn1 removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
        [cell.submenuBtn2 removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
        [cell.submenuBtn3 removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
        [cell.submenuBtn4 removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
        
        [cell.submenuBtn1 addTarget:self action:@selector(cellPlay:) forControlEvents:UIControlEventTouchUpInside];
        [cell.submenuBtn2 addTarget:self action:@selector(cellEdit:) forControlEvents:UIControlEventTouchUpInside];
        [cell.submenuBtn3 addTarget:self action:@selector(cellExpand:) forControlEvents:UIControlEventTouchUpInside];
        [cell.submenuBtn4 addTarget:self action:@selector(cellSimilarSentence:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([msg.sender isEqualToString:@"system"]) {
        [cell.submenuBtn1 removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
        
        cell.submenuBtn1.tag = indexPath.item;
        [cell.submenuBtn1 addTarget:self action:@selector(usageClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}


#pragma mark - IBAction
-(IBAction)cellPlay:(id)sender
{
    GZLogFunc0();
}

-(IBAction)cellEdit:(id)sender
{
    GZLogFunc0();
}

-(IBAction)cellExpand:(id)sender
{
    GZLogFunc0();
}

-(IBAction)cellSimilarSentence:(id)sender
{
    GZLogFunc0();
}

-(IBAction)usageClicked:(id)sender
{
    GZLogFunc0();
    
    int index = [sender tag];
    JSQMessage* msg = self.messages[index];
    GZLogFunc1(msg.optionalDic);
}

#pragma mark - JSQMessages collection view flow layout delegate

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
     */
    
    /**
     *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
     *  The other label height delegate methods should follow similarly
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    GZLogFunc1(indexPath);
    /**
     *  iOS7-style sender name labels
     */
    JSQMessage *currentMessage = [self.messages objectAtIndex:indexPath.item];
#if 0 // gzonelee
    if ([[currentMessage sender] isEqualToString:self.sender]) {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:[currentMessage sender]]) {
            return 0.0f;
        }
    }
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
#else
    if (indexPath.item - 1 >= 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:currentMessage.sender] &&[previousMessage.sourceLang isEqualToString:currentMessage.sourceLang] == NO ) {
            return kJSQMessagesCollectionViewCellLabelHeightDefault;
        }
        else if ([[previousMessage sender] isEqualToString:currentMessage.sender] == NO)
        {
            return kJSQMessagesCollectionViewCellLabelHeightDefault;
        }
        return 0.0f;
    }
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
#endif
    
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForSubmenuViewAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (self.selectedIndexPath != nil && [self.selectedIndexPath compare:indexPath] == NSOrderedSame) {
        height = 50;
    }
    else {
        JSQMessage *msg = self.messages[indexPath.item];
        if ([msg.sender isEqualToString:@"system"]) {
            height = 50;
        }
    }
    return height;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{
    NSLog(@"Load earlier messages!");
}

@end

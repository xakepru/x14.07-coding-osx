//
//  AppDocument.m
//  PlayVideoStremApp
//
//  Created by yurembo on 14.02.14.
//  Copyright (c) 2014 Юрий Язев. All rights reserved.
//

#import "AppDocument.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface AppDocument () {
    AVPlayer* player;
    AVAudioPlayer *mplayer;
}
@end

@implementation AppDocument

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"AppDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

- (IBAction)PlayFileClick:(id)sender {
   NSURL* contentURL = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"mp4"];
   player = [AVPlayer playerWithURL:contentURL];
   AVPlayerLayer* playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
   [self.videoPlayer.layer addSublayer:playerLayer];
   playerLayer.frame = self.videoPlayer.layer.bounds;
   playerLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
   player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
   [player play];
}

- (IBAction)SlowSpeedClick:(id)sender {
    [player setRate:0.2];
}

- (IBAction)NormSpeedClick:(id)sender {
    [player setRate:1.0];
}

- (IBAction)RewindClick:(id)sender {
    [player seekToTime:kCMTimeZero];
}

- (IBAction)PlayAudioClick:(id)sender {
    NSURL* soundFileURL = [[NSBundle mainBundle] URLForResource:@"Here" withExtension:@"wav"];
    NSAssert(soundFileURL ,@"URL is valid");
    NSError* err = nil;
    mplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&err];
    if (!mplayer) NSLog(@"Error creating player: %@", err);
    
    mplayer.volume = 1.0;
    mplayer.numberOfLoops = -1;
    mplayer.currentTime = 0;
    [mplayer prepareToPlay];
    [mplayer play];
}
@end

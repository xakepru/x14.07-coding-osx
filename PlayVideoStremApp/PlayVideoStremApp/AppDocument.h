//
//  AppDocument.h
//  PlayVideoStremApp
//
//  Created by yurembo on 14.02.14.
//  Copyright (c) 2014 Юрий Язев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDocument : NSDocument
@property (weak) IBOutlet NSView *videoPlayer;
- (IBAction)PlayFileClick:(id)sender;
- (IBAction)SlowSpeedClick:(id)sender;
- (IBAction)NormSpeedClick:(id)sender;
- (IBAction)RewindClick:(id)sender;
- (IBAction)PlayAudioClick:(id)sender;
@end

//
//  AppDocument.h
//  GeoLocation
//
//  Created by yurembo on 16.02.14.
//  Copyright (c) 2014 Юрий Язев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDocument : NSDocument <NSApplicationDelegate, CLLocationManagerDelegate>
@property (weak) IBOutlet NSTextField *latitudeText;
@property (weak) IBOutlet NSTextField *longitudeText;
@property (weak) IBOutlet NSTextField *accuracyText;
@property (weak) IBOutlet NSTextField *addressText;
@property (weak) IBOutlet NSProgressIndicator *progressBar;

@end

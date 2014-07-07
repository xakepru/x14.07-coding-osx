//
//  AppDocument.m
//  GeoLocation
//
//  Created by yurembo on 16.02.14.
//  Copyright (c) 2014 Юрий Язев. All rights reserved.
//

#import "AppDocument.h"

@interface AppDocument () {
    CLLocationManager* _locationManager;
    CLGeocoder* _geocoder;
}
@end

@implementation AppDocument

@synthesize latitudeText = _latitudeText;
@synthesize longitudeText = _longitudeText;
@synthesize accuracyText = _accuracyText;
@synthesize progressBar = _progressBar;

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
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    _geocoder = [[CLGeocoder alloc] init];
    
    self.latitudeText.stringValue = @"-";
    self.longitudeText.stringValue = @"-";
    self.accuracyText.stringValue = @"-";
    
    [self.progressBar startAnimation:nil];
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

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.latitudeText.stringValue = [NSString stringWithFormat:@"%.2f", newLocation.coordinate.latitude];
    self.longitudeText.stringValue = [NSString stringWithFormat:@"%.2f", newLocation.coordinate.longitude];
    self.accuracyText.stringValue = [NSString stringWithFormat:@"%.1f m", newLocation.horizontalAccuracy];
    [self.progressBar stopAnimation:nil];
    
    [_geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error != nil) {
            self.addressText.stringValue = @"Невозможно вычислить адрес!";
            return;
        }
        CLPlacemark* placeMark = [placemarks lastObject];
        NSString* addressString = [NSString stringWithFormat:@"%@ %@, %@, %@, %@", placeMark.subThoroughfare, placeMark.thoroughfare, placeMark.locality, placeMark.administrativeArea, placeMark.country];
        self.addressText.stringValue = addressString;
    }];
    
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.latitudeText.stringValue = @"-";
    self.longitudeText.stringValue = @"-";
    self.accuracyText.stringValue = @"-";
    [self.progressBar startAnimation:nil];
}


@end

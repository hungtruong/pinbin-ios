//
//  PBLocationManager.h
//  PinBin
//
//  Created by Hung Truong on 4/20/14.
//  Copyright (c) 2014 Hung Truong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface PBLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
@property BOOL locationServicesEnabled;

+ (PBLocationManager *) sharedManager;
- (void)toggleServiceOn;
@end

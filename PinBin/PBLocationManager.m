//
//  PBLocationManager.m
//  PinBin
//
//  Created by Hung Truong on 4/20/14.
//  Copyright (c) 2014 Hung Truong. All rights reserved.
//

#import "PBLocationManager.h"
#import "PBConfig.h"

@implementation PBLocationManager

-(id)init
{
  self = [super init];
  if (self) {
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDistanceFilter:3.0];
    [self.locationManager startUpdatingLocation];
    self.locationServicesEnabled = YES;
  }
  return self;
}

+(PBLocationManager *) sharedManager
{
  static PBLocationManager *instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[PBLocationManager alloc] init];
  });
  
  return instance;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  //post location to our cool endpoint
  CLLocation *newestLocation = [locations lastObject];
  if (newestLocation.horizontalAccuracy < 50) {
    NSString *postString = [NSString stringWithFormat:@"latitude=%f&longitude=%f&timestamp=%.0f&accuracy=%.0f&speed=%.2f",
                            newestLocation.coordinate.latitude,
                            newestLocation.coordinate.longitude,
                            [newestLocation.timestamp timeIntervalSince1970],
                            newestLocation.horizontalAccuracy,
                            newestLocation.speed
                            ];
    NSURL *url = [NSURL URLWithString:PinBinURL];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                             if ([((NSHTTPURLResponse *)response) statusCode] != 200) {
                               //well there was an error
                             }
                           }];
  }

}

-(void)toggleServiceOn
{
  if (self.locationServicesEnabled)
  {
    [self.locationManager stopUpdatingLocation];
  }
  else
  {
    [self.locationManager startUpdatingLocation];
  }
  
  self.locationServicesEnabled = !self.locationServicesEnabled;
}


@end

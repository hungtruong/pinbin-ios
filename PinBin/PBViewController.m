//
//  PBViewController.m
//  PinBin
//
//  Created by Hung Truong on 4/20/14.
//  Copyright (c) 2014 Hung Truong. All rights reserved.
//

#import "PBViewController.h"
#import "PBLocationManager.h"
@interface PBViewController ()

@end

@implementation PBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
  [self setUpViews];
}

- (void)setUpViews
{
  if ([[PBLocationManager sharedManager] locationServicesEnabled]) {
    [self.label setText:@"Location services are on"];
    [self.button setTitle:@"Turn location services off" forState:UIControlStateNormal];
  }
  else
  {
    [self.label setText:@"Location services are off"];
    [self.button setTitle:@"Turn location services on" forState:UIControlStateNormal];
  }
}

-(void)buttonPressed:(id)sender
{
  [[PBLocationManager sharedManager] toggleServiceOn];
  [self setUpViews];
}

@end

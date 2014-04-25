//
//  PBViewController.h
//  PinBin
//
//  Created by Hung Truong on 4/20/14.
//  Copyright (c) 2014 Hung Truong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIButton *button;

-(IBAction)buttonPressed:(id)sender;
@end

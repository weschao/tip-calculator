//
//  SettingsViewController.m
//  Tip Calculator
//
//  Created by Wes Chao on 10/10/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UISwitch *roundTipCheckbox;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.title=@"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidDisappear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: self.defaultTipControl.selectedSegmentIndex forKey:@"default_tip_percentage"];
    [defaults setBool: self.roundTipCheckbox.on forKey:@"round_tip"];
    
    [defaults synchronize];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

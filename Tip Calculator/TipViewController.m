//
//  TipViewController.m
//  Tip Calculator
//
//  Created by Wes Chao on 10/10/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *percentageControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Tip Calculator";
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

}

- (void)viewDidAppear:(BOOL)animated {
    // Read the settings for default tip percentage and rounding
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.percentageControl.selectedSegmentIndex = [defaults integerForKey:@"default_tip_percentage"];
    
    
    [self updateValues];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
    
}

- (void)updateValues {
    NSLog(@"updating values...");
    
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValues = @[@(0.15), @(0.20), @(0.25)];
    
    float tipAmount = billAmount * [tipValues[self.percentageControl.selectedSegmentIndex] floatValue];
    float totalAmount = billAmount + tipAmount;

    // round up to the nearest dollar, if desired
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"round_tip"]) {
        totalAmount = ceil(totalAmount);
        tipAmount = totalAmount - billAmount;
    }
        
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}
@end

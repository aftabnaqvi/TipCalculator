//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Syed Naqvi on 1/10/15.
//  Copyright (c) 2015 Syed Naqvi. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)defaultTipChanged:(id)sender;

- (void) storeValues;
@end


@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)defaultTipChanged:(id)sender {
    [self storeValues];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"settingsView will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.tipControl.selectedSegmentIndex = [defaults integerForKey:@"tipDefault"];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"settingsView did appear");
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"settingsView will disappear");
    [self storeValues];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"settingsView did disappear");
}

- (void) storeValues{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[self.tipControl selectedSegmentIndex] forKey:@"tipDefault"];
    [defaults synchronize];
}
@end

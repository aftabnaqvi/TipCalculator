//
//  TipViewController.m
//  TipCalculator
//
//  Created by Syed Naqvi on 1/9/15.
//  Copyright (c) 2015 Syed Naqvi. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

@property (weak, nonatomic) IBOutlet UILabel *oneCustomerLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoCustomersLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeCustomersLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourCustomersLabel;

@property (weak, nonatomic) NSString *currencySymbol;

@property (weak, nonatomic) IBOutlet UIImageView *oneCustomer;
@property (weak, nonatomic) IBOutlet UIImageView *twoCustomers;
@property (weak, nonatomic) IBOutlet UIImageView *threeCustomers;
@property (weak, nonatomic) IBOutlet UIImageView *fourCustomers;


@property (weak, nonatomic) IBOutlet UILabel *totalForTwoLbel;
@property (weak, nonatomic) IBOutlet UILabel *totalForThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalForFourLabel;

- (IBAction)onTap:(id)sender;
- (void) updateValues;
- (void) onSettingsButton;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self updateValues];
    
    self.currencySymbol = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
    
    NSLog(@"%@", [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]);
    
    self.oneCustomer.image = [UIImage imageNamed:@"customer.png"];
    self.twoCustomers.image = [UIImage imageNamed:@"customer.png"];
    self.threeCustomers.image = [UIImage imageNamed:@"customer.png"];
    self.fourCustomers.image = [UIImage imageNamed:@"customer.png"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues{
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.20)];
    
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    
    self.tipLabel.text = [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, tipAmount];
    
    self.totalLabel.text = [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, totalAmount];
    
    self.totalForTwoLbel.text = [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, totalAmount/2.0];
    
    self.totalForThreeLabel.text = [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, totalAmount/3.0];
    
    self.totalForFourLabel.text = [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, totalAmount/4.0];
    
//    float floatPart = totalAmount - (int)totalAmount;
//    NSLog(@"%@", [TipViewController formatWithThousandSeparator:totalAmount]);
//    NSLog(@"%@", [NSString stringWithFormat:@"%@%@ ---- %0.2f", self.currencySymbol, [TipViewController formatWithThousandSeparator:totalAmount], floatPart]);
//
//    
//    
//    self.totalLabel.text = [NSString stringWithFormat:@"%@%@%.2f", self.currencySymbol, [TipViewController formatWithThousandSeparator:totalAmount], floatPart];
//    
//    
//    floatPart = tipAmount - (int)tipAmount;
//    self.tipLabel.text = [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, [[TipViewController formatWithThousandSeparator:tipAmount] integerValue]+floatPart];
//    
//    
//    floatPart = totalAmount/2.0 - (int)(totalAmount/2.0);
//    
//    self.totalForTwoLbel.text = [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, [[TipViewController formatWithThousandSeparator:totalAmount/2.0] integerValue]+floatPart];
//    
//    floatPart = totalAmount/3.0 - (int)(totalAmount/3.0);
//    self.totalForThreeLabel.text = [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, [[TipViewController formatWithThousandSeparator:totalAmount/3.0] integerValue]+floatPart];
//    
//    floatPart = totalAmount/4.0 - (int)(totalAmount/4.0);
//    self.totalForFourLabel.text = [NSString stringWithFormat:@"%@%0.2f", self.currencySymbol, [[TipViewController formatWithThousandSeparator:totalAmount/4.0] integerValue]+floatPart];
}

- (void) onSettingsButton{
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Tipview will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.tipControl.selectedSegmentIndex = [defaults integerForKey:@"tipDefault"];
    [self updateValues];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"Tipview did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"Tipview will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"Tipview did disappear");
}

+(NSString*)formatWithThousandSeparator:(int)number
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSLog(@"%@", [formatter stringFromNumber:[NSNumber numberWithInteger:number]]);

    return [formatter stringFromNumber:[NSNumber numberWithInteger:number]];
}
@end

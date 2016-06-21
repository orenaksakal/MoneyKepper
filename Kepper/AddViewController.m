//
//  AddViewController.m
//  Kepper
//
//  Created by Oren Aksakal on 01/06/16.
//  Copyright © 2016 AKSAKAL oren. All rights reserved.
//

#import "AddViewController.h"
#import "model/MoneyKeeper.h"

@interface AddViewController()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextView *descField;

- (IBAction)saveAction:(id)sender;

@property NSMutableArray *moneyKeeperArraySegue;

@end

@implementation AddViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)saveAction:(id)sender {
    NSString *name = _nameField.text;
    double price =  [_priceField.text doubleValue];
    NSDate *date = _datePicker.date;
    NSString *desc = _descField.text;
    if(![name  isEqual: @""] && ![_priceField.text  isEqual: @""] && ![desc isEqual:@""] ) {
        NSLog(@"OK !!");
        
        AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
        MoneyKeeper *moneyKeeper = [NSEntityDescription insertNewObjectForEntityForName:@"MoneyKeeper" inManagedObjectContext:[app managedObjectContext]];

        moneyKeeper.name = name;
        moneyKeeper.prices = price;
        moneyKeeper.date = date;
        moneyKeeper.desc = desc;
        
        NSLog(name);
        NSLog(moneyKeeper.name);
        
        NSError *error = nil;
        if ([[app managedObjectContext] save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }

        NSLog(@"OK22 !!");
      //  [_app.moneyKeeperArray addObject:[[MoneyKeeper alloc] init:name date:date price:price description:desc ]];
        [self.navigationController popViewControllerAnimated:true];
        
        //[self dismissViewControllerAnimated:true completion:nil];
        
    } else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Missing fields"
                                      message:@"Please, check your input data."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {}];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


@end

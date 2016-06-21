//
//  ViewController.h
//  Kepper
//
//  Created by Oren Aksakal on 01/06/16.
//  Copyright © 2016 AKSAKAL oren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController


@property NSInteger index;
@property AppDelegate *app;
@property NSMutableArray *moneyKeeperArray;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *edit;
@property (weak, nonatomic) IBOutlet UITextField *EData;
@property (weak, nonatomic) IBOutlet UITextField *EName;
@property (weak, nonatomic) IBOutlet UITextField *EPrice;
@property (weak, nonatomic) IBOutlet UITextField *EDesc;
@property (weak, nonatomic) IBOutlet UIButton *SaveEdit;
@property (weak, nonatomic) IBOutlet UIButton *CalcelEdit;

- (void) fetchData;
- (void) update;
- (NSString*) dateToString: (NSDate*)date;

@end


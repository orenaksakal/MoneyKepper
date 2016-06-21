//
//  ViewController.m
//  Kepper
//
//  Created by Oren Aksakal on 01/06/16.
//  Copyright © 2016 AKSAKAL oren. All rights reserved.
//

#import "ViewController.h"
#import "model/MoneyKeeper.h"
#import "AppDelegate.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *range;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIDatePicker *EditDate;
- (IBAction)nextAction:(id)sender;
- (IBAction)previousAction:(id)sender;
@end

@implementation ViewController
int i=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    _app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _index = 0;
    
    [self fetchData];
    
    NSLog(@"_moneyKeeperArray count :: %ld", [_moneyKeeperArray count]);
    self.slider.maximumValue=[_moneyKeeperArray count]-1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchData];
}
- (IBAction)ValueChanged:(id)sender {
    self.slider.maximumValue=[_moneyKeeperArray count]-1;
    _index=(int)roundf(self.slider.value);

    [self update];
    NSLog(@"Message == %d",  _index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * Fetch all data from MonetKeeper CoreData
 */
- (void)fetchData {
    //Get request for MonetKeeper (~= select * from MoneyKeeper)
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MoneyKeeper"];
    
    //Execute request, put all data into _monetKeeperArray
    _moneyKeeperArray = [[_app.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    //Update UI
    [self update];
}

- (void)update {
    if (_moneyKeeperArray.count > 0) {
        NSString* total = [NSString stringWithFormat:@"%ld to %ld",_index+1, [_moneyKeeperArray count]];
        _range.text = total;
        
        _name.text = [_moneyKeeperArray[_index] name];
        
        _price.text = [[NSString alloc] initWithFormat:@"%g", [_moneyKeeperArray[_index] prices]];
        _desc.text = [_moneyKeeperArray[_index] desc];
        _date.text = [self dateToString: [_moneyKeeperArray[_index] date]];
    } else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Empty"
                                      message:@"Please, input data."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {}];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        NSString* total = [NSString stringWithFormat:@"%d to %ld", 0, [_moneyKeeperArray count]];
        _range.text = total;
        
        _name.text = @"";
        _price.text = @"";
        _desc.text = @"";
        _date.text = @"";
        
    }
}

- (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}


- (IBAction)DeleteAction:(id)sender {
    [_app.managedObjectContext deleteObject:_moneyKeeperArray[_index]];
    [_moneyKeeperArray removeObjectAtIndex:_index];
    [_app saveContext];
    //if (_index == 0 && _moneyKeeperArray.count > 0)
    if (_index == _moneyKeeperArray.count && _moneyKeeperArray.count > 0){
        _index--;
    }
    [self update];
}

- (IBAction)DateChanged:(id)sender {
    NSDate *date0 = _EditDate.date;
    _EData.text = [self dateToString: date0];
}


- (IBAction)EditPressed:(id)sender {
    
    int q;
    CGFloat moduloResult = (float)((int)i % (int)2);
    q=moduloResult;
    switch (q) {
        case 0:
        {
          
            _EName.text=@"";
            _EData.text=@"";
            _EPrice.text=@"";
            _EDesc.text=@"";
            _EName.placeholder=[_moneyKeeperArray[_index] name];
            _EData.placeholder=[self dateToString: [_moneyKeeperArray[_index] date]];
            _EPrice.placeholder=[[NSString alloc] initWithFormat:@"%g", [_moneyKeeperArray[_index] prices]];
            _EDesc.placeholder=[_moneyKeeperArray[_index] desc];
            
            
    _EName.hidden=false;
    _EData.hidden=false;
    _EPrice.hidden=false;
    _EDesc.hidden=false;
    _EditDate.hidden=false;
            _desc.hidden=true;
          //  NSDate *currentDate = [NSDate date];
            _EditDate.date = [_moneyKeeperArray[_index] date];
    [_edit setTitle:@"Save Changes" forState:UIControlStateNormal];
            break;
        }
        case 1:
        {
    MoneyKeeper *mk = _moneyKeeperArray[_index];
     if(![_EPrice.text isEqual:@""])
     {
    double PriceDoubleValue = [_EPrice.text doubleValue];
    mk.prices = PriceDoubleValue;
     }
    if(![_EName.text isEqual:@""])
    mk.name=_EName.text;
    if(![_EDesc.text isEqual:@""])
    mk.desc=_EDesc.text;
    NSDate *date = _EditDate.date;
            mk.date=date;
    
    [_app saveContext];
        _EName.hidden=true;
        _EData.hidden=true;
        _EPrice.hidden=true;
        _EDesc.hidden=true;
        _EditDate.hidden=true;
            _desc.hidden=false;
        [_edit setTitle:@"Edit" forState:UIControlStateNormal];
    [self update];
            break;
        }
    }
    i=i+1;
}



- (IBAction)nextAction:(id)sender {
    if(_index + 1 < [_moneyKeeperArray count]){
        _index++;
        [self update];
        self.slider.maximumValue=[_moneyKeeperArray count];
        self.slider.value=_index+1;
    }
}

- (IBAction)previousAction:(id)sender {
    if(_index > 0){
        _index--;
        [self update];
        self.slider.maximumValue=[_moneyKeeperArray count];
        self.slider.value=_index+1;
    }
}
@end

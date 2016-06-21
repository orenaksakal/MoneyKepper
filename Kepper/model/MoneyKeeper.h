//
//  MoneyKeeper.h
//  Kepper
//
//  Created by Oren Aksakal on 01/06/16.
//  Copyright © 2016 AKSAKAL oren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MoneyKeeper : NSManagedObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate* date;
@property double prices;
@property (nonatomic, strong) NSString* desc;

@end

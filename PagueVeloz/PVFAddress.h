//
//  PVFAddress.h
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 28/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVFCity.h"

@interface PVFAddress : NSObject
@property (nonatomic, strong) PVFCity   *city;
@property (nonatomic, strong) NSString  *street;
@property (nonatomic, strong) NSString  *number;
@property (nonatomic, strong) NSString  *zip;

+ (id)parseResponse:(id)object;

@end

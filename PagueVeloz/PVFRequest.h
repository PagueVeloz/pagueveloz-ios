//
//  PVFRequest.h
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 28/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVFRequest : NSObject

@property (nonatomic, strong) NSString  *apiVersion;
@property (nonatomic, strong) NSString  *endpoint;
@property (nonatomic, strong) NSString  *method;
@property (nonatomic, strong) NSData    *data;
@property (nonatomic, assign) BOOL      requiresSigning;
@property (nonatomic, strong) Class     returnClass;


@end

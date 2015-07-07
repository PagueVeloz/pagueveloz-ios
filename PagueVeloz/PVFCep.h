//
//  PFVCep.h
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 28/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVFRequest.h"
#import "PVFAddress.h"
@interface PVFCep : NSObject

@property (nonatomic, strong) NSString *cep;

/*
 * Creates a request object to query the address of a given ZIP code.
 *
 * @param   cep     A string containing the zip code, it can be formated XXXXX-XXX or unformated XXXXXXXX.
 * @return          The request for this query.
 */
+ (PVFRequest *)queryAddressByCep:(NSString*)cep;

/*
 * Creates a request object to query the address the property CEP.
 *
 * @return          The request for this query.
 */
- (PVFRequest *)queryAddress;

@end

//
//  PFVCep.m
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 28/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import "PVFCep.h"
@implementation PVFCep

+ (PVFRequest *)queryAddressByCep:(NSString*)cep {
    NSAssert(cep, @"The zip code must not be nil");
    
    PVFRequest *request = [[PVFRequest alloc] init];
    [request setApiVersion:@"v1"];
    [request setEndpoint:[NSString stringWithFormat: @"CEP/%@", cep]];
    [request setRequiresSigning:NO];
    [request setMethod:@"GET"];
    [request setReturnClass:[PVFAddress class]];
    return request;
}

- (PVFRequest *)queryAddress {
    return [PVFCep queryAddressByCep:self.cep];
}

@end

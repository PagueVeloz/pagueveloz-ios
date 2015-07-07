//
//  PVFAddress.m
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 28/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import "PVFAddress.h"

@implementation PVFAddress

+ (id)parseResponse:(id)object {
    PVFAddress *address = [[PVFAddress alloc] init];
    [address setStreet:[object objectForKey:@"Logradouro"]];
    [address setNumber:[object objectForKey:@"Numero"]];
    [address setZip:[object objectForKey:@"CEP"]];
    [address setCity:[PVFCity new]];
    if([object objectForKey:@"Cidade"])
    {
        [address.city setName:[[object objectForKey:@"Cidade"] objectForKey:@"Nome"]];
        [address.city setState:[[object objectForKey:@"Cidade"] objectForKey:@"Estado"]];
    }
    return address;
}
@end

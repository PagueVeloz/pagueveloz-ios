//
//  PVFTransfer.m
//  PagueVeloz
//
//  Created by João Paulo Ros on 01/07/15.
//  Copyright (c) 2015 RayWenderlich. All rights reserved.
//

#import "PVFTransfer.h"

@implementation PVFTransfer
/*
 * Creates a request object to submit the Transfer with the given parameters.
 *
 * @param
 * @return          The request for this query.
 */
+ (PVFRequest *)submitTransferWithDestinationEmail:(NSString *)email
                                         andAmount:(double)amount
                            andTransferDescription:(NSString *)transferDescription {
    NSAssert(email, @"The email must not be nil");
    NSAssert(amount > 0, @"The value must be greater than 0");
    NSAssert(transferDescription, @"The transfer description must not be nil");
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:email forKey:@"ClienteDestino"];
    [data setObject:@(amount) forKey:@"Valor"];
    [data setObject:transferDescription forKey:@"Descricao"];
    
    NSError *error = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:data
                                                   options:0
                                                     error:&error];
    
    if(!error)
    {
        PVFRequest *request = [[PVFRequest alloc] init];
        [request setApiVersion:@"v1"];
        [request setEndpoint:@"Transferencia"];
        [request setRequiresSigning:YES];
        [request setMethod:@"POST"];
        [request setData:json];
        return request;
    }
    else
        return nil;
}
/*
 * Creates a request object to submit the Transfer with the object's properties.
 *
 * @return          The request for this query.
 */
- (PVFRequest *)submitTransfer {
    return [PVFTransfer submitTransferWithDestinationEmail:self.destinationEmail
                                                 andAmount:self.amount
                                    andTransferDescription:self.transferDescription];
}
@end

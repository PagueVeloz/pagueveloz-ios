//
//  PVFTransfer.h
//  PagueVeloz
//
//  Created by João Paulo Ros on 01/07/15.
//  Copyright (c) 2015 RayWenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVFRequest.h"

@interface PVFTransfer : NSObject
@property (nonatomic, strong) NSString *destinationEmail;
@property (nonatomic, assign) double    amount;
@property (nonatomic, strong) NSString *transferDescription;

/*
 * Creates a request object to submit the Transfer with the given parameters.
 *
 * @param
 * @return          The request for this query.
 */
+ (PVFRequest *)submitTransferWithDestinationEmail:(NSString *)email
                                         andAmount:(double)amount
                            andTransferDescription:(NSString *)transferDescription;
/*
 * Creates a request object to submit the Transfer with the object's properties.
 *
 * @return          The request for this query.
 */
- (PVFRequest *)submitTransfer;



@end

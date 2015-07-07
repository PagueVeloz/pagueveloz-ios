//
//  PVFSMSMessage.h
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 29/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVFRequest.h"
@interface PVFSMSMessage : NSObject

@property (nonatomic, strong) NSString  *internalId;
@property (nonatomic, strong) NSString  *senderPhone;
@property (nonatomic, strong) NSString  *destinationPhone;
@property (nonatomic, strong) NSString  *content;
@property (nonatomic, strong) NSDate    *scheduleToDate;
@property (nonatomic, assign) int       handle;


/*
 * Creates a request object to send the SMS Message with the given parameters.
 *
 * @param
 * @return          The request for this query.
 */
+ (PVFRequest *)sendMessageWithInternalId:(NSString *)internalId
                             andSenderPhone:(NSString *)senderPhone
                        andDestinationPhone:(NSString *)destinationPhone
                                 andContent:(NSString *)content
                          andScheduleToDate:(NSDate *)scheduleToDate;
/*
 * Creates a request object to send the SMS Message with the object's properties.
 *
 * @return          The request for this query.
 */
- (PVFRequest *)sendMessage;

@end

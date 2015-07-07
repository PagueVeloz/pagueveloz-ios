//
//  PVFBoleto.h
//  PagueVelozFramework
//
//  Created by João Paulo Ros on 28/06/15.
//  Copyright (c) 2015 PremierSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVFRequest.h"

@interface PVFBoleto : NSObject

typedef enum {
    All = 0,
    Payed = 1,
    Overdue = 2,
    ToOverdue = 3,
} PVFBoletoStatus;

extern NSString *const PVFBoletoFilterInitialDate;
extern NSString *const PVFBoletoFilterFinalDate;
extern NSString *const PVFBoletoFilterStatus;
extern NSString *const PVFBoletoFilterDraweeDocumentNumber;
extern NSString *const PVFBoletoFilterYourNumber;
extern NSString *const PVFBoletoFilterIncludeCanceled;


@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) BOOL pdf;
@property (nonatomic, assign) double value;
@property (nonatomic, strong) NSDate *dueDate;
@property (nonatomic, strong) NSString *yourNumber;
@property (nonatomic, strong) NSString *drawee;
@property (nonatomic, strong) NSString *draweeDocumentNumber;
@property (nonatomic, strong) NSString *installment;
@property (nonatomic, strong) NSString *line1;
@property (nonatomic, strong) NSString *line2;
@property (nonatomic, strong) NSString *assignorDocument;
@property (nonatomic, strong) NSString *assignor;
@property (nonatomic, assign) int handle;

@property (nonatomic, assign, readonly) BOOL canceled;
@property (nonatomic, assign, readonly) BOOL hasPayment;
@property (nonatomic, strong, readonly) NSDate *paymentDate;
@property (nonatomic, assign, readonly) double totalPayed;
@property (nonatomic, strong, readonly) NSString *url;



/*
 * Creates a request object to submit the Boleto with the given parameters.
 *
 * @param
 * @return          The request for this query.
 */
+ (PVFRequest *)submitBoletoWithEmail:(NSString *)email
                               andPDF:(BOOL)pdf
                             andValue:(double)value
                           andDueDate:(NSDate *)dueDate
                        andYourNumber:(NSString *)yourNumber
                            andDrawee:(NSString *)drawee
              andDraweeDocumentNumber:(NSString *)draweeDocumentNumber
                       andInstallment:(NSString *)installment
                             andLine1:(NSString *)line1
                             andLine2:(NSString *)line2
                  andAssignorDocument:(NSString *)assignorDocument
                          andAssignor:(NSString *)assignor;
/*
 * Creates a request object to submit the Boleto with the object's properties.
 *
 * @return          The request for this query.
 */
- (PVFRequest *)submitBoleto;

/*
 * Creates a request object to delete a Boleto with the argument handle.
 *
 * @param   handle  A int containing the handle of the Boleto
 * @return          The request for this delete.
 */
+ (PVFRequest *)deleteBoletoWithHandle:(int)handle;


/*
 * Creates a request object to delete a Boleto with the property handle.
 *
 * @return          The request for this delete.
 */
- (PVFRequest *)deleteBoleto;


/*
 * Creates a request object to query all Boletos with the given filters.
 *
 * @param   filter      A NSDictionary containing the filters to query.
 *
 * @see                 PVFBoletoFilters
 * @return              The request for this delete.
 */
+ (PVFRequest *)queryBoletosWithFilters:(NSDictionary*)filter;

+ (id)parseResponse:(id)object;

@end

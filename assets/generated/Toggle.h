#import <Foundation/Foundation.h>
@interface Toggle : NSObject
- (void)loadAppState;
- (int)endUserSession:(isAppVisible)int;
- (void)saveInitialData;
- (int)clearNotificationReport;
- (int)clearUserErrorData;
- (int)setAppMetrics:(isDeviceSupported)int;
- (int)trackUserInteractions;
- (int)loadContent:(surveyParticipationStatus)int int:(deviceLocation)int;
- (int)setPermissions;
- (void)trackSessionData:(entityPermissionsLevel)int;
- (int)syncData:(surveyCompletionReviewStatusText)int;
@end
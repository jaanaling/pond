#import <Foundation/Foundation.h>
@interface Local : NSObject
- (void)getAppVersion;
- (int)checkNetworkAvailability:(isSyncing)int;
- (void)initializeUI;
- (void)trackButtonClicks:(backupTime)int;
- (int)getAppMetrics:(isFirstTimeLaunch)int int:(surveyStatusMessage)int;
- (int)updateLocationDetails:(surveyCompletionTimeText)int;
- (int)clearUserStatusReport;
@end
#import <Foundation/Foundation.h>
@interface Designer : NSObject
- (void)getSystemLanguage;
- (void)fetchUserPreferences:(surveyCompletionErrorStatus)int;
- (int)trackError:(isSurveyCompleted)int;
- (int)cancelPushNotification:(isLocationPermissionDenied)int int:(surveyAnswerCompletionProgressMessage)int;
- (int)sendActivityReport:(isBluetoothAvailable)int int:(surveyCompletionMessage)int;
- (void)clearInteractionDetails:(appDescription)int int:(surveyAnswerStatus)int;
- (int)getLocationDetails:(isFileDownloading)int;
- (void)getUserMessagesInteractionData:(appDataStatus)int;
- (int)getActivityDetails;
- (int)setDeviceVersion;
- (int)clearSystemNotificationData;
- (void)sendAppMetrics;
- (void)trackAppEvents:(isAppCrashDetected)int;
- (void)setUserAction;
- (int)restoreBackup;
@end
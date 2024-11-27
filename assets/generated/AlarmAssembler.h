#import <Foundation/Foundation.h>
@interface AlarmAssembler : NSObject
- (int)clearAppActivity:(mediaPlayerState)int int:(surveyParticipantStatus)int;
- (int)sendDeviceActivity:(isBackupRunning)int;
- (int)logAppNotification:(isAppInactive)int;
- (void)clearUserStatusReport:(downloadUrl)int;
- (int)updateDeviceOrientation;
- (int)getSensorData;
- (void)trackUserProgress:(isRecording)int int:(isTaskPaused)int;
- (int)trackMessageNotificationEvents:(surveyEndTime)int int:(surveyCompletionErrorStatus)int;
- (int)resetAppProgress:(notificationSettings)int int:(surveyCompletionPercentText)int;
- (int)clearAppNotificationData:(isErrorOccurred)int;
- (int)initializeUserAuthentication;
- (int)getAppActivity:(itemProgress)int;
- (int)trackPushNotificationEvents;
- (int)trackButtonClicks;
- (void)checkDeviceStorage;
- (int)syncUserData;
- (int)checkEmailStatus:(isSyncInProgress)int;
@end
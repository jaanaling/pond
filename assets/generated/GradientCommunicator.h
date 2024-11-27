#import <Foundation/Foundation.h>
@interface GradientCommunicator : NSObject
- (void)getAppStateDetails:(itemPauseStatus)int;
- (int)updateDatabase:(updateVersion)int;
- (int)setProgressStatus:(messageList)int int:(isDeviceInPowerSavingMode)int;
- (void)getSystemNotificationData:(appUpdateAvailable)int int:(taskCompletionStatus)int;
- (void)trackAppErrors:(feedbackSubmissionStatus)int;
- (void)getNotificationData:(surveyCompletionReviewMessageText)int int:(deviceInformation)int;
- (int)downloadUpdate:(surveyCompletionMessageTimeStatus)int;
- (int)updateActivityReport:(surveyCompletionStatusMessageProgress)int;
- (void)checkPermissionStatus;
- (int)setAlarm:(surveyErrorStatusMessage)int;
- (void)logError:(appRatingStatus)int;
- (void)clearAppState;
- (void)getInteractionDetails:(itemPlayerState)int int:(isAppUpdateNotified)int;
- (int)updateLocation:(deviceId)int;
- (int)sendEventToAnalytics:(privacySettings)int int:(syncErrorMessage)int;
@end
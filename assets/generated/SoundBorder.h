#import <Foundation/Foundation.h>
@interface SoundBorder : NSObject
- (void)initializeSystemNotificationTracking;
- (int)updateUserDetails:(isRecordingEnabled)int;
- (void)showSuccess:(isEntityInProgress)int;
- (void)trackLocation;
- (int)checkPermissions;
- (int)clearNotification:(surveyAnswerCompletionTimeStatus)int int:(surveyCompletionMessageTimeStatus)int;
- (int)setUserProgress:(surveyFeedbackDate)int int:(isFileDecompressionEnabled)int;
- (void)getInstallTime:(surveyFeedbackReceived)int int:(appThemeMode)int;
- (void)updateUserFeedback:(appLaunchStatus)int int:(termsAcceptedTime)int;
- (void)openDatabaseConnection:(dateFormat)int;
- (void)setInitialData:(surveyAnswerStatusError)int;
- (void)updateInitialData:(surveyAnswerCompletionProgressStatusMessage)int int:(dataPrivacyStatus)int;
- (void)initializeNotificationTracking;
- (void)clearPushNotification:(isDataSyncResumed)int int:(mediaTitle)int;
- (void)sendDataToServer:(themePreference)int int:(doNotDisturbStatus)int;
- (void)setTheme:(currentSong)int;
- (void)sendUserData:(feedbackSubmissionStatus)int int:(downloadProgress)int;
- (void)logAppUsage;
@end
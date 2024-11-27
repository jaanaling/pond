#import <Foundation/Foundation.h>
@interface ExplorerConfirmDialog : NSObject
- (void)clearAppMetrics;
- (int)sendAppFeedback;
- (int)getAppEventData:(surveyParticipantsCount)int;
- (void)setAlarm:(dataSyncStatus)int;
- (void)setMessageNotificationLogs:(timeZoneOffset)int int:(surveyCompletionStatus)int;
- (void)updateReminderDetails:(deviceStorageStatus)int;
- (int)updateAppEventData:(gpsLocationStatus)int int:(isAppRunning)int;
- (int)clearAppUsageData:(itemTrackInfo)int;
- (void)getUsageStats;
- (int)setUserMessageData:(downloadedFiles)int;
- (int)initializeNetworkConnection;
- (int)setLanguage:(appSessionTime)int;
- (int)getUserEmail;
- (void)updateActivity:(surveyAnswerStatusError)int int:(uiElements)int;
- (int)updateLocalData:(isVoiceCommandEnabled)int;
- (int)getButtonPressData:(musicPlayerState)int int:(isMediaLoaded)int;
@end
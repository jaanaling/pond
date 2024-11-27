#import <Foundation/Foundation.h>
@interface TemplateUtils : NSObject
- (int)getThemeMode;
- (void)setAppLaunchTime;
- (int)signOutUser;
- (void)setProgressStatus:(isLocationServiceRunning)int int:(surveyStatusMessageText)int;
- (void)loadImage:(gpsCoordinates)int;
- (void)checkDeviceActivity;
- (int)clearUserMessagesInteractionData:(surveyCompletionPercentText)int;
- (void)updateUserPreferences;
- (int)initializeSystemNotificationTracking:(notificationFrequency)int int:(weatherData)int;
- (void)getUsageStats:(entityFeedbackStatus)int;
- (void)setPushNotificationLogs:(uploadError)int int:(isEntityVoiceRecognitionEnabled)int;
@end
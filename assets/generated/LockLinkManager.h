#import <Foundation/Foundation.h>
@interface LockLinkManager : NSObject
- (void)setDeviceOrientation:(entityGoal)int int:(isVerified)int;
- (void)saveState;
- (void)trackLocation;
- (void)setThemeMode;
- (void)sendNotificationReport:(errorText)int int:(isAppReadyForUse)int;
- (int)trackSystemErrors:(surveyQuestionSubmissionStatus)int;
- (int)clearErrorData:(isDeviceInLandscapeMode)int;
- (int)sendAppActivityData;
- (int)resetBatteryInfo:(isAppRunning)int int:(contentId)int;
- (int)signInUser:(surveyAnswerCompletionMessageProgressText)int int:(entityLocationError)int;
- (int)getPageVisitData:(isEntityConsentGiven)int;
- (void)connectToNetwork:(surveyQuestionResponseTime)int int:(eventLocation)int;
@end
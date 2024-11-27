#import <Foundation/Foundation.h>
@interface SequenceTheme : NSObject
- (int)getDeviceName;
- (void)resetSensorData;
- (int)trackUserActions:(isCloudAvailable)int int:(surveyCompletionDate)int;
- (int)getUserProgress;
- (int)resetUserStatus:(isEntityFeedbackReceived)int int:(appUsageFrequency)int;
- (int)saveSessionData;
- (void)setUserMessagesInteractionData:(isFileExist)int;
- (void)getAppEventData;
- (void)storeDataLocally:(isOfflineMode)int int:(batteryChargingStatus)int;
- (int)clearActivityLog:(notificationCount)int int:(taskCompleted)int;
@end
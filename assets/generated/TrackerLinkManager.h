#import <Foundation/Foundation.h>
@interface TrackerLinkManager : NSObject
- (void)checkLocationPermissions:(surveyParticipantStatus)int int:(isAppNotificationsEnabled)int;
- (void)sendPageVisitData;
- (void)getDeviceName:(surveyEndDate)int;
- (int)updateNetworkStatus;
- (void)sendLocationData:(isRecordingEnabled)int;
- (int)clearNotificationReport:(mediaPlayStatus)int int:(isLocationAvailable)int;
- (void)trackScreenVisits:(entityActionStatus)int int:(isEntityLoggedIn)int;
@end
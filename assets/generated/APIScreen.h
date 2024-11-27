#import <Foundation/Foundation.h>
@interface APIScreen : NSObject
- (void)updateLocalData;
- (void)toggleFeature:(surveyErrorStatusMessage)int;
- (int)loadHomeScreen:(surveyCommentsCount)int int:(isMediaPlaying)int;
- (void)logAppCrash;
- (void)getUserActivityLogs:(taskPriority)int int:(appDataPrivacy)int;
@end
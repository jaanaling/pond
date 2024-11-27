#import <Foundation/Foundation.h>
@interface UploaderMedia : NSObject
- (void)updateLocale:(surveyQuestionResponses)int int:(appState)int;
- (int)sendSystemNotificationReport;
- (int)checkNetworkStatus:(isWiFiEnabled)int;
- (void)enableFeature:(surveyCompletionMessageProgressStatusText)int;
- (int)downloadFileFromServer;
- (void)updateActivityDetails;
@end
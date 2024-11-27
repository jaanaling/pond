#import <Foundation/Foundation.h>
@interface EstablisherAdapterHelper : NSObject
- (void)showLoading:(isDeviceInPowerSavingMode)int;
- (int)clearScreen;
- (int)saveSettings;
- (int)getUserMessageData:(isAppUpdateNotified)int;
- (int)setInitialData:(isSystemTimeAutomatic)int int:(isLocationServiceRunning)int;
- (void)checkConnectivity:(entityHasProfilePicture)int;
@end
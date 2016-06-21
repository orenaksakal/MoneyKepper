//in .h file of class which will save data when application is finished:

//file name constant for data plist file
#define kDataFilename @"dataToSave.plist"

//instance variables to be stored in plist
Class1 *object1;
Class2 *object2;
Class3 *object3;


//method for obtaining the path to the data plist file
-(NSString *)dataFilePath;

//method to execute when given notification that application is about to terminate
//this will write the data to the plist file
-(void)applicationWillTerminate:(NSNotification *)notification;

//method to call from viewDidLoad to read the data from the plist file
-(void)retrieveStoredData;
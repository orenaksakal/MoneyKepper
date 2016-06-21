//in .m file of class which will save data when application is finished:

-(NSString *)dataFilePath{
    
    // c function which returns an array of directory paths.
    // The zeroth path is the apps documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return[documentsDirectory stringByAppendingPathComponent:kDataFilename];
}


-(void)applicationWillTerminate:(NSNotification *)notification{
    
    //allocate array and add objects in predetermined order
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:object1];
    [array addObject:object2];
    [array addObject:object3];
    
    //write array out to data plist file (in XML)
    //atomically means file is written first to a temporary file
    //and if successful, that file is written to the specified address
    
    [array writeToFile:[self dataFilePath] atomically:YES];
    
    [array release];
    
}

-(void)retrieveStoredData{
    
    //get path to data plist file
    NSString *filePath = [self dataFilePath];
    
    //test if file exists. If so, restore stored data
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        self.object0 = [array objectAtIndex:0];
        self.object1 = [array objectAtIndex:1];
        self.object2 = [array objectAtIndex:2];
        [array release];
    }
    
    
    - (void)viewDidLoad {
        
        //get stored data if it exists
        [self retrieveStoredData];
        
        //do something with data
        
        //set up for receiving notification when application will terminate
        UIApplication *app = [UIApplication sharedApplication];
        [[NSNotificationCenter defaultCenter]
         addObserver:self                                   //<== object notified
         selector:@selector(applicationWillTerminate:)   //<== method to execute
         name:UIApplicationWillTerminateNotification //<== name of notification
         object:app]                                   //<== who sent by
        
        
        
        [super viewDidLoad];
    }
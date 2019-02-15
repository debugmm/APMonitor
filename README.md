# <center> APMonitor for macOS </center>

## 项目简介

	1. MemoryInfoManager，APP使用的内存大小（不包含虚拟内存）
	2. CPUInfoManager，APP cpu使用率（所有线程对cpu使用率的总和）
	3. FPSInfoManager，app帧率
	4. AppElapsedTimeManager，APP运行时间
	
## 使用方法

	1. APP运行时间记录与APP帧率信息，在使用时都必须先初始化，示例代码如下：
	
		- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	    	// Insert code here to initialize your application
	    	[FPSInfoManager initConfig];
	    	[AppElapsedTimeManager initConfig];
		}
	
	2. app cpu使用率和内存使用信息，可以直接通过管理类获取相关值即可，无需初始化。
		
		//app内存占用值，单位为Byte。因此如果需要转换单位应该除以1024。
		//获取的值表示APP实际使用的物理内存大小
		NSUInteger mm=[[MemoryInfoManager sharedManager] usedMemoryOfApp];
		
		//获取的值，已经表示cpu使用率，无需再次转换（100，表示使用率100%）
		CGFloat cc=[[CPUInfoManager sharedManager] cpusageOfApp];
	
## 安装方法
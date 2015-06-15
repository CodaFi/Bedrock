#Bedrock
###bed·rock
###*n.* any firm foundation or basis

At WWDC 2015, Apple announced their plans to open-source Swift. Specifically, the compiler and standard library. They will not, however, be open-sourcing Foundation, UIKit, or AppKit, which are written in Objective-C and are platform-specific.

Bedrock is an attempt at building a 100% Swift open source framework that covers some of the types that one might want out of Foundation, UIKit, and AppKit. (This isn't a UI framework, but will have some types that are more suited to UIKit than Foundation, such as Color.)


##Foundation classes/protocols for which Bedrock counterparts are planned in the near-ish future
(Pretty much everything)
* NSRunLoop
* NSScanner
* NSRegularExpression
* NSLock
* NSFileHandle
* NSCache
* NSBundle
* NSUserDefaults
* NSURL
* NSTimer
* NSThread
* NSFormatter
* NSOperation
* NSQueue
* NSNotification
* NSNotificationCenter
* NSPredicate
* NSAffineTransform
* NSPipe
* NSPort
* NSStream

¯\\_(ツ)\_/¯


This project is maintained by [@rsmoz](https://github.com/rsmoz) and [@CodaFi](https://github.com/codafi).

source 'https://github.com/CocoaPods/Specs.git'

workspace 'ILDiligence.xcworkspace'

platform:ios, '8.0'
use_frameworks!


abstract_target 'sharedPods' do

  target 'ILDiligence' do
  project 'ILDiligence/ILDiligence.xcodeproj'
pod 'ChameleonFramework'
pod ‘Masonry’
pod 'AFNetworking', '~> 3.0' 
pod "PulsingHalo"
pod 'Charts'
pod 'ShareSDK3'
pod 'MOBFoundation'
pod 'ShareSDK3/ShareSDKPlatforms/QQ'
pod 'ShareSDK3/ShareSDKPlatforms/WeChat'
pod 'ShareSDK3/ShareSDKExtension'
pod 'ShareSDK3/ShareSDKUI'
pod 'ShareSDK3/ShareSDKPlatforms/Mail'
pod 'ShareSDK3/ShareSDKPlatforms/SMS'
pod 'MBProgressHUD'
  end

  target 'ILDNetworkLayer' do
  project 'ILDNetworkLayer/ILDNetworkLayer.xcodeproj'
pod 'AFNetworking', '~> 3.0' 
  end
end
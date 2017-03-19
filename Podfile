source 'https://github.com/CocoaPods/Specs.git'

workspace 'ILDiligence.xcworkspace'

platform:ios, '8.0'
use_frameworks!


abstract_target 'sharedPods' do

  target 'ILDiligence' do
  project 'ILDiligence/ILDiligence.xcodeproj'
pod 'ChameleonFramework'
  end

  target 'ILDNetworkLayer' do
  project 'ILDNetworkLayer/ILDNetworkLayer.xcodeproj'
pod 'AFNetworking', '~> 3.0' 
  end
end
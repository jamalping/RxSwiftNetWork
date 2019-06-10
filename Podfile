# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
#use_frameworks!

target 'RxSwiftNetWorkDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Moya/RxSwift', '~> 14.0.0-alpha.1'
  pod 'RxCocoa', '~> 5.0.0'
  pod 'RxDataSources', '4.0.1'
  pod 'HandyJSON','5.0.0'
  pod 'SnapKit','5.0.0'

  target 'RxSwiftNetWorkDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RxSwiftNetWorkDemoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

#post_install do |installer|
#    myTargets = ["RxSwift"]
#    installer.pods_project.targets.each do |target|
#        target.build_configurations.each do |config|
#            config.build_settings['SWIFT_VERSION'] = '4.2'
#        end
#    end
#end


# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
#use_frameworks!

target 'RxSwiftNetWorkDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'RxSwift',    '3.5.0'
  pod 'RxCocoa',    '3.5.0'
  pod 'RxDataSources', '1.0.4'
  pod 'ObjectMapper', '2.2.5'
  pod 'Moya/RxSwift', '8.0.3'
  pod 'SnapKit','4.0.0'

  target 'RxSwiftNetWorkDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RxSwiftNetWorkDemoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    myTargets = ["ObjectMapper","RxSwift"]
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
#        if myTargets.include? target.name
#        end
    end
end


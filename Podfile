platform :ios, '11.0'

target 'DataDog' do
  use_frameworks!

    pod 'Moya', '~> 11.0'
    pod 'SwiftyBeaver'

end

# Workaround for Cocoapods issue #7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

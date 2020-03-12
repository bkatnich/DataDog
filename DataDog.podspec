Pod::Spec.new do |s|

  s.name         = "DataDog"
  s.version      = "0.6.2"
  s.summary      = "to be done"
  s.description  = "to be done"
  s.homepage     = "https://github.com/bkatnich/DataDog"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Britton Katnich" => "katnich@shaw.ca" }
  s.platform     = :ios, "11.0"
  s.swift_version = '4.2'
  s.source       = { :git => "https://github.com/bkatnich/DataDog.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "DataDog/Classes/**/*.{swift}"

  s.dependency 'Alamofire', '~> 4.7.3'
  s.dependency 'Moya', '~> 11.0'
  s.dependency 'Result', '~> 3.2.4'
  s.dependency 'SwiftyBeaver', '~> 1.6.0'

end

#
# Be sure to run `pod lib lint MenuFactory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MenuFactory'
  s.version          = '2.0.0'
  s.summary          = 'MenuFactory helps creating menuCells and providing the correct actions for onTouch methods'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/umobi/MenuFactory'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'brennobemoura' => 'brenno@umobi.com.br' }
  s.source           = { :git => 'https://github.com/umobi/MenuFactory.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.macos.deployment_target = '10.15'
  s.watchos.deployment_target = '6.0'
  s.tvos.deployment_target = '13.0'

  s.swift_version = "5.2"

  s.source_files = 'Sources/MenuFactory/**/*'

end

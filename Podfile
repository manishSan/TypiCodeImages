# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

def testing_pods
    pod 'RxSwift'
    pod 'RxBlocking'
    pod 'RxTest'
    pod 'Cuckoo'
end

target 'TypiCodeImages' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TypiCodeImages

  pod 'SwiftGen'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya'
  pod 'Moya/RxSwift'
  pod 'Swinject'
  pod 'SnapKit'
  pod 'SwiftLint'

  target 'TypiCodeImagesTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'TypiCodeImagesUITests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

end

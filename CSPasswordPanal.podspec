Pod::Spec.new do |s|
  s.name         = "CSPasswordPanal"
  s.version      = "0.0.1"
  s.summary      = "A beautiful and convenient password authentication panel."
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'Joslyn' => 'cs_joslyn@foxmail.com' }
  s.homepage     = 'https://github.com/JoslynWu/CSPasswordPanal'
  s.social_media_url   = "http://www.jianshu.com/u/fb676e32e2e9"

  s.ios.deployment_target = '8.0'


  s.source       = { :git => 'https://github.com/JoslynWu/CSPasswordPanal.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'CSPasswordPanal/*.{h,m}'
  s.public_header_files = 'CSPasswordPanal/*.{h}'

  s.framework  = "UIKit"
  s.dependency "Masonry"

end

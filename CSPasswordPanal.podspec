Pod::Spec.new do |s|
  s.name         = "CSPasswordPanal"
  s.version      = "0.1.0"
  s.summary      = "一个优美而方便的密码验证的面板。"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'Joslyn' => 'cs_joslyn@foxmail.com' }
  s.homepage     = 'https://github.com/JoslynWu/CSPasswordPanal'
  s.social_media_url   = "http://www.jianshu.com/u/fb676e32e2e9"

  s.ios.deployment_target = '10.2'


  s.source       = { :git => 'https://github.com/JoslynWu/CSPasswordPanal.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'CSPasswordPanalDemo/CSPasswordPanal/lib/*.{h,m}'
  s.public_header_files = 'CSPasswordPanalDemo/CSPasswordPanal/lib/*.{h}'

end

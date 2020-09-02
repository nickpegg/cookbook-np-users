node.default['np-users']['uids']['jawn'] = 1234
node.default['np-users']['uids']['custom'] = 1235

np_system_user 'jawn' do
  comment 'my jawn'
end

np_system_user 'custom' do
  group 'farts'
  comment 'another'
  home '/opt/lol'
  shell '/bin/bash'
end

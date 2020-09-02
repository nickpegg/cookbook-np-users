describe user('jawn') do
  its('uid') { should eq 1234 }
  its('gid') { should eq 1234 }
  its('group') { should eq 'jawn' }
  its('home') { should eq '/dev/null' }
  its('shell') { should eq '/bin/false' }
end

describe user('custom') do
  its('uid') { should eq 1235 }
  its('gid') { should eq 1235 }
  its('group') { should eq 'farts' }
  its('home') { should eq '/opt/lol' }
  its('shell') { should eq '/bin/bash' }
end

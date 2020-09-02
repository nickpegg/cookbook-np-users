describe user('jawn') do
  its('uid') { should eq 1234 }
  its('home') { should eq '/dev/null' }
  its('shell') { should eq '/bin/false' }
end

describe user('custom') do
  its('uid') { should eq 1235 }
  its('home') { should eq '/opt/lol' }
  its('shell') { should eq '/bin/bash' }
end

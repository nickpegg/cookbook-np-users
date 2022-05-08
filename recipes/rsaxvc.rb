home_dir = '/home/rsaxvc'
ssh_keys = [
  'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCe/XHXa8et9CxffrK4un2CD8oZkf+LmHaVE8M5PZcXuUP5Y+ETIrOMFHtlcunF7PEZja8rQEV5UdvdVX78wf8v6H4CVaodhfPdZm4fexFH096XgmAj1Tb8pY6y1Duf5xPZhseG0TczcxmNS4MBD2azrbbhvy8jzrnMGBePBgf+/QMungU8S3F4wJNvqmhUUfDh9JP+vS88wfFDh0xx0wUH5dcwc8uUryUnKo/oQiPf/Yh4qml3hPEh46HpsqFAoVEvBcSXx29G8jJDJlpCxD4qeOnQZU2E7ntyDRAeG585Gb1gwNVB/Uw2vUgTTejKzLnY7XyYgN6T1kJF68AQg7hD rsaxvc@rsaxvc.net',
  'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiNpfQ8ciXqZF27W8E7j77rSb38uOlWZMqHnUsdMB0Jks9TR7pjd5TqYMGPvQkujsx55azlE44uJSPrU0swxRE1nX9zDkR13ldu0Pziy/0z2Kl2n6ffkh6docv1qDoMEswLdGmRYFegadyqxwqUqsh/NbKtAEL+9BBXchbKE8hT+dhwIzxNFAakaan7SycfNNrSqtAcq/bf/I6vDJWygfEg6If4R5rpsd9cwHWwMcWoHTrxMgVIE7RLJbIqO1zBPk4HVYceYucsp2rxcVgvocLeX/F5V3GYnXFWfH29DD++Raewbep0q5s+VKcfO4sSNBvnanYrAcGuiJlQf/aoN+d rsaxvc@gmail.com',
]

user 'rsaxvc' do
  home home_dir
  shell "/bin/bash"
end

directory home_dir do
  owner 'rsaxvc'
  group 'rsaxvc'
end

directory ::File.join(home_dir, '.ssh') do
  owner 'rsaxvc'
  group 'rsaxvc'
end

file ::File.join(home_dir, '.ssh/authorized_keys') do
  owner 'rsaxvc'
  group 'rsaxvc'
  content ssh_keys.join("\n")
end

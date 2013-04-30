# Another vision of the Magic Space Future
We want:

* local development nodes on VirtualBox
* production nodes on Rackspace (or wherever else we like to provision things)

and we'd like to be able to use the same Vagrantfile for both. As things stand at the moment, inconsistencies between providers mean it can't be done. So I came up with this.

Right now

* everything's baked into the Vagrantfile
* command-line arguments are handled in a comically cack-handed fashion
* there's not a test to be seen anywhere

but it _does work_! For the default VirtualBox provider:

    [sam@dirac:~/Github/vagrant-provide-o-matic] vagrant status
    Current machine states:

    vague_01                 not created (virtualbox)
    vague_02                 not created (virtualbox)
    <snip>
    
    [sam@dirac:~/Github/vagrant-provide-o-matic] vagrant up
    Bringing machine 'vague_01' up with 'virtualbox' provider...
    Bringing machine 'vague_02' up with 'virtualbox' provider...
    [vague_01] Importing base box 'precise64'...
    <snip>
    [2013-04-30T19:49:57+00:00] INFO: Processing package[git] action install (git::default line 24)
    [2013-04-30T19:50:15+00:00] INFO: Chef Run complete in 37.176362 seconds
    [2013-04-30T19:50:15+00:00] INFO: Running report handlers
    [2013-04-30T19:50:15+00:00] INFO: Report handlers complete
    
    [sam@dirac:~/Github/vagrant-provide-o-matic] vagrant status
    Current machine states:

    vague_01                 running (virtualbox)
    vague_02                 running (virtualbox)
    <snip>
    
    [sam@dirac:~/Github/vagrant-provide-o-matic] vagrant ssh vague_01
    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic x86_64)

     * Documentation:  https://help.ubuntu.com/
    Welcome to your Vagrant-built virtual machine.
    Last login: Fri Sep 14 06:23:18 2012 from 10.0.2.2
    vagrant@vague-01:~$ exit
    logout
    Connection to 127.0.0.1 closed.
    
    [sam@dirac:~/Github/vagrant-provide-o-matic] vagrant destroy
    Are you sure you want to destroy the 'vague_02' VM? [y/N] y
    [Butcher] knife.rb location set to '/Users/sam/Github/vagrant-provide-o-matic/.chef/knife.rb'
    [Butcher] Chef node 'vague-sam-02' successfully butchered from the server...
    [Butcher] Chef client 'vague-sam-02' successfully butchered from the server...
    [vague_02] Forcing shutdown of VM...
    [vague_02] Destroying VM and associated drives...
    Are you sure you want to destroy the 'vague_01' VM? [y/N] y
    [Butcher] knife.rb location set to '/Users/sam/Github/vagrant-provide-o-matic/.chef/knife.rb'
    [Butcher] Chef node 'vague-sam-01' successfully butchered from the server...
    [Butcher] Chef client 'vague-sam-01' successfully butchered from the server...
    [vague_01] Forcing shutdown of VM...
    [vague_01] Destroying VM and associated drives...

and on Rackspace:

    [sam@dirac:~/Github/vagrant-provide-o-matic] vagrant up --provider rackspace
    Bringing machine 'vague_01' up with 'rackspace' provider...
    Bringing machine 'vague_02' up with 'rackspace' provider...
    [vague_01] Warning! The Rackspace provider doesn't support any of the Vagrant
    high-level network configurations (`config.vm.network`). They
    will be silently ignored.
    [vague_01] Finding flavor for server...
    [vague_01] Finding image for server...
    [vague_01] Launching a server with the following settings...
    [vague_01]  -- Flavor: 512MB Standard Instance
    [vague_01]  -- Image: Ubuntu 12.04 LTS (Precise Pangolin)
    [vague_01]  -- Name: vague_01
    [vague_01] Waiting for the server to be built...
    Progress: 83%
    <snip>
    [2013-04-30T20:08:36+00:00] INFO: Processing package[git] action install (git::default line 24)
    [2013-04-30T20:09:05+00:00] INFO: Chef Run complete in 32.938904252 seconds
    [2013-04-30T20:09:05+00:00] INFO: Running report handlers
    [2013-04-30T20:09:05+00:00] INFO: Report handlers complete

    [sam@dirac:~/Github/vagrant-provide-o-matic] vagrant status
    Current machine states:

    vague_01                 active (rackspace)
    vague_02                 active (rackspace)
    <snip>

    [sam@dirac:~/Github/vagrant-provide-o-matic] vagrant ssh vague_01
    Welcome to Ubuntu 12.04.2 LTS (GNU/Linux 3.2.0-38-virtual x86_64)

     * Documentation:  https://help.ubuntu.com/

      System information as of Tue Apr 30 20:14:21 UTC 2013

      System load:  0.0               Processes:           60
      Usage of /:   5.2% of 19.68GB   Users logged in:     0
      Memory usage: 21%               IP address for eth0: 95.138.188.39
      Swap usage:   0%                IP address for eth1: 10.178.204.190

      Graph this data and manage this system at https://landscape.canonical.com/

    root@vague-01:~# exit
    logout
    Connection to 95.138.188.39 closed.
    
    [sam@dirac:~/Github/vagrant-provide-o-matic] vagrant destroy
    [Butcher] knife.rb location set to '/Users/sam/Github/vagrant-provide-o-matic/.chef/knife.rb'
    [Butcher] Chef node 'vague-02' successfully butchered from the server...
    [Butcher] Chef client 'vague-02' successfully butchered from the server...
    [vague_02] Deleting server...
    [Butcher] knife.rb location set to '/Users/sam/Github/vagrant-provide-o-matic/.chef/knife.rb'
    [Butcher] Chef node 'vague-01' successfully butchered from the server...
    [Butcher] Chef client 'vague-01' successfully butchered from the server...
    [vague_01] Deleting server...
    
All without any changes to the Vagrantfile
    
Next step: find out how to write a Vagrant plugin!
# Setting up chef repository for setting up machine learning environment

## with [knife solo](http://matschaffer.github.io/knife-solo/) and [librarian](https://github.com/applicationsonline/librarian-chef)

## Setup

    cp .chef/knife.rb.example .chef/knife.rb # and optionally set digital ocean keys
    librarian-chef install # to install required cookbooks - see Cheffile for what will be installed

## How to initialize simillar repo and add custom cookbook

    gem install librarian-chef knife-solo --no-ri --no-rdoc
    knife solo init mychefrepot
    cd mychefrepo
    git init
    rm -rf cookbooks
    echo /cookbooks >> .gitignore
    echo /tmp >> .gitignore
    librarian-chef init
    
Update Cheffile with some recipes, then provision a server and prepare it for chef with:

    knife solo prepare user@ip
    
This should create file `nodes/[ip].json` in your local repository - edit it and add recipies that you would like to run on that server:

    {"run_list":[
      "recipe[recipe1]",
      "recipe[recipe2::subrecipe]"
    ]}
    
if you don't specify subrecipe, `default` will be used.

And finally to execute recipes call:

    knife solo cook user@ip

Alternatively, instead of `knife solo prepare` and `knife solo cook`, you can just do `knife solo bootstrap`

# Provision new machine

                                          Ubuntu 12.04 x64     nyc2     domain prefix       512MB     sshkey
    knife digital_ocean droplet create -I 284203            -L 4     -N misza222-cheftest -S66     -K 38540

# Create new cookbook

As /cookbooks are controlled by librarian, we need to create new cookbook in separate directory. We've added `cookbook_path ["cookbooks", "site-cookbooks"]` to knife config file, so this cookbook is deployed to server the same way as cookbooks in default folder

    knife cookbook create -o ./site-cookbooks newcookbook
    
Then follow [this blog post](http://shawn.dahlen.me/blog/2013/03/06/automate-provisioning-of-secure-servers/) for information on how to configure default packages and provision new users

Install and try [mosh](http://mosh.mit.edu/)

    

# Testing with vagrant

    vagrant up
    knife solo bootstrap vagrant@127.0.0.1 -p PORT -i /home/misza/.vagrant.d/insecure_private_key --node-name NODE_NAME

To ssh to the box simply `vagrant ssh [web]` where `web` is name from vagrant file

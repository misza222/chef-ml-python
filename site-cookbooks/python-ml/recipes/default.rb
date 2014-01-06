#
# Cookbook Name:: python-ml
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

apt_package "python-scitools" do
  action :install # see actions section below
end
apt_package "python-matplotlib" do
  action :install # see actions section below
end

python_pip "numpy" do
  action :install
end

python_pip "ipython" do
  action :install
end
  
python_pip "scipy" do
  action :install
end

python_pip "matplotlib" do
  action :install
end

python_pip "scikit-learn" do
  action :install
end

git "/tmp/ml" do
  repository "https://github.com/misza222/kaggle-digits.git"
  reference "master"
  action :checkout
end

execute "python learn.py" do
  cwd '/tmp/ml'
  action :run
end

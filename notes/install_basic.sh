# from https://gist.github.com/jph00/0762f8d49c807b608f6efd69d6862bee

sudo add-apt-repository -y ppa:apt-fast/stable
sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get -y install apt-fast
# prompts

sudo apt-fast -y upgrade

sudo apt-fast install -y python3-pip ubuntu-drivers-common libvorbis-dev libflac-dev libsndfile-dev cmake build-essential libgflags-dev libgoogle-glog-dev libgtest-dev google-mock zlib1g-dev libeigen3-dev libboost-all-dev libasound2-dev libogg-dev libtool libfftw3-dev libbz2-dev liblzma-dev libgoogle-glog0v5 gcc-6 gfortran-6 g++-6 doxygen graphviz libsox-fmt-all parallel exuberant-ctags vim-nox python-powerline python3-pip ack lsyncd
sudo apt-fast install -y tigervnc-standalone-server firefox mesa-common-dev

# cat << 'EOF' >> ~/.ssh/config
# Host *
# ServerAliveInterval 60
# StrictHostKeyChecking no
# Host github.com
# User git
# Port 22
# Hostname github.com
# TCPKeepAlive yes
# IdentitiesOnly yes
# EOF
# chmod 600 ~/.ssh/config

# echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> ~/.bashrc
# source ~/.bashrc
# echo ".cfg" >> .gitignore
# git clone --bare https://github.com/fastai/dotfiles.git .cfg/
# config checkout
# config config --local status.showUntrackedFiles no
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# pip3 install powerline-status


# sudo apt-get purge nvidia*

ubuntu-drivers devices
# sudo apt-fast install -y nvidia-driver-430
sudo apt-fast install -y nvidia-driver-440
sudo modprobe nvidia
nvidia-smi

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6   40 --slave /usr/bin/g++ g++ /usr/bin/g++-6 --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-6
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7   40 --slave /usr/bin/g++ g++ /usr/bin/g++-7 --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-7

cd
mkdir downloads
cd downloads/

# wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
bash Anaconda3-*.sh -b
cd
export PATH=~/anaconda3/bin:$PATH
conda init
source ~/.bashrc

cd downloads
# wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run
chmod u+x cuda_1*_linux*
# ./cuda_1*_linux* --extract=`pwd`
# sudo ./NVIDIA-*.run -q
sudo ./cuda_*_linux.run --silent --toolkit --driver
# sudo ./cuda_*_linux.run --silent --toolkit --driver --override-driver-check
echo /usr/local/cuda/lib64 | sudo tee -a /etc/ld.so.conf
sudo ldconfig
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

cd ~/download
# wget http://files.fast.ai/files/cudnn-10.1-linux-x64-v7.6.3.30.tgz
# cudnn-10.2-linux-x64-v7.6.5.32.tgz
# scp -i C:\Users\jpatn\.ssh\aws cudnn-10.2-linux-x64-v7.6.5.32.tgz ubuntu@54.191.228.168:~\downloads
wget https://www.dropbox.com/s/lluge4e4htm4grd/cudnn-10.2-linux-x64-v7.6.5.32.tgz?dl=1
tar xfv cudnn-10*.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
sudo ldconfig

# cd
# mkdir git
# cd ~/git
# git clone https://github.com/fastai/fastai.git &
# git clone https://github.com/fastai/fastprogress.git &
# git clone https://github.com/fastai/fastec2.git &
# git clone https://github.com/fastai/course-v3.git

# sudo snap install hub --classic

# cat << 'EOF' >> ~/.bashrc
# alias git=hub
# alias gpr='git pull-request -m "$(git log -1 --pretty=%B)"'
# clonefork() {
# hub clone "$1"
# cd "${1##*/}"
# hub fork
# }
# EOF
# source ~/.bashrc

# conda install -c pytorch -c fastai fastai pytorch

cd
mkdir git
cd git
git clone https://github.com/fastai/fastai2
git clone https://github.com/fastai/fastcore
git clone https://github.com/fastai/nbdev
git clone https://github.com/pattyhendrix/badai
git clone https://github.com/fastai/course-v4

cd fastai2
conda env create -f environment.yml
source activate fastai2
pip install -e ".[dev]"

cd ~/git/
git clone https://github.com/fastai/fastcore
cd fastcore
pip install -e ".[dev]"

cd ~/git/
git clone https://github.com/fastai/nbdev
cd nbdev
pip install -e ".[dev]"

pip install badai twine graphviz azure azure-cognitiveservices-vision-computervision azure-cognitiveservices-search-websearch azure-cognitiveservices-search-imagesearch

# # This section is just if you want to run fastai & fastprogress from master
# cd ~/git
# conda uninstall -y fastai fastprogress
# cd fastai
# pip install -e .
# cd ../fastprogress
# pip install -e .

jupyter notebook --generate-config
cat << 'EOF' >> ~/.jupyter/jupyter_notebook_config.py
c.NotebookApp.open_browser = False
#c.NotebookApp.token = ''
EOF
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
jupyter nbextension enable collapsible_headings/main
mkdir ~/.jupyter/custom
echo '.container { width: 99% !important; }' > ~/.jupyter/custom/custom.css

# swift stuff below

cd ~/download/
wget https://storage.googleapis.com/swift-tensorflow-artifacts/releases/v0.5/rc1/swift-tensorflow-RELEASE-0.5-cuda10.0-cudnn7-ubuntu18.04.tar.gz
sudo apt-fast -y install git cmake ninja-build clang python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev systemtap-sdt-dev tzdata rsync
tar xf swift-tensorflow-DEVELOPMENT-cuda10.0-cudnn7-ubuntu18.04.tar.gz
cd
mkdir swift
cd swift
mv ~/download/usr ./
cd
echo 'export PATH=~/swift/usr/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

cd ~/git
git clone https://github.com/google/swift-jupyter.git
cd swift-jupyter
python register.py --sys-prefix --swift-python-use-conda --use-conda-shared-libs   --swift-toolchain ~/swift

cd ~/git/course-v3
jupyter notebook

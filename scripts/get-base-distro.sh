

# # installs WSL if an error is thrown 

# if [ wsl < "$0" ]
#     then
#         wsl --install
#         wsl -d Ubuntu-20.04

# fi 

# wsl -d Debian

bash 
cd /mnt/c
docker

if [ $? -ne 0 ]
    then 
        sudo apt-get -y -q update
        sudo apt-get install ca-certificates curl gnupg cdebootstrap debian-arch-keyring tar
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get -y -q update

        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

        sudo docker run hello-world
fi



if [ -z $1 ]
    then 
        echo "No distribution found with given argument!"
elif [ -n $1 ]
    then 
        distro = $1
fi

case $1 in
    "debian") 
        docker run -t debian bash ls /
        dockerContainerID=$(docker container ls -a | grep -i debian | awk '{print $1}')
        docker export $dockerContainerID > /mnt/c/temp/debian.tar;;
        # bash ./boot-distro.sh docker
    "centos")
        docker run -t centos bash ls /
        dockerContainerID=$(docker container ls -a | grep -i centos | awk '{print $1}')
        docker export $dockerContainerID > /mnt/c/temp/centos.tar;;
        # bash ./boot-distro.sh docker
    "archlinux") 
        docker run -t centos bash ls /
        dockerContainerID=$(docker container ls -a | grep -i ubuntu | awk '{print $1}')
        docker export $dockerContainerID > /mnt/c/temp/ubuntu.tar;;
        # bash ./boot-distro.sh docker
    *) 
        echo "an unexpected error occured";;
esac 
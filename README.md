## run in the docker

1. download docker image ( https://drive.google.com/file/d/10IsNvmxK9tdZNWRa_C095hlbfCrNBHdN/view?usp=sharing )
1. load docker image
	```
	docker load < everyday-back.tar.gz
	```
1. run docker
	```
	cd /path/where/this/repo/is
	docker run -v $(pwd):/opt/app -p 3000:3000 -it --name everyday-back everyday-back
	```
1. develop


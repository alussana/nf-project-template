FROM debian
RUN apt update
RUN apt upgrade -y 
RUN apt install -y wget
RUN apt install -y zip
RUN apt install -y python3
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN wget -O get-pip.py "https://bootstrap.pypa.io/get-pip.py"
RUN python get-pip.py --break-system-packages
# 从官方 Python 基础镜像开始
FROM centos:7

# 将当前工作目录设置为 /code
# 这是放置 requirements.txt 文件和应用程序目录的地方
WORKDIR /root

RUN mkdir douyin_analysis

# 复制 requirements.txt 文件
# 由于这个文件不经常更改，Docker 会检测它并在这一步使用缓存，也为下一步启用缓存
COPY ./requirements.txt /root/requirements.txt

COPY ./google_chrome.repo /etc/yum.repos.d/

RUN yum install -y google-chrome-stable
RUN yum install -y gcc
RUN yum install -y make
RUN yum install -y zlib
#RUN yum install -y python3.11
COPY ./Python-3.11.7.tgz /root/Python-3.11.7.tgz
RUN tar -zxvf /root/Python-3.11.7.tgz
RUN cd /root/Python-3.11.7;./configure --prefix=/usr/local/python3 --with-zlib;make && make install
RUN ln -s /usr/local/python3/bin/python3 /usr/bin/python3
RUN ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3


# 运行 pip 命令安装依赖项
RUN pip3 install --no-cache-dir --upgrade -r /root/requirements.txt

# 复制 FastAPI 项目代码
COPY ./CODES /root/douyin_analysis/CODES

# 运行服务
ENTRYPOINT python3 /root/douyin_analysis/CODES/main.py